terraform {
    source = "../../../infrastructure"
}

inputs = {
    vpc_cidr = "200.100.0.0/16"
    network_http = {
        subnet_name = "test_subnet_http"
        cidr        = "200.100.1.0/24"
    }
    network_db = {
        subnet_name = "test_subnet_db"
        cidr        = "200.100.2.0/24"
    }
    http_instance_names = ["test-instance-http-1", "test-instance-http-2"]
    db_instance_names = ["test-instance-db-1", "test-instance-db-2", "test-instance-db-3"]
}