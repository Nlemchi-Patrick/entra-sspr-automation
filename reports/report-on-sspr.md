# SSPR Deployment & Operations Report

Self-Service Password Reset (SSPR) implementation guide covering:

- Portal configuration
- PowerShell automation
- Testing procedures
- Operations
- Troubleshooting
- Security controls

This document serves as the **administrative runbook** for production use.

---

# Phase 1 — Portal Configuration (Click-by-Click)

## Step 1 — Open Entra Admin Center

Navigate to:

https://entra.microsoft.com

yaml
Copy code

---

## Step 2 — Enable SSPR

Path:

Protection → Password reset

yaml
Copy code

Configuration:

| Setting | Value |
|--------|-------|
| Self service password reset | Enabled |
| Scope | Selected |
| Selected group | SSPR-Users |

Click **Save**.

---

## Step 3 — Configure Authentication Methods

Path:

Password reset → Authentication methods

yaml
Copy code

Recommended:

| Option | Value |
|--------|--------|
| Mobile phone | Enabled |
| Email | Enabled |
| Security questions | Disabled |
| Number of methods required | 2 |

Click **Save**.

---

## Step 4 — Registration Settings

Path:

Password reset → Registration

yaml
Copy code

| Setting | Value |
|---------|---------|
| Require users to register | Yes |
| Reconfirm methods | 180 days |

---

# Phase 2 — PowerShell Automation

All scripts are stored in:

/scripts

yaml
Copy code

---

## Step 1 — Connect to Microsoft Graph

```powershell
.\scripts\connect-graph.ps1
Permissions requested:

User.ReadWrite.All

Group.ReadWrite.All

Policy.ReadWrite.AuthenticationMethod

Step 2 — Create SSPR Security Group
powershell
Copy code
.\scripts\create-sspr-group.ps1
Creates:

Copy code
SSPR-Users
Purpose:
Used to scope which users can use SSPR.

Step 3 — Add Users to Group
Single user
powershell
Copy code
.\scripts\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName user@domain.com
Bulk users
powershell
Copy code
Import-Csv users.csv | ForEach-Object {
    .\scripts\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName $_.UPN
}
Step 4 — Audit User Readiness
powershell
Copy code
.\scripts\audit-sspr-readiness.ps1
Detects:

Display name

UPN

Missing phone numbers

Missing recovery methods

Step 5 — Export Compliance Report
powershell
Copy code
.\scripts\report-export.ps1
Output:

bash
Copy code
/reports/sspr-readiness-report.csv
Use cases:

Helpdesk follow-up

User onboarding

Compliance tracking

Phase 3 — Testing
Test Case 1 — Successful Reset
Steps:

Open browser (Incognito)

Go to https://passwordreset.microsoftonline.com

Enter test user

Complete verification

Set new password

Expected result:

Password change successful

User can sign in

Test Case 2 — User Not in Group
Expected:

Reset option unavailable

Test Case 3 — No Phone/Email
Expected:

User prompted to register before reset

Operational Procedures
Onboard New Users
Add to SSPR group

Add phone/email

Notify user to register

Monthly Tasks
Run readiness audit

Export compliance report

Follow up with non-compliant users

Incident Handling
If user cannot reset:

Check:

Group membership

Phone/email registered

Policy enabled

Tenant synchronization issues

Troubleshooting
Graph Connection Fails
powershell
Copy code
Update-Module Microsoft.Graph
User Not Receiving Code
Check:

Correct phone format (+234...)

Carrier SMS delivery issues

Spam filters

SSPR Not Showing
Check:

User in correct group

Scope set to Selected

User signs out/in again

Rollback Procedure
If needed:

Disable SSPR in portal

Remove group scoping

Remove users from group

No passwords are modified automatically.

Security Best Practices
Use group scoping (avoid All Users initially)

Require 2 verification methods

Avoid security questions

Review logs regularly

Follow least-privilege model

Risks & Mitigation
Risk	Mitigation
Unauthorized reset	Multi-method verification
Account lockout	Helpdesk fallback
Missing contact info	Audit scripts
Social engineering	MFA + logging

Business Impact
Measured benefits:

Reduced helpdesk tickets

Faster recovery

Improved uptime

Lower operational cost

Ownership
Role	Responsibility
IAM Admin	Policy & automation
Helpdesk	User assistance
Security	Compliance monitoring

Conclusion
This implementation delivers:

Secure design

Scalable architecture

Automated operations

Production readiness

SSPR configured using repeatable automation aligns with modern IAM engineering and enterprise cloud best practices.