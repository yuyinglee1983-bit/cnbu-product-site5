Add-Type -AssemblyName System.Drawing

$url = 'https://www.staging6.senaonetworks.com/wp-content/uploads/ESG_cover_2022_en.png'
$out = 'D:\CNBU-product-site5\pages\about\esg\thumbnails\esg-2022.png'

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
$session.Headers.Add("Referer", "https://www.senaonetworks.com/")

try {
  Invoke-WebRequest -Uri $url -OutFile $out -WebSession $session -TimeoutSec 30 -UseBasicParsing
  $kb = [math]::Round((Get-Item $out).Length / 1KB, 1)
  Write-Host "OK: esg-2022.png ($kb KB)"
} catch {
  Write-Host "FAIL: $_"
}
