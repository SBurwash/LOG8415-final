# Terraform Discord Bot Project
**By Stephane Burwash in the context of LOG8415E**

## Setup on Discord Portal
The first step is to setup your Discord bot on the [Discord Developper Portal](https://discord.com/developers/applications) and copy the *token* for future use.

## Installation

Dillinger requires [Terraform](https://www.terraform.io/downloads.html) to run as well as an existing Azure Account with credits

Clone repository and perform terraform initialization operations
```sh
terraform init
terraform apply
```

Once this is done, simply run the setup executable file
```sh
exec.sh -u USERNAME -t TOKEN
```
where *-u* is your username (by default *azureuser*) and *-t* is your token provided during the setup of your bot on the [Discord Developper Portal](https://discord.com/developers/applications)

This will clone into the existing [bot template repo](https://github.com/SBurwash/Discord_bot_project). If you wish to edit the template, you can replace copy the repository into one of your own, edit it for the desired bot, edit the line in *exec.sh* for cloning the repository to instead use yours and run the application.
