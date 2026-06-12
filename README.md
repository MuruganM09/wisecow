# Wisecow on Kubernetes

Containerised deployment of the [Wisecow](https://github.com/nyrahul/wisecow) application on Kubernetes with CI/CD automation and TLS.

![CI/CD](https://github.com/muruganm09/wisecow/actions/workflows/ci-cd.yaml/badge.svg)

## Project Structure

```
wisecow/
├── Dockerfile
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── hpa.yaml
│   ├── ingress.yaml
│   └── tls-secret.yaml
└── .github/
    └── workflows/
        └── ci-cd.yaml
```

## How to run locally

```bash
minikube start --driver=docker
minikube addons enable ingress
kubectl apply -f k8s/
minikube service wisecow-service -n wisecow --url
```

## HTTPS access

```bash
echo "$(minikube ip)  wisecow.local" | sudo tee -a /etc/hosts
curl -k https://wisecow.local
```

---

## Problem Statement 2 — Monitoring Scripts

See [problem-statement-2/](./problem-statement-2/) for:
- System Health Monitoring Script
- Application Health Checker Script
