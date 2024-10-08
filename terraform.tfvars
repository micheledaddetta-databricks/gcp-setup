google_project = "fe-dev-sandbox"
shared_name = "michele-daddetta-isp"
region = "europe-west3"

nodes_ip_cidr_range = "10.0.0.0/24"
pod_ip_cidr_range = "10.0.8.0/21"
service_ip_cidr_range = "10.0.1.0/24"
google_pe_subnet_ip_cidr_range = "10.0.2.0/24"
google_pe_subnet_secondary_ip_range = "10.0.3.0/24"

relay_service_attachment = "projects/prod-gcp-europe-west3/regions/europe-west3/serviceAttachments/ngrok-psc-endpoint"
workspace_service_attachment = "projects/prod-gcp-europe-west3/regions/europe-west3/serviceAttachments/plproxy-psc-endpoint-all-ports"

databricks_account_id = "e11e38c5-a449-47b9-b37f-0fa36c821612"
