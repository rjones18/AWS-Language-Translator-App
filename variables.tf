variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "ecr_image_uri" {
  description = "Full ECR image URI with tag"
  type        = string
}

variable "domain_name" {
  description = "The custom domain you want for App Runner, e.g. api.example.com"
  type        = string
}

variable "route53_zone_name" {
  description = "Route 53 hosted zone name, e.g. example.com."
  type        = string
}
