# Entra ID Self-Service Password Reset (SSPR) Implementation & Automation

### Enterprise IAM Deployment using PowerShell + Microsoft Graph

Production-style implementation of Microsoft Entra ID Self-Service Password Reset (SSPR) with automated provisioning, auditing, reporting, and operational documentation.

This project demonstrates how an Identity & Access Management (IAM) engineer deploys SSPR in a real organization using:

- Least-privilege design
- Security group scoping
- PowerShell automation
- Microsoft Graph
- Operational documentation
- Troubleshooting procedures
- End-user enablement

---

# Project Objectives

Implement an enterprise-ready SSPR solution that:

- Reduces helpdesk password tickets
- Enables secure self-service recovery
- Improves user productivity
- Enforces identity verification
- Provides automated readiness checks
- Follows Infrastructure-as-Code practices

---

# Skills Demonstrated

- Microsoft Entra ID Administration
- Identity Lifecycle Management
- PowerShell scripting
- Microsoft Graph API automation
- IAM operations
- Security policy configuration
- Troubleshooting design
- Production documentation

---

# Architecture Overview

Users
↓
SSPR Security Group
↓
Authentication Methods Policy
↓
Microsoft Entra SSPR Service
↓
Password Reset Portal

yaml
Copy code

Flow:

1. User forgets password  
2. Verifies identity (SMS/Email)  
3. Sets new password  
4. System updates credentials  
5. Helpdesk ticket avoided  

---

# Folder Structure

entra-sspr-automation/
│
├── README.md
├── sspr-implementation.md
│
├── scripts/
│ ├── connect-graph.ps1
│ ├── enable-sspr.ps1
│ ├── create-sspr-group.ps1
│ ├── add-users-to-sspr-group.ps1
│ ├── audit-sspr-readiness.ps1
│ └── report-export.ps1
│
├── screenshots/
├── diagrams/
├── docs/
│ ├── user-faq.md
│ ├── admin-troubleshooting.md
│ └── communication-template.md
│
└── reports/

markdown
Copy code

---

# Features Implemented

## Core Configuration
- Enable SSPR
- Configure authentication methods
- Scope to security group
- Require verification methods

## Automation
- Create SSPR group automatically
- Bulk add users
- Audit missing recovery info
- Export readiness reports
- Microsoft Graph authentication

## Documentation
- Admin runbook
- Troubleshooting guide
- User FAQ
- Communication templates

## Operations
- Monitoring readiness
- Reporting compliance gaps
- Repeatable deployment

---

# Prerequisites

## Tenant
- Microsoft Entra ID tenant
- Global Administrator or Authentication Policy Admin

## Local Machine
- Windows 10/11
- PowerShell 7+ recommended
- Microsoft Graph module

Install:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Step-By-Step Deployment
Step 1 — Connect to Microsoft Graph
powershell
Copy code
.\scripts\connect-graph.ps1
Step 2 — Create SSPR Security Group
powershell
Copy code
.\scripts\create-sspr-group.ps1
Creates:

Copy code
SSPR-Users
Step 3 — Add Users to Group
powershell
Copy code
.\scripts\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName user@domain.com
Step 4 — Configure SSPR in Portal
Path:

pgsql
Copy code
Entra Admin Center
→ Protection
→ Password reset
Settings:

Self-service password reset → Enabled

Scope → Selected group (SSPR-Users)

Authentication methods → Phone + Email

Methods required → 2

Step 5 — Audit Readiness
powershell
Copy code
.\scripts\audit-sspr-readiness.ps1
Step 6 — Export Compliance Report
powershell
Copy code
.\scripts\report-export.ps1
Output:

bash
Copy code
/reports/sspr-readiness-report.csv
Scripts Explained
Script	Purpose
connect-graph.ps1	Authenticate to Microsoft Graph
create-sspr-group.ps1	Create security group
add-users-to-sspr-group.ps1	Add users to group
audit-sspr-readiness.ps1	Check recovery readiness
report-export.ps1	Export CSV report

Screenshots
1 — Enabling SSPR


2 — Authentication Methods Configuration


3 — Test User Added to Group


4 — User Reset Workflow


5 — Successful Reset


6 — Microsoft Graph Connection


7 — Script Execution Success


8 — Group Membership Verification


Troubleshooting
Common issues:

User not in SSPR group

No phone/email configured

Authentication methods disabled

Missing Graph permissions

See:

bash
Copy code
/docs/admin-troubleshooting.md
Security Considerations
Least-privilege role assignments

Group-based scoping

No passwords stored in scripts

Verification required for every reset

No automated password resets

Business Impact
This solution:

Reduces helpdesk workload

Lowers operational cost

Improves recovery time

Enhances user experience

Aligns with Zero Trust principles

Future Enhancements
MFA enforcement

Conditional Access integration

ServiceNow automation

Scheduled compliance checks

CI/CD deployment

Author
Patrick Nlemchi
Identity & Access Management | Entra ID | PowerShell | Security Automation

License
Educational / Portfolio Use

