network_name   = "k8snet"
network_domain = "k8s.local"
ssh-public-key = "AAAAB3NzaC1yc2EAAAADAQABAAABgQCVX5JQBjwChwLwQcl4AAErdJPb+Ex8jsOipdIGLRhAI7Jq5HNGcGwekTBPk/p+GwDQPn3eRpLCFlSGyKtmZzp1QUCWVkLMHoKMFtpp2IX5zpj7Z0v3kkhsYNQrXc4BDY4nmwSGgMBcidn8iyFBpnsQ+PPPIS4xgPL4PHlgeF1hYo3wuOTj8WYIltgxvkOJsPlmi0Xo8tndmHWsVRfG0tQRBIFRx5UtK3+q8IUfGZuoSYE5XC2zhIPVRgIbofvmU4xyArsupZMCzOUYWt7WxvyOd3RVX+cw+vKv29FJ8Figsn2ulNhf27zEUuWrawEPzd+iLjyD6k+fHCYiYoVC1OAqOpCtk2YtxUrDIz/GlT0voE6Tfg5yKJnrwr7gTKS1qw4kPEJjXf2kJUZgF3mGUjDzHmOF74Y39JHWqRO43rI4GDmerL72TlESBIXaG29FQXVH1FBxXnCgXTtjBYx3R/FwpZ9A9IySXw/4vugWOeFjVuAQnZO4XeA60JlPPL2ZPME= kai@im"

control-image         = "/home/kai/Downloads/noble-server-cloudimg-amd64.img"
control-number        = 3
control-vcpus         = 2
control-memory        = 2048
control-volume-prefix = "k8s-control-plane"
control-volume-size   = 26843545602 # 25GB

nodes-image         = "/home/kai/Downloads/noble-server-cloudimg-amd64.img"
nodes-number        = 2
nodes-vcpus         = 2
nodes-memory        = 2048
nodes-volume-prefix = "k8s-nodes"
nodes-volume-size   = 26843545600
