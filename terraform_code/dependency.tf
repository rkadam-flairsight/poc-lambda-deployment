locals {
    lambda-functions = {
    for f in fileset("../deployment-artefact/", "**") : replace(basename(f), ".py", "") => "../deployment-artefact/${f}"
  }
}
