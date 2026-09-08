# Project plan

## Project objective

Build and document a secure AWS application platform that demonstrates infrastructure automation, container security, CI/CD security, identity controls, monitoring, and Kubernetes operations. Each phase must leave behind a working artifact, a short decision record, validation evidence, and an interview-ready explanation.

## Delivery principles

- Build one platform incrementally instead of collecting unrelated labs.
- Prefer identity federation and short-lived credentials over static credentials.
- Apply least privilege, encryption, logging, and secure defaults from the first deployable resource.
- Keep costs explicit and avoid running paid services when not actively learning.
- Treat the Git history, documentation, and test evidence as portfolio artifacts.
- Do not use production data, employer data, real customer data, or unredacted console screenshots.

## Phases and exit criteria

### Phase 1 — Terraform foundation

**Build:** Terraform layout, protected remote state, development environment configuration, a two-AZ VPC, public/private subnet segmentation, and VPC Flow Logs.

**Exit criteria:** `terraform fmt`, `validate`, and an AWS-authenticated `plan` succeed. Remote state is versioned, encrypted, non-public, and locked. A sanitized diagram and rationale for the design are committed.

### Phase 2 — Containerized application

**Build:** A small health-check application, Dockerfile, non-root runtime user, local tests, and a documented local build/run command.

**Exit criteria:** The application builds and passes health checks locally; its image contains no secrets and runs as a non-root user.

### Phase 3 — Image registry and deployment target

**Build:** Private ECR repository, immutable tags, a repository-scoped image scanning configuration, and documented image publication and validation. The least-privilege GitHub OIDC role is introduced in Phase 4.

**Exit criteria:** A private repository receives an immutable application image; image scanning results are reviewed and documented, including any verified attribution mismatch or accepted residual risk.

### Phase 4 — CI/CD through GitHub Actions

**Build:** Pull-request validation and controlled image-publication workflows using GitHub-to-AWS OIDC federation.

**Exit criteria:** No long-lived AWS secret exists in GitHub. A pull request runs formatting, configuration validation, tests, and an image build; image publication requires an intentional main-branch gate.

**Status:** Complete — pull-request validation passed, a manually initiated main-branch workflow published an immutable ECR image through GitHub OIDC, and the resulting scan was reviewed.

### Phase 5 — Security scanning and policy gates

**Build:** Secret scanning, SAST, dependency scanning, IaC scanning, container scanning, and findings triage documentation.

**Exit criteria:** Critical findings block the pipeline or have a documented, time-bounded exception. One intentionally introduced safe test finding is detected and remediated.

**Status:** In progress — security gates are implemented on the Phase 5 branch. The dependency baseline found Flask 3.1.2 vulnerable to `PYSEC-2026-2151`; the branch upgrades it to 3.1.3 before validation.

### Phase 6 — Secrets, audit, and detection

**Build:** Secrets Manager with least-privilege runtime access, KMS-backed encryption where appropriate, CloudTrail, GuardDuty, Security Hub, and log retention/alerting choices.

**Exit criteria:** Application configuration comes from a managed secret rather than source control; a controlled security event is generated, found, and explained.

### Phase 7 — Kubernetes/EKS

**Build:** EKS cluster and workload deployment, namespace/RBAC strategy, admission and image controls, network segmentation, centralized logging, and rollback guidance.

**Exit criteria:** The application deploys through CI/CD to EKS; access paths, security controls, operational evidence, and teardown steps are documented.

## Definition of done for every phase

1. Infrastructure or code works from a documented command sequence.
2. The README and relevant runbook explain how to validate it.
3. At least one security decision and its trade-off is captured in `docs/adr/`.
4. Evidence is sanitized and stored according to `docs/evidence/README.md`.
5. The phase is summarized in two to four resume/interview talking points before moving on.
