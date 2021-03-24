
# Create temporary directory to hold the deployment artefact

mkdir deployment-artefact

# COPY JS FILES FROM INDIVIDUAL MODULES
find ./lambda-code/ -name "*.py" | xargs cp -t deployment-artefact

# Run terraform code 
# It will 
#       1. Create new lambda if it finds new file
#       2. Update the code for any existing lambda
#       3. Delete the lambda when any of the file is removed

cd terraform_code

# Run with "--auto-approve" option when you are comfortable with the automation, this way it will directly start deployment process
terraform apply

# Finally delete the temporary directory
cd ../
rm -rf deployment-artefact