variable "profile" {
    default = "default"
}     

variable "ami_id" {
    default = "ami-0e86e20dae9224db8"
}          

variable "instance_type" {
    default = "t2.micro"
}   

variable "region" {
    default = "us-east-1"
}          

variable "instance_name" {
    default = "new-instance"
}   

variable "private_key_path" {
    default = "/home/einfochips/day31/Palash-east1.pem"
} 

variable "bucket_name" {
    default = "s3-palash-bucket-terraform-123"
}     

