# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version     = "2.86.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf-test1rg" {
  name     = "TFTestRG"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg-test" {
  name                = "testcontainergroup"
  location            = azurerm_resource_group.tf-test1rg.location
  resource_group_name = azurerm_resource_group.tf-test1rg.name
  ip_address_type     = "public"
  dns_name_label      = "testcgdns"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}