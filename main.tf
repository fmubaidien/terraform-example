module "network" {
    source = "./network"

    region = "us-east-1"
    main_vpc_cidr = "10.0.0.0/24"
    public_subnets = "10.0.0.128/26"
    private_subnets = "10.0.0.192/26"
}

module "infra" {
    source = "./app"
    region = "us-east-1"
    private_subnet_id = module.network.private_subnet_id
    results_target_group_arn = module.network.results_target_group_arn 
    voter_target_group_arn = module.network.voter_target_group_arn    
    results-voter-sg = module.network.results-voter-sg.name
    worker-sg = module.network.worker-sg.name
}

