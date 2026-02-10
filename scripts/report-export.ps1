Get-MgUser -All |
Select DisplayName, UserPrincipalName, MobilePhone |
Export-Csv ..\reports\sspr-readiness-report.csv -NoTypeInformation
