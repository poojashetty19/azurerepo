variable "resource_group_name" {
    type = string
    description = "resource group name where the app service plan is created"
}

variable "app_service_plan_name" {
    type = string
    description = "the app service plan name to be created"
}

variable "app_service_name" {
    type = string
    description = "name of the app service to be created"
}

