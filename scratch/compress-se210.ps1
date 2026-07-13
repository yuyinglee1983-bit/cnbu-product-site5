Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\pages\solution\edge-server\se210\SE210_S1_20250516.1015.png'
$dst = 'D:\CNBU-product-site5\pages\solution\edge-server\se210\SE210.png'

$img = [System.Drawing.Image]::FromFile($src)
Write-Host "Original: $($img.Width) x $($img.Height)"

$nw = 900; $nh = [int]($img.Height * (900 / $img.Width))
$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()
$bmp.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

$kb = [math]::Round((Get-Item $dst).Length / 1KB, 1)
Write-Host "Done: SE210.png => ${nw}x${nh} (${kb} KB)"
