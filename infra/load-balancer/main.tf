variable "lb_name" {}
variable "is_external" {}
variabel "lb_type" {}
variable "sg_enable_ssh_https" {}
variable "subnet_ids" {}
variable "ec2_instance_id" {}
variable "lb_target_group_attachment_port" {}
variable "lb_target_group_arn" {}
variable "lb_litener_port" {}
variable "lb_litener_protocol" {}
variable "lb_listener_default_action" {}
variable "lb_target_group_arn" {}
variable "lb_https_listener_port" {}
variable "lb_https_listener_protocol" {}
variable "dev_proj_1_acm_arn" {}

output "aws_lb_dns_name" {
   value = aws_lb.dev_proj_1_lb.dns_name
}
output "aws_lb_zone_id" {
  value = aws_lb.dev_proj_1_lb.zone_id
}

resource "aws_lb" "dev_proj_1_lb" {
     name                 = var.lb_name
     internal             = var.is_external
     load_balancer_type   = var.lb_type
     security_groups      = [var.sg_enable_ssh_https]
     subnets              = var.subnet_ids
     enable_deletion_protection = true
     tags = {
       Name = "dev-lb"
     }
}
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = var.lb_target_group_arn
  target_id        = var.ec2_instance_id
  port             = var.lb_target_group_attachment_port
}
resource "aws_lb_listener" "dev_proj_1_lb_listener" {
  load_balancer_arn = aws_lb.dev_proj_1_lb.arn
  port              = var.lb_litener_port
  protocol          = var.lb_listener_protocol
  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}
resource "aws_lb_listener" "dev_proj_1_lb_https_listener" {
  load_balancer_arn = aws_lb.dev_proj_1_lb.arn
  port              = var.lb_https_listener_port
  protocol          = var.lb_https_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.dev_proj_1_acm_arn
  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

     
