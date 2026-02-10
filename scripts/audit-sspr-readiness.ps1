Get-MgUser -All |
Select DisplayName, UserPrincipalName, MobilePhone |
Where-Object {$_.MobilePhone -eq $null}
