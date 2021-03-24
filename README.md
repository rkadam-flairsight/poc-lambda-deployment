# poc-lambda-deployment

## Folder structure
-  lambda-code : Contains the code for each lambda. one file means one lambda, there can be any number of directories to make logical distinction, the automation is designed in such a way that it will check all the directories recursively
- terraform_code : This directories contains files which will create the lambda resources and its dependent resources
- pre-deployment.sh : This file contains the shell commands to run the whole automation


## How to use ?

For the first attempt only, check terraform_code/provider.tf and update the backend config, in this repo you will find the info from SBX account. This is not required afterwards.

Make sure that the pre-deployment.sh file executable, then just run `bash pre-deployment.sh` and the rest will taken care by automation.

## Internal working

Internally it will create a temp folder, copy all python files in that folder and use the file list from there to generate the lambda resources with terraform code (with for each loop on the files). This enables us with below features:
1. To create new lambda just add the file in specific folder in `lambda-code` dir and automation will pick it up and treat it as new lambda to be created. Same thing goes for lambda removal with file removal.
2. When any file content is changed the lambda corresponding to that file will get updated with latest code, thus it can be used as automated deployment tool. (Put it in CI and you have your CICD tool which can run on github webhook)

## Limitations
It is assumed that the networking configuration, lambda env variable and IAM permissions are same for all the lambda. Ifit is different then we have to create a map or local variable for the same and accordingly loop on it to create lambda resources.