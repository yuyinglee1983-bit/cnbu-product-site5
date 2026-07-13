Add-Type -AssemblyName System.Drawing

# Check if original has transparency by sampling pixels
$orig = 'D:\CNBU-product-site5\pages\solution\com-express\com7000\COM7000.png'
$webPng = 'D:\CNBU-product-site5\pages\solution\com-express\com7000\COM7000_web.png'
$dst = 'D:\CNBU-product-site5\pages\solution\com-express\com7000\COM7000_web.jpg'

$img = [System.Drawing.Image]::FromFile($webPng)
$nw = 700; $nh = [int]($img.Height * (700 / $img.Width))

$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
# Fill white background (JPEG doesn't support transparency)
$g.Clear([System.Drawing.Color]::White)
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()

$enc = [System.Drawing.Imaging.Encoder]::Quality
$params = New-Object System.Drawing.Imaging.EncoderParameters(1)
$params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($enc, 85L)
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$bmp.Save($dst, $codec, $params)
$bmp.Dispose()

Remove-Item $webPng -Force

$kb = [math]::Round((Get-Item $dst).Length / 1KB, 1)
Write-Host "Done: ${nw}x${nh} JPEG (${kb} KB)"
