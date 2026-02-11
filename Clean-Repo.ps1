# Define the paths
$gitignorePath = ".gitignore"
$reportFolder = "reports"
$screenshotsFolder = "screenshots"

# Step 1: Create or update the .gitignore file
$gitignoreContent = @"
# Ignore generated reports and logs
$reportFolder/
*.log

# Ignore large screenshots if any
$screenshotsFolder/*.png

# Ignore temporary files
*.tmp
"@

# Write the .gitignore content to the file
Set-Content -Path $gitignorePath -Value $gitignoreContent

Write-Host "Created or updated .gitignore file."

# Step 2: Remove large files from Git tracking (cached only, not deleted)
# Remove reports and large screenshots from tracking
git rm -r --cached $reportFolder
git rm --cached "$screenshotsFolder/*.png"

Write-Host "Removed large files from Git tracking."

# Step 3: Commit the changes
git add .gitignore
git commit -m "Add .gitignore and remove large generated files from tracking"

Write-Host "Committed changes."

# Step 4: Push to the remote repository
git push

Write-Host "Pushed changes to remote repository."
