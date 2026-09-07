# CI/CD workflows

Phase 4 adds two deliberately separate workflows:

- `pull-request-validation.yml` runs Terraform formatting/configuration validation, Python unit tests, and a local image build for every pull request targeting `main`. It has no AWS permissions and cannot request an OIDC token.
- `publish-ecr-image.yml` is a manually dispatched workflow. It can run only from `main`, receives a short-lived AWS session through GitHub OIDC, and publishes an immutable commit-SHA image tag to this project's private ECR repository.

The publishing workflow reads one GitHub **Actions variable** named `AWS_ROLE_TO_ASSUME`. That value is an IAM role ARN, not a credential; it identifies the short-lived role AWS should evaluate. Never store AWS access keys, secret keys, session tokens, or registry passwords in GitHub variables or secrets.

See [the OIDC runbook](../../docs/runbooks/github-actions-oidc.md) for the safe setup and validation sequence.
