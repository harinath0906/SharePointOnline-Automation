
$User = "username@company.com"
$SiteURL = "https://testing.sharepoint.com/site"

$Password = "password"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
#Bind to site collection

$Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,(ConvertTo-SecureString $Password -AsPlainText -Force))
$Ctx.Credentials = $Creds
$FileUrl = "https://testing.sharepoint.com/site/folder/file.docx"
$DownloadPath = "C:\DownloadFolder\"
$fileName = [System.IO.Path]::GetFileName($FileUrl)

$downloadFilePath = [System.IO.Path]::Combine($DownloadPath,$fileName)

$client = New-Object System.Net.WebClient 
$client.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,(ConvertTo-SecureString $Password -AsPlainText -Force))
$client.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
$client.DownloadFile($FileUrl, $downloadFilePath)
$client.Dispose()