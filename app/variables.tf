variable "region" {
    type = string
    default = "us-east-2"
}

variable "private_subnet_id" {}

variable "results_target_group_arn" {}
variable "voter_target_group_arn" {}

variable "results-voter-sg" {}
variable "worker-sg" {}