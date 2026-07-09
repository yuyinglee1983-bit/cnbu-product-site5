$ErrorActionPreference = "Stop"

$site4File = "D:\CNBU-product-site4\pages\platforms\edge-platform\index.html"
$site5File = "D:\CNBU-product-site5\scratch\generate_pages.ps1"

$site4Content = Get-Content -Path $site4File -Raw -Encoding UTF8

$styleMatch = [regex]::Match($site4Content, '(?s)<style>(.*?)</style>')
$bodyMatch = [regex]::Match($site4Content, '(?s)<!-- ════ HERO ════ -->(.*?)<!-- ════ CTA ════ -->')
$scriptMatch = [regex]::Match($site4Content, '(?s)<script>\s*(// Tab switching.*?)</script>')

if (-not $styleMatch.Success -or -not $bodyMatch.Success) {
    Write-Host "Failed to extract from site4."
    exit 1
}

$site4Style = $styleMatch.Groups[1].Value
$site4Body = $bodyMatch.Groups[1].Value
$site4Script = ""
if ($scriptMatch.Success) {
    $site4Script = $scriptMatch.Groups[1].Value
}

$newRaxBody = "`$raxBody = @`"`n<style>`n.page-hero { display: none !important; }`n" + $site4Style + "</style>`n" + $site4Body + "<script>`n" + $site4Script + "</script>`n`"@"

$site5Content = Get-Content -Path $site5File -Raw -Encoding UTF8

# The regex replaces the old $raxBody definition
$site5Content = $site5Content -replace '(?s)\$raxBody = @"\r?\n<section class="section"><div class="wrap fu"><div class="content-grid">.*?</section>\r?\n"@', $newRaxBody

Set-Content -Path $site5File -Value $site5Content -Encoding UTF8

Write-Host "Replacement complete."
