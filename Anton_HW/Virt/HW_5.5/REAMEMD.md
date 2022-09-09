# Задача 1

Дайте письменые ответы на следующие вопросы:

- 1.В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
- 2.Какой алгоритм выбора лидера используется в Docker Swarm кластере?
- 3.Что такое Overlay Network?

---
````bash
1. В global режиме сервисы запускаются на каждой ноде разом и количество реплик ограничено количеством нод в кластере 
docker swarm.
В replication режиме сервисы реплицируются в том количестве которое указано в команде:
"docker service update --replicas="

2. Алгоритм Raft
В кластере должен быть минимум 1 менеджер и более, который/которые могут стать кандидатами в лидеры. Если резервный 
менеджер долго не получает сообщений от лидера, то он переходит в состояние «кандидат» и посылает другим менеджерам 
запрос на голосование. Другие менеджеры голосуют за того кандидата, от которого они получили первый запрос. 
Если кандидат получает сообщение от лидера, то он снимает свою кандидатуру и возвращается в обычное состояние. 
Если кандидат получает большинство голосов, то он становится лидером. Если же он не получил большинства 
(это случай, когда на кластере возникли сразу несколько кандидатов и голоса разделились), то кандидат ждёт случайное 
время и инициирует новую процедуру голосования. Процедура голосования повторяется, пока не будет выбран лидер.

3. Overlay-сеть создает подсеть, которую могут использовать контейнеры в разных хостах swarm-кластера. Контейнеры на разных
физических хостах могут обмениваться данными по overlay-сети (если все они прикреплены к одной сети). Overlay-сеть 
использует технологию vxlan, которая инкапсулирует layer 2 фреймы в layer 4 пакеты (UDP/IP).

````
---


# Задача 2

- Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды: docker node ls

---
````bash
root@NETOLOGY:/opt/hw_5.5/src/terraform# ./terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Finding latest version of yandex-cloud/yandex...
- Finding latest version of hashicorp/null...
- Installing hashicorp/local v2.2.3...
- Installed hashicorp/local v2.2.3 (unauthenticated)
- Installing yandex-cloud/yandex v0.78.1...
- Installed yandex-cloud/yandex v0.78.1 (unauthenticated)
- Installing hashicorp/null v3.1.1...
- Installed hashicorp/null v3.1.1 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
root@NETOLOGY:/opt/hw_5.5/src/terraform# ./terraform plan



Plan: 13 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01 = (known after apply)
  + external_ip_address_node02 = (known after apply)
  + external_ip_address_node03 = (known after apply)
  + external_ip_address_node04 = (known after apply)
  + external_ip_address_node05 = (known after apply)
  + external_ip_address_node06 = (known after apply)
  + internal_ip_address_node01 = "192.168.101.11"
  + internal_ip_address_node02 = "192.168.101.12"
  + internal_ip_address_node03 = "192.168.101.13"
  + internal_ip_address_node04 = "192.168.101.14"
  + internal_ip_address_node05 = "192.168.101.15"
  + internal_ip_address_node06 = "192.168.101.16"

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

root@NETOLOGY:/opt/hw5.5.1/src/terraform# ./terraform validate
Success! The configuration is valid.

