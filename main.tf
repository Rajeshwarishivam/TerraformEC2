provider "aws" {
  region = "us-east-1"
}
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 1

  ami                    = "ami-0aeeebd8d2ab47354"
  instance_type          = "t2.micro"
  key_name               = "bastion"
  monitoring             = true
  vpc_security_group_ids = ["sg-042d11c016ef8a50c"] 
  subnet_id              = "subnet-3045d556" 

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
