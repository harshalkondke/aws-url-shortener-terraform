# AWS URL Shortener Terraform
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/harshalkondke/aws-url-shortener-terraform/blob/master/LICENSE)

## Terraform Introduction
erraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

## Install terraform 
install terraform for your OS. [Download Link](https://www.terraform.io/downloads.html)

## AWS authentification
The AWS provider is used to interact with the many resources supported by AWS. The provider needs to be configured with the proper credentials before it can be used.
Setup AWS CLI and add your accounts access and secret keys. so that you don't have to add this into code.

## Run the program 

First clone this repo

    git clone https://github.com/harshalkondke/aws-url-shortener-terraform.git
    
Before terraform apply we need to download the provider plugin 

    terraform init
    
Display plan before building stack

    terraform plan
    
Apply building stack

    terraform apply
   
If you wish to destory all the resources that terraform created, use this

    terraform destroy
    
## Contribution
I would love to see what you add to this project and make it better. Everyone is welcome to contribute. 
Cheers
