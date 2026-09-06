# Development environment

This is the first environment composition. It uses the remote backend created by `../../bootstrap` and calls the reusable network module.

1. Apply `../../bootstrap` first.
2. Copy the two `*.example` files in this directory to `backend.hcl` and `terraform.tfvars`.
3. Insert the bootstrap outputs into `backend.hcl`; make the region/project values consistent across both files.
4. Run `terraform init -backend-config=backend.hcl`, then format, validate, plan, and review the change.

The development network intentionally has no NAT gateway or private-subnet default route in Phase 1. This keeps the foundation low-cost and prevents accidental egress. Phase 3 will select the required outbound connectivity approach based on the application deployment architecture.
