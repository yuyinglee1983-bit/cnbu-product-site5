Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\pages\about\esg\2022.png'
$out = 'D:\CNBU-product-site5\pages\about\esg\thumbnails\esg-2022.jpg'

$img = [System.Drawing.Image]::FromFile($src)
$ratio = [Math]::Min(300 / $img.Width, 420 / $img.Height)
if ($ratio -ge 1) { $ratio = 1 }
$nw = [int]($img.Width * $ratio)
$nh = [int]($img.Height * $ratio)
$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()
$enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
  Where-Object { $_.MimeType -eq 'image/jpeg' }
$params = New-Object System.Drawing.Imaging.EncoderParameters(1)
$params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
  [System.Drawing.Imaging.Encoder]::Quality, [long]82)
$bmp.Save($out, $enc, $params)
$bmp.Dispose()
$kb = [math]::Round((Get-Item $out).Length / 1KB, 1)
Write-Host "Done: esg-2022.jpg => ${nw}x${nh} (${kb} KB)"
