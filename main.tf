

module "ec2_east1" {
  source = "./modules/ec2"
  instance_type = "t2.micro"
}

module "ec2_west2" {
  providers = {
    aws = aws.west
   }
  source = "./modules/ec2"
  instance_type = "t3.micro"
}
