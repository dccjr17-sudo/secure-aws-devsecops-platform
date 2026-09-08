# Phase 5 security-gates validation

## Baseline and remediation

| Check | Initial result | Remediation | Retest target |
| --- | --- | --- | --- |
| Python dependencies | `pip-audit` found `PYSEC-2026-2151` in Flask 3.1.2; fixed in Flask 3.1.3. | Updated `app/requirements.txt` to Flask 3.1.3. | Retest: no known vulnerabilities found. |
| Application SAST | Semgrep Community Edition scanned the two tracked application-source files with 1,074 Python and multi-language rules. | No source finding was reported in the baseline scan. | The SAST gate is green in the Phase 5 pull request. |
| Terraform policy checks | Checkov 3.3.16 passed 15 selected checks with zero failures. | Added the focused checks as a blocking gate and documented 11 broader findings separately. | The IaC gate is green in the Phase 5 pull request. |
| Container image | Prior ECR scan baseline: zero Critical findings; High findings remain under triage. | Trivy reports High and Critical findings and blocks on Critical. | The container gate is green with no Critical findings. |
| Secret scanner test | Gitleaks detected one synthetic generic API-key pattern and redacted it in output. | The test file was untracked and immediately removed. | Repository scan contains no synthetic test value. |

## Pull-request results

Add the sanitized Phase 5 pull-request check summary here after the workflow completes. Record gate names and result states only; do not upload raw logs or values that resemble credentials.
