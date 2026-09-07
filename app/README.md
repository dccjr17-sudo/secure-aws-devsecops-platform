# Application

This deliberately small application is the workload for the secure AWS DevSecOps platform. It exposes only a project landing response and a health endpoint; the emphasis is on a repeatable, secure delivery path rather than application features.

## Endpoints

| Endpoint | Purpose | Expected response |
| --- | --- | --- |
| `/` | Confirms the application is running | JSON project message |
| `/health` | Container/orchestrator health check | `{"status":"ok"}` |

## Local validation

Run the following commands from the repository root:

```powershell
docker buildx build --platform linux/amd64 --provenance=false --sbom=false --load --tag secure-aws-devsecops-app:local app
docker run --rm --publish 8080:8080 --name secure-aws-devsecops-app secure-aws-devsecops-app:local
```

In a second PowerShell window, test the health endpoint:

```powershell
Invoke-RestMethod http://localhost:8080/health
```

Stop the running container with `Ctrl+C` in the first window. Then run the application tests inside the same image:

```powershell
docker run --rm --entrypoint python secure-aws-devsecops-app:local -m unittest discover -s tests -v
```

## Security choices

- The container runs as an unprivileged user rather than `root`.
- The service listens on port 8080, avoiding privileged ports.
- Dependencies are installed without a pip cache.
- The image has a built-in health check and does not embed credentials or environment-specific configuration.
- The runtime uses the minimal Alpine-based Python image to reduce unused operating-system packages. Build attestations remain disabled in local and Phase 4 publishing so ECR Basic Scanning receives a scan-compatible single-platform manifest; independent provenance will be revisited with the Phase 5 supply-chain controls.
- Phase 3 adds ECR image scanning and a private image registry.
- Phase 4 uses GitHub Actions to repeat the unit tests and build, then manually publishes an immutable `sha-<commit>` image through a short-lived OIDC role on `main`.
