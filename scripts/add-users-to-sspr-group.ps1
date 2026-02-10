param(
    [Parameter(Mandatory)]
    [string]$GroupId,

    [Parameter(Mandatory)]
    [string]$UserPrincipalName
)

Write-Host "Connecting user lookup..."

$user = Get-MgUser -UserId $UserPrincipalName -ErrorAction Stop

Write-Host "Checking existing membership..."

$members = Get-MgGroupMember -GroupId $GroupId -All

if ($members.Id -contains $user.Id) {
    Write-Host "User already in group. Skipping." -ForegroundColor Yellow
}
else {
    Write-Host "Adding user to group..." -ForegroundColor Cyan
    New-MgGroupMember -GroupId $GroupId -DirectoryObjectId $user.Id
    Write-Host "User successfully added." -ForegroundColor Green
}




# ================================
# Function: Verify user membership
# ================================
function Verify-UserInGroup {
    param(
        [string]$UserPrincipalName,
        [string]$GroupId
    )

    Write-Host "`nVerifying membership..." -ForegroundColor Cyan

    $members = Get-MgGroupMember -GroupId $GroupId -All

    $member = $members | Where-Object { $_.AdditionalProperties.userPrincipalName -eq $UserPrincipalName }

    if ($member) {
        Write-Host "Confirmed:" $member.AdditionalProperties.displayName "is in the group." -ForegroundColor Green
    } else {
        Write-Host "$UserPrincipalName is NOT in the group." -ForegroundColor Yellow
    }
}