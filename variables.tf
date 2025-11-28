variable "trigramme" {
  description = "Votre trigramme"
  type        = string
  default     = "ILF"  # ← CHANGEZ ICI
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  type        = string
  default     = "ami-0c02fb55956c7d316"  # us-east-1
}

variable "desired_capacity" {
  description = "Nombre d'instances souhaitées dans l'ASG"
  type        = number
  default     = 2
}
