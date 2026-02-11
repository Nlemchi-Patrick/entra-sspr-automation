# SSPR Implementation Guide
## Microsoft Entra ID Self-Service Password Reset (SSPR)
### Technical Runbook & Deployment Procedure

---

# Purpose

This document provides a step-by-step technical implementation guide for deploying Self-Service Password Reset (SSRP) in Microsoft Entra ID using secure configuration practices and PowerShell automation.

It is written as an operational runbook that Identity, Security, or Systems Administrators can follow to deploy SSPR consistently across environments.

---

# Scope

## Covered

- SSPR enablement
- Authentication methods configuration
- Security group scoping
- User onboarding
- Automation via PowerShell + Microsoft Graph
- Validation testing
- Troubleshooting
- Rollback procedures

## Not Covered

- Password policy design
- MFA enforcement
- Conditional Access

---

# Architecture Summary

```
Users
   ↓
SSPR Security Group
   ↓
Authentication Methods Policy
   ↓
Microsoft Entra Password Reset Portal
```

**Core principle:**  
Group-based scoping + least privilege + automated provisioning

---

# Prerequisites

## Roles Required

One of:

- Global Administrator
- Authentication Policy Administrator
- Privileged Role Administrator

---

## Local Requirements

Install Microsoft Graph module:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

Verify:

```powershell
Get-Module Microsoft.Graph -ListAvailable
```

---

# Phase 1 — Portal Configuration (Click-by-Click)

## Step 1 — Open Entra Admin Center

Navigate to:

https://entra.microsoft.com

---

## Step 2 — Enable SSPR

Go to:

**Protection → Password reset**

| Setting | Value |
|--------|--------|
| Self service password reset | Enabled |
| Scope | Selected |
| Selected group | SSPR-Users |

Click **Save**

---

## Step 3 — Configure Authentication Methods

**Password reset → Authentication methods**

| Option | Value |
|--------|--------|
| Mobile phone | Enabled |
| Email | Enabled |
| Security questions | Disabled |
| Number of methods required | 2 |

Click **Save**

---

## Step 4 — Registration Settings

**Password reset → Registration**

| Setting | Value |
|----------|-----------|
| Require users to register | Yes |
| Reconfirm methods | 180 days |

---

# Phase 2 — PowerShell Automation

All scripts are stored in:

```
/scripts
```

---

## Step 1 — Connect to Microsoft Graph

```powershell
.\scripts\connect-graph.ps1
```

**Permissions requested**

- User.ReadWrite.All
- Group.ReadWrite.All
- Policy.ReadWrite.AuthenticationMethod

---

## Step 2 — Create SSPR Security Group

```powershell
.\scripts\create-sspr-group.ps1
```

Creates:

```
SSPR-Users
```

Purpose: used to scope who can use SSPR.

---

## Step 3 — Add Users to Group

### Single user

```powershell
.\scripts\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName user@domain.com
```

### Bulk

```powershell
Import-Csv users.csv | ForEach-Object {
    .\scripts\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName $_.UPN
}
```

---

## Step 4 — Audit User Readiness

```powershell
.\scripts\audit-sspr-readiness.ps1
```

Outputs:

- Display name
- UPN
- Missing phone numbers

---

## Step 5 — Export Compliance Report

```powershell
.\scripts\report-export.ps1
```

Output:

```
/reports/sspr-readiness-report.csv
```

Used for:

- Helpdesk follow-up
- User onboarding
- Compliance tracking

---

# Phase 3 — Testing

## Test Case 1 — Successful Reset

1. Open browser (incognito)
2. Visit https://passwordreset.microsoftonline.com
3. Enter test user
4. Complete verification
5. Set new password

**Expected:** login succeeds

---

## Test Case 2 — User Not in Group

**Expected:** reset option unavailable

---

## Test Case 3 — No Phone/Email

**Expected:** prompted to register before reset

---

# Phase 4 — Screenshots

Store images in:

```
/screenshots
```

| File | Description |
|-------|-------------|
| 01-enable-sspr.jpg | SSPR enabled |
| 02-auth-methods.jpg | Authentication methods |
| 03-sspr-test-user.jpg | Group scoping |
| 04-user-reset.jpg | Reset screen |
| 05-success.jpg | Success message |

Example:

```markdown
![Enable SSPR](screenshots/01-enable-sspr.jpg)
```

---

# Operational Procedures

## Onboard New Users

- Add to SSPR group
- Add phone/email
- Notify user to register

## Monthly Tasks

- Run readiness audit
- Export report
- Follow up with non-compliant users

---

# Troubleshooting

## Graph connection fails

```powershell
Update-Module Microsoft.Graph
```

## User not receiving code

Check:

- Correct phone format (+234...)
- Carrier SMS issues
- Spam filters

## SSPR not showing

Check:

- Group membership
- Scope set to Selected
- User re-login required

---

# Rollback Procedure

If needed:

- Disable SSPR in portal
- Remove group scoping
- Remove users from group

No passwords are modified automatically.

---

# Security Best Practices

- Use group scoping (never All users initially)
- Require two methods
- Avoid security questions
- Review logs regularly
- Follow least privilege

---

# Risks & Mitigation

| Risk | Mitigation |
|--------|-----------|
| Unauthorized reset | Multi-method verification |
| Account lockout | Helpdesk fallback |
| Missing contact info | Audit scripts |
| Social engineering | MFA + logging |

---

# Business Impact

- Reduced helpdesk tickets
- Faster recovery
- Improved uptime
- Lower operational cost

---

# Ownership

| Role | Responsibility |
|-----------|----------------|
| IAM Admin | Policy & automation |
| Helpdesk | User assistance |
| Security | Compliance monitoring |

---

# Conclusion

This implementation delivers:

- Secure  
- Scalable  
- Automated  
- Operationally ready  

SSPR configured using repeatable automation aligns with modern IAM engineering and enterprise cloud best practices.

