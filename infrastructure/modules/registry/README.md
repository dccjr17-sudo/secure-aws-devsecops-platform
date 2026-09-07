# Private container registry module

Creates the Phase 3 ECR repository for the application image.

- Private repository only; it is not internet-facing.
- Immutable image tags prevent a tag from being silently overwritten.
- Scan-on-push enables Amazon ECR image scanning.
- AES-256 server-side encryption protects images at rest.
- Lifecycle policy retains a bounded number of recent images to control storage growth.

The repository does not yet contain a CI/CD permissions policy. That role will be created in Phase 4 using GitHub OIDC and least privilege.
