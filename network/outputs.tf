output "private_subnet_id" {
    value = aws_subnet.privatesubnets.id
}



output "public_subnet_id" {
    value = aws_subnet.publicsubnets.id
}

output "results_target_group_arn" {
    value = aws_alb_target_group.results-group.arn
}

output "voter_target_group_arn" {
    value = aws_alb_target_group.voter-group.arn
}

output "results-voter-sg" {
    value = aws_security_group.results-voting_sg
}
output "worker-sg" {
    value = aws_security_group.worker_sg
}

output "private_subnet" {
    value = aws_subnet.privatesubnets
}

output "database-sg" {
    value = aws_security_group.database_sg
}