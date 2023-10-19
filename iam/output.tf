
output "service_account_one" {
    value = {
        "account_id" = google_service_account.service_account_one.account_id
        "display_name" = google_service_account.service_account_one.display_name
    } 
}