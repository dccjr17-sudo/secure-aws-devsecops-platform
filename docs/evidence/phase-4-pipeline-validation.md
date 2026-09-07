# Phase 4 pipeline validation

Complete this evidence after the Phase 4 pull request and controlled image publication succeed. Keep all AWS account IDs, role ARNs, registry URLs, and workflow log links out of the committed record.

| Check | Expected result | Observed result |
| --- | --- | --- |
| Terraform formatting and validation | The OIDC provider, narrow ECR publishing role, and its policy validate successfully. | Pending |
| Terraform plan | Only the three Phase 4 IAM resources are created; no existing network, registry, or state resources change. | Pending |
| Pull-request validation workflow | Terraform checks, Python unit tests, and the local image build pass without AWS credentials. | Pending |
| GitHub configuration | `AWS_ROLE_TO_ASSUME` and `ECR_REPOSITORY` match their current Terraform outputs; neither is an AWS credential. | Pending |
| Main-branch publishing workflow | A manually started `main` run assumes the OIDC role and pushes one immutable `sha-<commit>` image. | Pending |
| Branch restriction | A feature-branch workflow cannot assume the publishing role. Document this as a configuration review; do not deliberately weaken controls to test it. | Pending |
| ECR scan-on-push | The newly published image has a recorded scanner result following the Phase 3 triage method. | Pending |

## Security assertions reviewed

- GitHub contains no long-lived AWS access key, secret key, session token, or registry password.
- The publishing role trusts the exact immutable GitHub repository identity and `main`, not a wildcard repository or branch.
- The role can upload to the project ECR repository only; it cannot manage networking, Terraform state, or IAM.
- PR validation has no `id-token: write` permission and does not authenticate to AWS.