root@NETOLOGY:/opt/hw5.5.1/src/terraform# ./terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.inventory will be created
  + resource "local_file" "inventory" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "../ansible/inventory"
      + id                   = (known after apply)
    }

  # null_resource.cluster will be created
  + resource "null_resource" "cluster" {
      + id = (known after apply)
    }

  # null_resource.monitoring will be created
  + resource "null_resource" "monitoring" {
      + id = (known after apply)
    }

  # null_resource.sync will be created
  + resource "null_resource" "sync" {
      + id = (known after apply)
    }

  # null_resource.wait will be created
  + resource "null_resource" "wait" {
      + id = (known after apply)
    }

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node01"
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.11"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.node02 will be created
  + resource "yandex_compute_instance" "node02" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node02.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node02"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node02"
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.12"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.node03 will be created
  + resource "yandex_compute_instance" "node03" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node03.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node03"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node03"
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.13"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.node04 will be created
  + resource "yandex_compute_instance" "node04" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node04.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node04"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node04"
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.14"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.node05 will be created
  + resource "yandex_compute_instance" "node05" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node05.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node05"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node05"
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.node06 will be created
  + resource "yandex_compute_instance" "node06" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node06.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2YbiF38co8XNqwWL6iEl993A486sZaZbj9JD4xagOmBQ09B+qNFFsH87VT/SwbtvxOZvjsuUANdFiyC6SBfkns6AGhBN671Hl01WNQD48h+QCZdWqFdG+dzn1xUmiiXS1n+Wjj8pCLCGsl+dFI38gBpazfK96qmj0l7l9nHr0q3INMYETIIvuWgBkFcL0/jpAV7y8fT/MiOazsPLzltKKrIeglUOpR6FeI6PDxLXgpTl7KwEwKM8bWISrWMFvxxXczhg4u73Hk1wH3IT8dyS4Ow0bVSOYDsjms9aZKLmePM43BCQNeErBLXi7iellWww9RNyf7s+ivqbSSzkAZW6p root@NETOLOGY
            EOT
        }
      + name                      = "node06"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd88d14a6790do254kj7"
              + name        = "root-node06"
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.101.16"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 13 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01 = (known after apply)
  + external_ip_address_node02 = (known after apply)
  + external_ip_address_node03 = (known after apply)
  + external_ip_address_node04 = (known after apply)
  + external_ip_address_node05 = (known after apply)
  + external_ip_address_node06 = (known after apply)
  + internal_ip_address_node01 = "192.168.101.11"
  + internal_ip_address_node02 = "192.168.101.12"
  + internal_ip_address_node03 = "192.168.101.13"
  + internal_ip_address_node04 = "192.168.101.14"
  + internal_ip_address_node05 = "192.168.101.15"
  + internal_ip_address_node06 = "192.168.101.16"

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
root@NETOLOGY:/opt/hw5.5.1/src/terraform# ./terraform apply -auto-approve

Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01 = "130.193.36.151"
external_ip_address_node02 = "84.201.158.119"
external_ip_address_node03 = "84.201.173.42"
external_ip_address_node04 = "84.252.129.187"
external_ip_address_node05 = "84.201.156.100"
external_ip_address_node06 = "84.252.131.158"
internal_ip_address_node01 = "192.168.101.11"
internal_ip_address_node02 = "192.168.101.12"
internal_ip_address_node03 = "192.168.101.13"
internal_ip_address_node04 = "192.168.101.14"
internal_ip_address_node05 = "192.168.101.15"
internal_ip_address_node06 = "192.168.101.16"


root@NETOLOGY:/opt/hw5.5.1/src/terraform# ssh centos@130.193.36.151
[centos@node01 ~]$ sudo -i
[root@node01 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
704tj48zw84mucs0z9ks2ikn7 *   node01.netology.yc   Ready     Active         Leader           20.10.17
hwly8o83siaeokw836yw5gtd6     node02.netology.yc   Ready     Active         Reachable        20.10.17
yvn8wgc2vi4wfodx9ojxuupbr     node03.netology.yc   Ready     Active         Reachable        20.10.17
bhs5zfm3eip43ba3xwowf405w     node04.netology.yc   Ready     Active                          20.10.17
l4979mzijgolme3mbzqcn7ht7     node05.netology.yc   Ready     Active                          20.10.17
5ljxy1dod6ehtkgf4jsk1y4zu     node06.netology.yc   Ready     Active                          20.10.17





````
---

# Задача 3

- Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды: docker service ls

---
````bash
[root@node01 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
pms0hi4m9uw8   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
ymm7c6tmk359   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
rozp4kmba9e3   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest
ufvy91bgp7ou   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
jfkhj398cgj8   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
ugkt76meb7m7   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
jf2t12d7mqeb   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
ytv16ox8thln   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0

````
---

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/1.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/2.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/3.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/4.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/5.JPG)

# Задача 4

- Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание 
- её функционала, что она делает и зачем она нужна:

Блокируем swarm, чтобы защитить ключ шифрования. 

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.5/6.JPG)