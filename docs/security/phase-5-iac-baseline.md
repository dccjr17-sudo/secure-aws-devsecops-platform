# Phase 5 Terraform security baseline

## Enforced controls

Phase 5 runs Checkov 3.3.16 against the Terraform source and blocks the following controls. The baseline run passed 15 checks with zero failures.

| Control area | Check IDs | Why it blocks delivery |
| --- | --- | --- |
| Provider credentials | `CKV_AWS_41` | Terraform must not contain AWS access keys. |
| Private immutable registry | `CKV_AWS_51`, `CKV_AWS_163` | ECR image tags must be immutable and scanned on push. |
| Least-privilege identity | `CKV_AWS_60`, `CKV_AWS_61`, `CKV_AWS_274` | IAM roles must not be broadly assumable or use AdministratorAccess. |
| Network baseline | `CKV_AWS_130`, `CKV2_AWS_11` | Subnets must not assign public IPs by default and VPC Flow Logs must remain enabled. |
| GitHub federation | `CKV_AWS_393` | OIDC trust must constrain GitHub claims safely. |

## Broader findings retained for review

A full local Checkov scan found 11 additional items. These are documented individually rather than excluded in configuration. Checkov does not assign the business severity that determines release policy, so this table records the actual design decision and review target.

| Finding group | Check IDs | Current lab decision and compensating control | Review by |
| --- | --- | --- | --- |
| Customer-managed KMS keys | `CKV_AWS_119`, `CKV_AWS_136`, `CKV_AWS_145`, `CKV_AWS_158` | State, ECR, and Flow Logs use AWS-managed encryption in this low-cost lab. No workload secrets or production data are present. Define a single CMK strategy before Phase 6 introduces managed secrets. | Start of Phase 6, no later than 2026-12-31 |
| State-bucket resilience and audit features | `CKV_AWS_18`, `CKV_AWS_62`, `CKV_AWS_144`, `CKV_AWS_300` | State is private, versioned, encrypted, and locked. Cross-region replication, a separate log destination, event notifications, and multipart cleanup are deferred to avoid adding services before a recovery/audit design exists. | Start of Phase 6, no later than 2026-12-31 |
| Flow-log retention and policy scope | `CKV_AWS_338`, `CKV_AWS_356` | Thirty-day retention controls cost. The CloudWatch delivery policy grants only required actions, though the AWS integration needs a wildcard resource. Revisit retention and policy boundaries with centralized logging. | Start of Phase 6, no later than 2026-12-31 |
| Default VPC security group | `CKV2_AWS_12` | No workload or public endpoint is attached. Explicit workload security groups are required before deployment; tighten the default group as part of that deployment design. | Before any workload deployment, no later than 2026-12-31 |

These tracked items are not a waiver for Critical findings. Secret, dependency, SAST, selected-IaC, and Critical-container gates continue to block the pipeline.
