# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1g53m3oi7gunbee2up1"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gtfhn8k74du29stfr9"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  default = "fd8jvcoeij6u9se84dt5"
}

variable "instance_cores" {
  default = "2"
}

variable "instance_memory" {
  default = "2"
}

variable "instance_hdd" {
  default = "10"
}
