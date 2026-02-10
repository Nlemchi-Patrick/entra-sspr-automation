$group = New-MgGroup `
-DisplayName "SSPR-Users" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "ssprusers"

$group.Id
