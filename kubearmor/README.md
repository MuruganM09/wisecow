# Problem Statement 3 - KubeArmor Zero-Trust Policy

## Policy
wisecow-policy.yaml applies a zero-trust policy to the wisecow pod that audits/blocks:
- Execution of apt, apt-get, bash, curl, wget
- Access to files under /etc/

## Mode
KubeArmor runs in Audit mode in this Minikube setup (Docker driver, eBPF Monitor enforcer),
so violations are logged rather than hard-blocked.

## Applying the policy
kubectl apply -f wisecow-policy.yaml

## Verifying violations
karmor logs -n wisecow

## Evidence
See screenshots/karmor-alert.png for a captured policy violation alert showing
apt execution inside the wisecow pod matched by the zero-trust policy.
