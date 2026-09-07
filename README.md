# Secure AWS DevSecOps Application Platform

An incrementally built AWS platform that demonstrates secure infrastructure delivery, containerization, CI/CD, detection, and Kubernetes operations. This is a private portfolio project; its documentation explains the decisions and validation evidence without publishing secrets, credentials, or sensitive account details.

## Why this project exists

The goal is to turn cloud-security knowledge into demonstrable engineering capability. Rather than completing disconnected labs, this repository evolves one application platform through infrastructure as code, secure software delivery, and cloud detection.

## Project roadmap

| Phase | Outcome | Key technologies |
| --- | --- | --- |
| 1 — foundation | Version-controlled Terraform, remote state, and a secure network baseline | Terraform, AWS IAM, S3, DynamoDB, VPC, CloudWatch Logs |
| 2 — application | A small containerized application with a repeatable local build | Docker, Python or Node.js |
| 3 — image delivery | Private image registry and least-privilege image publishing | Amazon ECR, IAM |
| 4 — CI/CD | Automated validation, scanning, and deployment workflow | GitHub Actions, OIDC |
| 5 — DevSecOps controls | Security checks at code, dependency, container, and IaC layers | Gitleaks, Trivy, Checkov, CodeQL |
| 6 — secrets and detection | Runtime secrets, audit logs, threat detection, and alerting | Secrets Manager, KMS, CloudTrail, GuardDuty, Security Hub |
| 7 — Kubernetes | A hardened, observable EKS deployment path | EKS, Kubernetes, Helm, network policies |

Detailed scope and success criteria are in [docs/PROJECT-PLAN.md](docs/PROJECT-PLAN.md).

## Architecture direction

Phase 1 establishes a two-AZ VPC with public and private application subnets. No workloads are exposed yet. Later phases will deploy a small application through a private ECR registry, use GitHub Actions with AWS OIDC instead of long-lived AWS keys, and move from a managed container deployment to EKS only after the pipeline, scanning, logging, and access controls are in place.

See [Phase 1 architecture](docs/architecture/phase-1-foundation.md) and [ADR-001](docs/adr/ADR-001-terraform-state-and-layout.md).

## Repository layout

```text
.
├── app/                         # Application code (added in Phase 2)
├── docs/                        # Architecture, decisions, runbooks, and sanitized evidence
├── infrastructure/
│   ├── bootstrap/                # One-time Terraform remote-state resources
│   ├── environments/dev/         # Development environment composition and backend config
│   └── modules/network/          # Reusable VPC and flow-log module
├── scripts/                      # Safe, repeatable helper scripts
└── .github/workflows/            # CI/CD workflows (added in Phase 4)
```

## Phase 1: first implementation steps

### 1. Prerequisites

- Install Terraform (1.6 or later) and AWS CLI v2.
- Authenticate with AWS IAM Identity Center or an approved named AWS profile. Do **not** create or paste access keys into this repository.
- Confirm the AWS account and region intended for the lab. This project is configured for Oregon (`us-west-2`); use that same region for both bootstrap and development state.
- Create an empty **private** GitHub repository named `secure-aws-devsecops-platform`; do not add a README, `.gitignore`, or license from GitHub because this folder already contains them.

### 2. Bootstrap encrypted remote state

The bootstrap configuration creates a versioned, private S3 bucket and a DynamoDB lock table. It uses local state only for this initial one-time apply; keep the generated local `terraform.tfstate` private and never commit it.

```powershell
cd infrastructure/bootstrap
Copy-Item terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars: confirm Oregon, your devsecops-lab profile, and a unique project slug.
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Record the two Terraform outputs (`state_bucket_name` and `lock_table_name`) in a password manager or other private notes—not in screenshots.

### 3. Configure the development backend

```powershell
cd ../environments/dev
Copy-Item backend.hcl.example backend.hcl
Copy-Item terraform.tfvars.example terraform.tfvars
# Edit both files using the bootstrap outputs and the same region/project settings.
terraform init -backend-config=backend.hcl
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
```

Review the plan carefully before applying. Phase 1 creates only the network and VPC flow logs. It intentionally does not create an NAT gateway, EKS cluster, or public application endpoint, which keeps initial cost and exposure low.

### 4. Capture safe evidence and commit

Use the checklist in [docs/evidence/README.md](docs/evidence/README.md). Commit source code and sanitized diagrams only—never state, plan files, credentials, account IDs, repository URLs, or console screenshots with sensitive values.

## Safety and cost guardrails

- `.tfstate`, plans, account-specific `*.tfvars`, and `backend.hcl` are ignored by Git.
- Terraform uses a named AWS profile or Identity Center session; there are no access keys in configuration.
- Initial VPC private subnets have no default internet route. A later documented decision will select NAT gateways or VPC endpoints based on workload needs and cost.
- Before Phase 2, create an AWS Budget and billing alert. Before EKS, review the cost estimate and set a lab teardown reminder.
- Follow the [Terraform workflow runbook](docs/runbooks/terraform-workflow.md) before every apply or destroy.

## Status

**Current phase:** Phase 2 — secure containerized application baseline built and locally validated. The next phase adds a private ECR registry and controlled image delivery.

## License

Private portfolio project. Do not make this repository public without reviewing every file, commit, issue, workflow log, and evidence artifact for sensitive information.
