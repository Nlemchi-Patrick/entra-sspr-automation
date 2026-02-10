Phase 1 — Portal Configuration (Click-by-Click)

Step 1 — Open Entra Admin Center



Navigate to:



https://entra.microsoft.com



Step 2 — Enable SSPR



Go to:



Protection

→ Password reset





Set:



Setting	Value

Self service password reset	Enabled

Scope	Selected

Selected group	SSPR-Users



Click Save



Step 3 — Configure Authentication Methods



Navigate:



Password reset → Authentication methods





Recommended:



Option	Value

Mobile phone	Enabled

Email	Enabled

Security questions	Disabled (less secure)

Number of methods required	2



Click Save



Step 4 — Registration Settings



Navigate:



Password reset → Registration





Set:



Require users to register: Yes



Reconfirm methods: 180 days



Phase 2 — PowerShell Automation



All scripts are stored in:



/scripts



Step 1 — Connect to Graph

.\\scripts\\connect-graph.ps1





Permissions requested:



User.ReadWrite.All



Group.ReadWrite.All



Policy.ReadWrite.AuthenticationMethod



Step 2 — Create SSPR Security Group

.\\scripts\\create-sspr-group.ps1





Creates:



SSPR-Users





Purpose:



Used to scope who can use SSPR.



Step 3 — Add Users to Group



Single user:



.\\scripts\\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName user@domain.com





Bulk option:



Import-Csv users.csv | ForEach-Object {

&nbsp;   .\\scripts\\add-users-to-sspr-group.ps1 -GroupId <group-id> -UserPrincipalName $\_.UPN

}



Step 4 — Audit User Readiness



Detect missing recovery methods:



.\\scripts\\audit-sspr-readiness.ps1





Shows:



Display name



UPN



Missing phone numbers



Step 5 — Export Compliance Report

.\\scripts\\report-export.ps1





Output:



/reports/sspr-readiness-report.csv





Use for:



Helpdesk follow-up



User onboarding



Compliance tracking



Phase 3 — Testing

Test Case 1 — Successful Reset



Steps:



Open browser (incognito)



Go to:

https://passwordreset.microsoftonline.com



Enter test user



Complete verification



Set new password



Expected:



Password change successful



Login works



Test Case 2 — User Not in Group



Expected:



Reset option unavailable



Test Case 3 — No Phone/Email



Expected:



Prompt to register before reset



Operational Procedures

Onboard New Users



Add to SSPR group



Add phone/email



Notify user to register



Monthly Tasks



Run readiness audit



Export report



Follow up with non-compliant users



Incident Handling



If user cannot reset:



Check:



Group membership



Phone/email present



Policy enabled



Tenant sync issues



Troubleshooting

Graph Connection Fails



Fix:



Update-Module Microsoft.Graph



User Not Receiving Code



Check:



Correct phone format (+234...)



Carrier SMS issues



Spam filters



SSPR Not Showing



Check:



Group assigned correctly



Scope set to Selected



User re-login required



Rollback Procedure



If needed:



Disable SSPR in portal



Remove group scoping



Remove users from group



No passwords are modified automatically.



Security Best Practices



Use group scoping (never All users initially)



Require 2 methods



Avoid security questions



Review logs regularly



Follow least privilege



Risks \& Mitigation

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

IAM Admin	Policy \& automation

Helpdesk	User assistance

Security	Compliance monitoring


Conclusion

This implementation delivers:



Secure



Scalable



Automated



Operationally ready



SSPR configured using repeatable automation aligns with modern IAM engineering and enterprise cloud best practices.

