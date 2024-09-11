module "network" {
  source              = "./modules/network"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  public_subnet_az    = "ap-southeast-1a"
  private_subnet_cidr = "10.0.2.0/24"
  private_subnet_az   = "ap-southeast-1b"
}

module "compute" {
  source              = "./modules/compute"
  master_ami          = "ami-01811d4912b4ccb26"  
  worker_ami          = "ami-01811d4912b4ccb26"  
  worker_count        = 2
  subnet_id           = module.network.public_subnet_id
  security_group_id   = module.network.security_group_id
  key_name            = "Palash-ap"
  instance_profile    = ""
}

module "storage" {
  source           = "./modules/storage"
  bucket_name      = "palash-ecom-bucket"  
  file_paths       = ["/home/einfochips/Training-Assessment-Task/E-commerce/ecom-site/index.html", "/home/einfochips/Training-Assessment-Task/E-commerce/ecom-site/script.js"]
  file_sources     = ["/home/einfochips/Training-Assessment-Task/E-commerce/ecom-site/styles.css", "/home/einfochips/Training-Assessment-Task/E-commerce/ecom-site/logo.png"]
}

module "iam" {
  source                = "./modules/iam"
  role_name             = "palash_role"
}
