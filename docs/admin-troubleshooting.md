\# Admin Troubleshooting Guide

\## Microsoft Entra ID – SSPR Operations



This guide helps administrators quickly diagnose and resolve common Self-Service Password Reset (SSPR) deployment and automation issues.



---



\# Quick Triage Checklist



Before deep troubleshooting, confirm:



\- User is in the correct SSPR security group

\- Phone or email is registered

\- Authentication methods policy is enabled

\- User has signed out/in after changes

\- Graph module is installed

\- Required permissions are granted



---



\# Issue 1 — User Cannot Reset Password



\## Symptoms

\- Reset portal shows error

\- Verification never starts

\- User blocked



\## Checks



\### 1. Group membership

```powershell

Get-MgGroupMember -GroupId <GroupId>

```



\### 2. Authentication info exists

Check user profile → Authentication methods



\### 3. Policy enabled

Entra → Protection → Password reset → Enabled



\## Fix

\- Add user to SSPR group

\- Configure phone/email

\- Have user sign out and retry



---



\# Issue 2 — Reset Option Not Visible



\## Symptoms

\- "Forgot password" not shown

\- Portal says not eligible



\## Checks

\- Scope set to \*\*Selected\*\*

\- Correct group assigned

\- User included in group



\## Fix

\- Add correct group

\- Wait 5–10 minutes for policy propagation

\- User sign out/in



---



\# Issue 3 — Authentication Code Not Received



\## Symptoms

\- SMS/email never arrives



\## Checks

\- Phone format correct (e.g. +234xxxxxxxxxx)

\- Email correct

\- Carrier delays or spam filter



\## Fix

\- Re-enter contact method

\- Try alternate method

\- Test with different network



---



\# Issue 4 — Graph Script Fails



\## Symptoms

\- Cmdlets not found

\- Permission errors

\- Authentication failure



\## Checks



\### Module installed

```powershell

Get-Module Microsoft.Graph -ListAvailable

```



\### Install/Update

```powershell

Install-Module Microsoft.Graph -Scope CurrentUser

Update-Module Microsoft.Graph

```



\### Connect with correct scopes

```powershell

Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Policy.ReadWrite.AuthenticationMethod"

```



\## Fix

\- Install/update module

\- Reconnect with correct scopes

\- Run PowerShell as Administrator



---



\# Issue 5 — Users Not Added to Group by Script



\## Checks

```powershell

Get-MgGroup -DisplayName "SSPR-Users"

Get-MgGroupMember -GroupId <GroupId>

```



\## Common Causes

\- Wrong GroupId

\- Typo in UPN

\- CSV formatting issues



\## Fix

\- Validate GroupId

\- Confirm CSV headers match script

\- Retry script



---



\# Issue 6 — Audit Script Shows Missing Methods



\## Meaning

Users have not registered recovery methods.



\## Fix

\- Notify users

\- Require registration

\- Re-run:

```powershell

.\\scripts\\audit-sspr-readiness.ps1

```



---



\# Escalation Steps



If unresolved:



1\. Check Entra Audit Logs

2\. Review Sign-in Logs

3\. Test with new user account

4\. Recreate policy

5\. Re-run automation scripts



---



\# Preventive Best Practices



\- Use group scoping only (never All Users initially)

\- Require two authentication methods

\- Run monthly readiness audit

\- Export compliance reports

\- Keep Graph module updated

\- Apply least privilege roles



---



\# Summary



Most SSPR issues fall into:



\- Group membership

\- Missing authentication methods

\- Policy scope misconfiguration

\- Graph permissions/module problems



Validate these first before deeper investigation.



