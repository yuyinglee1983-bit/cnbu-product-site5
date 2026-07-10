Add-Type -AssemblyName System.Drawing

function Compress-Image {
  param(
    [string]$src,
    [int]$maxW = 800,
    [int]$maxH = 600,
    [int]$quality = 80
  )
  $img = [System.Drawing.Image]::FromFile($src)
  $ratio = [Math]::Min($maxW / $img.Width, $maxH / $img.Height)
  if ($ratio -ge 1) { $ratio = 1 }
  $nw = [int]($img.Width * $ratio)
  $nh = [int]($img.Height * $ratio)
  $bmp = New-Object System.Drawing.Bitmap($nw, $nh)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($img, 0, 0, $nw, $nh)
  $g.Dispose()
  $img.Dispose()
  $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
  $params = New-Object System.Drawing.Imaging.EncoderParameters(1)
  $params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]$quality)
  $bmp.Save($src, $enc, $params)
  $bmp.Dispose()
  $sizeMB = [math]::Round((Get-Item $src).Length / 1KB, 1)
  Write-Host "Done: $src => ${nw}x${nh} px, ${sizeMB} KB"
}

Compress-Image 'D:\CNBU-product-site5\pages\ai-hub\raxel-ai\raxel.jpg'     800 600 80
Compress-Image 'D:\CNBU-product-site5\pages\services\jpg\services.jpg'      800 600 80
Compress-Image 'D:\CNBU-product-site5\pages\news\news.jpg'                  800 600 80
Compress-Image 'D:\CNBU-product-site5\pages\about\buildings.jpeg'           800 600 80

Write-Host ""
Write-Host "=== Final sizes ==="
Get-Item "D:\CNBU-product-site5\pages\ai-hub\raxel-ai\raxel.jpg",
         "D:\CNBU-product-site5\pages\services\jpg\services.jpg",
         "D:\CNBU-product-site5\pages\news\news.jpg",
         "D:\CNBU-product-site5\pages\about\buildings.jpeg" |
  Select-Object Name, @{N="Size(KB)";E={[math]::Round($_.Length/1KB,1)}}
