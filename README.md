
# Implement CircleCI + FluxCD pipeline for infrastructure deployment in AWS




## Prerequisites


 - [Git](https://github.com/git-guides/install-git)
 - [Git token](https://github.com/settings/tokens)
 - [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)
 - [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
 - [Flux CLI](https://fluxcd.io/flux/installation/)
 - [Helm CLI](https://helm.sh/docs/intro/install/)
 - [AWS access and secret access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)

- **Fork and clone repository**


## FluxCD Deployment

[Create cluster](https://kind.sigs.k8s.io/docs/user/quick-start/#creating-a-cluster)

```bash
  kind create cluster --name production-cluster
```

[Setting git token as environment variable](https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-set-environment-variables-in-linux/)

```bash
  export GITHUB_TOKEN=<gh-token>
```

[Flux Bootstrapping](https://fluxcd.io/flux/cmd/flux_bootstrap/)

```bash
flux bootstrap github \
  --owner=YOUR_GITHUB_USERNAME \
  --repository=NAME_OF_YOUR_FORKED_REPO \
  --branch=main \
  --path=kubernetes/fluxcd/repositories/infra-repo/clusters/production-cluster
```
Add AWS credentials file.

Go to kubernetes/fluxcd/repositories/infra-repo/apps/production and сreate aws-creds.yaml. **Be careful, this file contains your AWS account access keys, so make sure to include it in your .gitignore file!**

```bash
  apiVersion: v1
kind: Secret
metadata:
  name: aws-credentials
  namespace: flux-system
stringData:
  AWS_ACCESS_KEY_ID: YOUR_ACCESS_KEY
  AWS_SECRET_ACCESS_KEY: YOUR_SECRET_ACCESS_KEY
  AWS_REGION: YOUR_REGION [eu-north-1 by default]

```

[Install tofu controller](https://flux-iac.github.io/tofu-controller/getting_started/)

```bash
  kubectl apply -f https://raw.githubusercontent.com/flux-iac/tofu-controller/main/docs/release.yaml
```

Flux configuration.

Modify **kubernetes/fluxcd/repositories/infra-repo/apps/production/gitrepository.yaml** for tracking your git repo.

Modify **kubernetes/fluxcd/repositories/infra-repo/apps/tf-app/terraform.yaml** with your S3 bucket to store terraform.tfstate
```bash
kubectl -n flux-system apply -f kubernetes/fluxcd/repositories/infra-repo/apps/production/gitrepository.yaml
kubectl -n flux-system apply -f kubernetes/fluxcd/repositories/infra-repo/apps/production/terraform.yaml
kubectl -n flux-system apply -f kubernetes/fluxcd/repositories/infra-repo/apps/production/aws-creds.yaml
```

## CircleCI Deployment
You can build in [CircleCI](https://circleci.com/blog/ci-with-gitops/#:~:text=Building%20in%20CircleCI) or via [CircleCI CLI](https://circleci.com/docs/local-cli/)

CircleCI configuration via CLI

```bash
  circleci namespace create <name> --org-id <your-organization-id>
  circleci runner resource-class create <namespace>/<resource-class> <description> --generate-token
```

 _Change your [.circleci/config.yaml](https://github.com/DmytroMigirov/webserver-ec2-module-terraform/blob/77be1257326f1ad45167102c7b2bb6f3e7b1c210/.circleci/config.yml#L7) with your <namespace>/<resource-class>. Lines 7,16,37._
_Don`t forget to change [git configs](https://github.com/DmytroMigirov/webserver-ec2-module-terraform/blob/261ddf51608ca71ee032846c0646eacc711d0ca4/.circleci/config.yml#L42-L59) with your credentials as well._

Add your resource class token to values.yaml
```bash
  agent:
  resourceClasses:
    namespace/my-rc:
      token: <your_resource_class_token>
```

Add helm image
```bash 
helm repo add container-agent https://packagecloud.io/circleci/container-agent/helm
helm repo update
```
Create namespace for CircleCI
```bash 
kubectl create namespace circleci
```
Install container agent
```bash 
helm install container-agent container-agent/container-agent -n circleci -f values.yaml
```

## Test pipeline
Create new branch
```bash 
git checkout -b test
```
Create new empty commit
```bash 
git commit --allow-empty -m "trigger"
```
Push to Test branch
```bash 
git push origin test
```
## Results
![image_2024-05-28_16-00-57](https://github.com/DmytroMigirov/webserver-ec2-module-terraform/assets/139138831/2e3dbb66-431a-4288-9aa8-9b4745317341)
