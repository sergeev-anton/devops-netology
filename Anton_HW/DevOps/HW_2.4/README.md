1.Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git show aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

diff --git a/CHANGELOG.md b/CHANGELOG.md
index 86d70e3e0..588d807b1 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -27,6 +27,7 @@ BUG FIXES:
 * backend/s3: Prefer AWS shared configuration over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Prefer ECS credentials over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Remove hardcoded AWS Provider messaging ([#25134](https://github.com/hashicorp/terraform/issues/25134))
+* command: Fix bug with global `-v`/`-version`/`--version` flags introduced in 0.13.0beta2 [GH-25277]
 * command/0.13upgrade: Fix `0.13upgrade` usage help text to include options ([#25127](https://github.com/hashicorp/terraform/issues/25127))
 * command/0.13upgrade: Do not add source for builtin provider ([#25215](https://github.com/hashicorp/terraform/issues/25215))
 * command/apply: Fix bug which caused Terraform to silently exit on Windows when using absolute plan path ([#25233](https://github.com/hashicorp/terraform/issues/25233))

Полный хеш коммита aefea - aefead2207ef7e2aa5dc81a34aedf0cad4c32545

Комментарий к коммиту - Update CHANGELOG.md

2. Какому тегу соответствует коммит 85024d3?
Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git tag --points-at 85024d3
v0.12.23

Коммиту 85024d3 соответствует тег v0.12.23

3. Сколько родителей у коммита b8d720? Напишите их хеши.

Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git show --pretty=format:' %P' b8d720
 56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

У коммита b8d720 2 родителя 
 хеш 1 56cd7859e05c36c06b56d013b55a252d0bb7e158 
 хеш 2 9ea88f22fc6269854151c571162c5bcf958bee2b


4.Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24

Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git log --oneline v0.12.23...v0.12.24
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release


5.Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git log --oneline -p -S'func providerSource'
5af1e6234 main: Honor explicit provider_installation CLI config when present
diff --git a/provider_source.go b/provider_source.go
index 8e91658a8..bfbdf0f3f 100644
--- a/provider_source.go
+++ b/provider_source.go
@@ -1,28 +1,76 @@
 package main

 import (
+       "fmt"
        "log"
        "os"
        "path/filepath"

        "github.com/apparentlymart/go-userdirs/userdirs"
+       svchost "github.com/hashicorp/terraform-svchost"
        "github.com/hashicorp/terraform-svchost/disco"

        "github.com/hashicorp/terraform/addrs"
        "github.com/hashicorp/terraform/command/cliconfig"
        "github.com/hashicorp/terraform/internal/getproviders"
+       "github.com/hashicorp/terraform/tfdiags"
 )

 // providerSource constructs a provider source based on a combination of the
 // CLI configuration and some default search locations. This will be the
 // provider source used for provider installation in the "terraform init"
 // command, unless overridden by the special -plugin-dir option.
-func providerSource(services *disco.Disco) getproviders.Source {
-       // We're not yet using the CLI config here because we've not implemented
-       // yet the new configuration constructs to customize provider search
-       // locations. That'll come later. For now, we just always use the
-       // implicit default provider source.
-       return implicitProviderSource(services)
+func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
+       if len(configs) == 0 {
+               // If there's no explicit installation configuration then we'll build
+               // up an implicit one with direct registry installation along with
+               // some automatically-selected local filesystem mirrors.
+               return implicitProviderSource(services), nil
+       }
+
+       // There should only be zero or one configurations, which is checked by
+       // the validation logic in the cliconfig package. Therefore we'll just
+       // ignore any additional configurations in here.
+       config := configs[0]
+       return explicitProviderSource(config, services)
+}
+
+func explicitProviderSource(config *cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
+       var diags tfdiags.Diagnostics
+       var searchRules []getproviders.MultiSourceSelector
+
+       for _, sourceConfig := range config.Sources {
+               source, moreDiags := providerSourceForCLIConfigLocation(sourceConfig.Location, services)
+               diags = diags.Append(moreDiags)
+               if moreDiags.HasErrors() {
+                       continue
+               }
+
+               include, err := getproviders.ParseMultiSourceMatchingPatterns(sourceConfig.Include)
+               if err != nil {
+                       diags = diags.Append(tfdiags.Sourceless(
+                               tfdiags.Error,
+                               "Invalid provider source inclusion patterns",
+                               fmt.Sprintf("CLI config specifies invalid provider inclusion patterns: %s.", err),
+                       ))
+               }
+               exclude, err := getproviders.ParseMultiSourceMatchingPatterns(sourceConfig.Include)
+               if err != nil {
+                       diags = diags.Append(tfdiags.Sourceless(
+                               tfdiags.Error,
+                               "Invalid provider source exclusion patterns",
+                               fmt.Sprintf("CLI config specifies invalid provider exclusion patterns: %s.", err),
+                       ))
+               }
+
+               searchRules = append(searchRules, getproviders.MultiSourceSelector{
+                       Source:  source,
+                       Include: include,
+                       Exclude: exclude,
+               })
+       }
+
+       return getproviders.MultiSource(searchRules), diags
 }

 // implicitProviderSource builds a default provider source to use if there's
@@ -130,3 +178,36 @@ func implicitProviderSource(services *disco.Disco) getproviders.Source {

        return getproviders.MultiSource(searchRules)
 }
+
+func providerSourceForCLIConfigLocation(loc cliconfig.ProviderInstallationSourceLocation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
+       if loc == cliconfig.ProviderInstallationDirect {
+               return getproviders.NewMemoizeSource(
+                       getproviders.NewRegistrySource(services),
+               ), nil
+       }
+
+       switch loc := loc.(type) {
+
+       case cliconfig.ProviderInstallationFilesystemMirror:
+               return getproviders.NewFilesystemMirrorSource(string(loc)), nil
+
+       case cliconfig.ProviderInstallationNetworkMirror:
+               host, err := svchost.ForComparison(string(loc))
+               if err != nil {
+                       var diags tfdiags.Diagnostics
+                       diags = diags.Append(tfdiags.Sourceless(
+                               tfdiags.Error,
+                               "Invalid hostname for provider installation source",
+                               fmt.Sprintf("Cannot parse %q as a hostname for a network provider mirror: %s.", string(loc), err),
+                       ))
+                       return nil, diags
+               }
+               return getproviders.NewNetworkMirrorSource(host), nil
+
+       default:
+               // We should not get here because the set of cases above should
+               // be comprehensive for all of the
+               // cliconfig.ProviderInstallationLocation implementations.
+               panic(fmt.Sprintf("unexpected provider source location type %T", loc))
+       }
+}
8c928e835 main: Consult local directories as potential mirrors of providers
diff --git a/provider_source.go b/provider_source.go
new file mode 100644
index 000000000..9524e0985
--- /dev/null
+++ b/provider_source.go
@@ -0,0 +1,89 @@
+package main
+
+import (
+       "log"
+       "os"
+       "path/filepath"
+
+       "github.com/apparentlymart/go-userdirs/userdirs"
+
+       "github.com/hashicorp/terraform-svchost/disco"
+       "github.com/hashicorp/terraform/command/cliconfig"
+       "github.com/hashicorp/terraform/internal/getproviders"
+)
+
+// providerSource constructs a provider source based on a combination of the
+// CLI configuration and some default search locations. This will be the
+// provider source used for provider installation in the "terraform init"
+// command, unless overridden by the special -plugin-dir option.
+func providerSource(services *disco.Disco) getproviders.Source {
+       // We're not yet using the CLI config here because we've not implemented
+       // yet the new configuration constructs to customize provider search
+       // locations. That'll come later.
+       // For now, we have a fixed set of search directories:
+       // - The "terraform.d/plugins" directory in the current working directory,
+       //   which we've historically documented as a place to put plugins as a
+       //   way to include them in bundles uploaded to Terraform Cloud, where
+       //   there has historically otherwise been no way to use custom providers.
+       // - The "plugins" subdirectory of the CLI config search directory.
+       //   (thats ~/.terraform.d/plugins on Unix systems, equivalents elsewhere)
+       // - The "plugins" subdirectory of any platform-specific search paths,
+       //   following e.g. the XDG base directory specification on Unix systems,
+       //   Apple's guidelines on OS X, and "known folders" on Windows.
+       //
+       // Those directories are checked in addition to the direct upstream
+       // registry specified in the provider's address.
+       var searchRules []getproviders.MultiSourceSelector
+
+       addLocalDir := func(dir string) {
+               // We'll make sure the directory actually exists before we add it,
+               // because otherwise installation would always fail trying to look
+               // in non-existent directories. (This is done here rather than in
+               // the source itself because explicitly-selected directories via the
+               // CLI config, once we have them, _should_ produce an error if they
+               // don't exist to help users get their configurations right.)
+               if info, err := os.Stat(dir); err == nil && info.IsDir() {
+                       log.Printf("[DEBUG] will search for provider plugins in %s", dir)
+                       searchRules = append(searchRules, getproviders.MultiSourceSelector{
+                               Source: getproviders.NewFilesystemMirrorSource(dir),
+                       })
+               } else {
+                       log.Printf("[DEBUG] ignoring non-existing provider search directory %s", dir)
+               }
+       }
+
+       addLocalDir("terraform.d/plugins") // our "vendor" directory
+       cliConfigDir, err := cliconfig.ConfigDir()
+       if err != nil {
+               addLocalDir(filepath.Join(cliConfigDir, "plugins"))
+       }
+
+       // This "userdirs" library implements an appropriate user-specific and
+       // app-specific directory layout for the current platform, such as XDG Base
+       // Directory on Unix, using the following name strings to construct a
+       // suitable application-specific subdirectory name following the
+       // conventions for each platform:
+       //
+       //   XDG (Unix): lowercase of the first string, "terraform"
+       //   Windows:    two-level heirarchy of first two strings, "HashiCorp\Terraform"
+       //   OS X:       reverse-DNS unique identifier, "io.terraform".
+       sysSpecificDirs := userdirs.ForApp("Terraform", "HashiCorp", "io.terraform")
+       for _, dir := range sysSpecificDirs.DataSearchPaths("plugins") {
+               addLocalDir(dir)
+       }
+
+       // Last but not least, the main registry source! We'll wrap a caching
+       // layer around this one to help optimize the several network requests
+       // we'll end up making to it while treating it as one of several sources
+       // in a MultiSource (as recommended in the MultiSource docs).
+       // This one is listed last so that if a particular version is available
+       // both in one of the above directories _and_ in a remote registry, the
+       // local copy will take precedence.
+       searchRules = append(searchRules, getproviders.MultiSourceSelector{
+               Source: getproviders.NewMemoizeSource(
+                       getproviders.NewRegistrySource(services),
+               ),
+       })
+
+       return getproviders.MultiSource(searchRules)
+}
 ESCOC
t implemented
er search


king directory,
plugins as a
loud, where
stom providers.
rectory.
ents elsewhere)
arch paths,
 Unix systems,
dows.

upstream




fore we add it,
 trying to look
rather than in
rectories via the
an error if they
ns right.)
Dir() {
r plugins in %s", dir)
ers.MultiSourceSelector{
irrorSource(dir),


rovider search directory %s", dir)



y





pecific and
such as XDG Base
onstruct a
g the



"HashiCorp\Terraform"
rm".
, "io.terraform")
s") {



 a caching
rk requests
veral sources
).
is available
egistry, the

elector{







 ESCOD
+func providerSource(services *disco.Disco) getproviders.Source {
+       // We're not yet using the CLI config here because we've not implemented
+       // yet the new configuration constructs to customize provider search
+       // locations. That'll come later.
+       // For now, we have a fixed set of search directories:
+       // - The "terraform.d/plugins" directory in the current working directory,
+       //   which we've historically documented as a place to put plugins as a
+       //   way to include them in bundles uploaded to Terraform Cloud, where
+       //   there has historically otherwise been no way to use custom providers.
+       // - The "plugins" subdirectory of the CLI config search directory.
+       //   (thats ~/.terraform.d/plugins on Unix systems, equivalents elsewhere)
+       // - The "plugins" subdirectory of any platform-specific search paths,
+       //   following e.g. the XDG base directory specification on Unix systems,
+       //   Apple's guidelines on OS X, and "known folders" on Windows.
+       //
+       // Those directories are checked in addition to the direct upstream
+       // registry specified in the provider's address.
+       var searchRules []getproviders.MultiSourceSelector
+
+       addLocalDir := func(dir string) {
+               // We'll make sure the directory actually exists before we add it,
+               // because otherwise installation would always fail trying to look
+               // in non-existent directories. (This is done here rather than in
+               // the source itself because explicitly-selected directories via the
+               // CLI config, once we have them, _should_ produce an error if they
+               // don't exist to help users get their configurations right.)
+               if info, err := os.Stat(dir); err == nil && info.IsDir() {
+                       log.Printf("[DEBUG] will search for provider plugins in %s", dir)
+                       searchRules = append(searchRules, getproviders.MultiSourceSelector{
+                               Source: getproviders.NewFilesystemMirrorSource(dir),
+                       })
+               } else {
+                       log.Printf("[DEBUG] ignoring non-existing provider search directory %s", dir)
+               }
+       }
+
+       addLocalDir("terraform.d/plugins") // our "vendor" directory
+       cliConfigDir, err := cliconfig.ConfigDir()
+       if err != nil {
+               addLocalDir(filepath.Join(cliConfigDir, "plugins"))
+       }
+
+       // This "userdirs" library implements an appropriate user-specific and
+       // app-specific directory layout for the current platform, such as XDG Base
+       // Directory on Unix, using the following name strings to construct a
+       // suitable application-specific subdirectory name following the
+       // conventions for each platform:
+       //
+       //   XDG (Unix): lowercase of the first string, "terraform"
+       //   Windows:    two-level heirarchy of first two strings, "HashiCorp\Terraform"
+       //   OS X:       reverse-DNS unique identifier, "io.terraform".
+       sysSpecificDirs := userdirs.ForApp("Terraform", "HashiCorp", "io.terraform")
+       for _, dir := range sysSpecificDirs.DataSearchPaths("plugins") {
+               addLocalDir(dir)
+       }
+
+       // Last but not least, the main registry source! We'll wrap a caching
+       // layer around this one to help optimize the several network requests
+       // we'll end up making to it while treating it as one of several sources
+       // in a MultiSource (as recommended in the MultiSource docs).
+       // This one is listed last so that if a particular version is available
+       // both in one of the above directories _and_ in a remote registry, the
+       // local copy will take precedence.
+       searchRules = append(searchRules, getproviders.MultiSourceSelector{
+               Source: getproviders.NewMemoizeSource(
+                       getproviders.NewRegistrySource(services),
+               ),
+       })
+
+       return getproviders.MultiSource(searchRules)
+}


Функция func providerSource(services disco.Disco) коммите 5af1e6234 была удалена , а в коммите 8c928e835 создана.


6.Найдите все коммиты в которых была изменена функция globalPluginDirs 


Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git grep --count globalPluginDirs
commands.go:2
internal/command/cliconfig/config_unix.go:1
plugins.go:2

Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git log -L:globalPluginDirs:plugins.go
commit 78b12205587fe839f10d946ea3fdc06719decb05
Author: Pam Selle <204372+pselle@users.noreply.github.com>
Date:   Mon Jan 13 16:50:05 2020 -0500

    Remove config.go and update things using its aliases

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -16,14 +18,14 @@
 func globalPluginDirs() []string {
        var ret []string
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
-       dir, err := ConfigDir()
+       dir, err := cliconfig.ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
                machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
                ret = append(ret, filepath.Join(dir, "plugins"))
                ret = append(ret, filepath.Join(dir, "plugins", machineDir))
        }

        return ret
 }

commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed Aug 9 17:46:49 2017 -0400

    keep .terraform.d/plugins for discovery

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -16,13 +16,14 @@
 func globalPluginDirs() []string {
        var ret []string
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
                machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
+               ret = append(ret, filepath.Join(dir, "plugins"))
                ret = append(ret, filepath.Join(dir, "plugins", machineDir))
        }

        return ret
 }

commit 41ab0aef7a0fe030e84018973a64135b11abcd70
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed Aug 9 10:34:11 2017 -0400

    Add missing OS_ARCH dir to global plugin paths

    When the global directory was added, the discovery system still
    attempted to search for OS_ARCH subdirectories. It has since been
    changed only search explicit paths.

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -14,12 +16,13 @@
 func globalPluginDirs() []string {
        var ret []string
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
-               ret = append(ret, filepath.Join(dir, "plugins"))
+               machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
+               ret = append(ret, filepath.Join(dir, "plugins", machineDir))
        }

        return ret
 }

commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed May 3 22:24:51 2017 -0400

    move some more plugin search path logic to command

    Make less to change when we remove the old search path

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -16,22 +14,12 @@
 func globalPluginDirs() []string {
        var ret []string
-
-       // Look in the same directory as the Terraform executable.
-       // If found, this replaces what we found in the config path.
-       exePath, err := osext.Executable()
-       if err != nil {
-               log.Printf("[ERROR] Error discovering exe directory: %s", err)
-       } else {
-               ret = append(ret, filepath.Dir(exePath))
-       }
-
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
                ret = append(ret, filepath.Join(dir, "plugins"))
        }

        return ret
 }

commit 8364383c359a6b738a436d1b7745ccdce178df47
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 13 18:05:58 2017 -0700

    Push plugin discovery down into command package

    Previously we did plugin discovery in the main package, but as we move
    towards versioned plugins we need more information available in order to
    resolve plugins, so we move this responsibility into the command package
    itself.

    For the moment this is just preserving the existing behavior as long as
    there are only internal and unversioned plugins present. This is the
    final state for provisioners in 0.10, since we don't want to support
    versioned provisioners yet. For providers this is just a checkpoint along
    the way, since further work is required to apply version constraints from
    configuration and support additional plugin search directories.

    The automatic plugin discovery behavior is not desirable for tests because
    we want to mock the plugins there, so we add a new backdoor for the tests
    to use to skip the plugin discovery and just provide their own mock
    implementations. Most of this diff is thus noisy rework of the tests to
    use this new mechanism.

diff --git a/plugins.go b/plugins.go
--- /dev/null
+++ b/plugins.go
@@ -0,0 +16,22 @@
+func globalPluginDirs() []string {
+       var ret []string
+
+       // Look in the same directory as the Terraform executable.
+       // If found, this replaces what we found in the config path.
+       exePath, err := osext.Executable()
+       if err != nil {
+               log.Printf("[ERROR] Error discovering exe directory: %s", err)
+       } else {
+               ret = append(ret, filepath.Dir(exePath))
+       }
+
+       // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
+       dir, err := ConfigDir()
+       if err != nil {
+               log.Printf("[ERROR] Error finding global config directory: %s", err)
+       } else {
+               ret = append(ret, filepath.Join(dir, "plugins"))
+       }
+
+       return ret
+}


Функция globalPluginDirs была изменена в 5 коммитах.


7.Кто автор функции synchronizedWriters?

Anton.Sergeev@ASSET-10603 MINGW64 /c/Devops-Netology/HW2.4/terraform (main)
$ git log -S'synchronizedWriters' --pretty=format:'%h - %an %ae %ad'
bdfea50cc - James Bardin j.bardin@gmail.com Mon Nov 30 18:02:04 2020 -0500
fd4f7eb0b - James Bardin j.bardin@gmail.com Wed Oct 21 13:06:23 2020 -0400
5ac311e2a - Martin Atkins mart@degeneration.co.uk Wed May 3 16:25:41 2017 -0700

В коммите 5ac311e2a впервые встречается функция synchronizedWriters , автор коммита  Martin Atkins mart@degeneration.co.uk . 


