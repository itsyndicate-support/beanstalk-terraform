# How to

![infra instance with multiple network](./img/03-multiple-network.png "infra instance with multiple network")

### How to autocreate new stack environment

Clone repository:

```git clone https://github.com/denis-dovgodko/webserver-ec2-module-terraform```

Create new branch(environment)

```git checkout -b NAME```

NAME - desired env name

Create empty commit:

```git commit --allow-empty -am "init new env"```

Push branch to GitHub

# CI Pipeline will create pull-request to MAIN. After review, your env will be automaticly deployed.
Please, stash your commits before you had pushed changes to github, or use stash on branches merge on pull request review step.

## On CD layer(GitOps via FluxCD), you need to create default cluster, add credentials, bootstap fluxcd and install tf controller(it could be automated[optional])

You can use next cheatsheet:

```kind create cluster --name fluxcd --image kindest/node:v1.25.16```

```
flux bootstrap github   `
    --token-auth   `
    --owner=username   `
    --repository=webserver-ec2-module-terraform   `
    --branch=main   `
    --path=kubernetes/fluxcd/repositories/infra-repo/clusters/dev-cluster   `
    --personal
```

```kubectl apply -f https://raw.githubusercontent.com/weaveworks/tf-controller/main/docs/release.yaml```

```kubectl create secret generic aws-credentials --from-literal=AWS_ACCESS_KEY_ID=[KEY_ID]  --from-literal=AWS_SECRET_ACCESS_KEY=[SECRET_KEY] -n flux-system```

For conclusion, it would be honest to admit that it may be better to provide envs on different branches cause you can change your tf folder resources. So, you need to protect terraform directory on main branch from undesired commits from others envs. Remember that on pull requests review stage.
