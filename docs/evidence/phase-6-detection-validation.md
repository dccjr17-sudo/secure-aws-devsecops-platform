# Phase 6 security validation evidence

## Scope

This evidence record is completed after the Phase 6 pull request passes and the approved lab plan is applied. It proves managed configuration handling, audit logging, and a controlled detection event without retaining a secret value, account identifier, ARN, finding ID, or raw CloudTrail event.

## Expected validation

| Control | Expected result | Safe evidence to record |
| --- | --- | --- |
| Terraform | Formatting and validation succeed; the plan contains only the intended Phase 6 changes | Pass/fail and resource categories only |
| Managed configuration | An empty Secrets Manager container exists and a harmless JSON demonstration object can be added outside Terraform | Secret name redacted or generic; never record the value |
| Runtime boundary | Application unit test proves no AWS call is made without `APP_CONFIG_SECRET_ID`; the future runtime policy names one secret and KMS key only | Test result and policy scope summary |
| Audit | CloudTrail is logging management events to the dedicated encrypted bucket | `IsLogging = true`; no bucket name or events |
| Detection | A GuardDuty sample finding is generated intentionally and its generic type/severity can be reviewed | Generic sample type and severity; no finding/account IDs |
| Alerting choice | No unmanaged email or chat destination is created without an incident owner | Decision reference to ADR-007 |

## Observed results

Complete this table after the approved apply and controlled-finding exercise.

| Check | Observed result | Date | Notes |
| --- | --- | --- | --- |
| Pull-request checks | Pending Phase 6 PR | — | Record all-green status only. |
| Terraform validation | Pending lab apply | — | Do not commit plans or state. |
| Managed secret metadata | Pending lab apply | — | Do not copy the secret value. |
| CloudTrail logging | Pending lab apply | — | Record only the boolean result. |
| GuardDuty sample finding | Pending explicit opt-in | — | Identify it as controlled test data. |
| Security Hub enabled | Pending explicit opt-in | — | No standards enabled in Phase 6. |

## Explanation for review

The test finding is deliberately created with GuardDuty's sample-finding API. Its presence proves that the detector can produce and expose a finding; it does not represent malicious activity. The exercise is complete only when the finding is recognized as a sample, its severity is interpreted, and the user records the next action: close as validated test data, investigate a real finding, or disable the service after the trial decision.
