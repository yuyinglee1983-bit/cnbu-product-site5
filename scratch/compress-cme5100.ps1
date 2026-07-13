Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\scratch\CME5100_src.jpg'
$dst = 'D:\CNBU-product-site5\pages\solution\com-express\cme5100\CME5100.jpg'

$img = [System.Drawing.Image]::FromFile($src)
Write-Host "Original: $($img.Width) x $($img.Height) px"

$maxW = 1200
if ($img.Width -gt $maxW) {
    $ratio = $maxW / $img.Width
    $nw = $maxW; $nh = [int]($img.Height * $ratio)
} else { $nw = $img.Width; $nh = $img.Height }

$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()

$enc = [System.Drawing.Imaging.Encoder]::Quality
$params = New-Object System.Drawing.Imaging.EncoderParameters(1)
$params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($enc, 82L)
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$bmp.Save($dst, $codec, $params)
$bmp.Dispose()

Remove-Item $src -Force

$kb = [math]::Round((Get-Item $dst).Length / 1KB, 1)
Write-Host "Done: ${nw}x${nh} (${kb} KB)"
