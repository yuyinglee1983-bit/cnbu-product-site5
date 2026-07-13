Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\LOGO6.png'
$dst = 'D:\CNBU-product-site5\assets\img\LOGO6.png'

$img = [System.Drawing.Image]::FromFile($src)
Write-Host "Original: $($img.Width) x $($img.Height)"

# Resize to 600px wide, keep aspect ratio, preserve transparency
$ratio = 600 / $img.Width
$nw = 600
$nh = [int]($img.Height * $ratio)

$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$bmp.SetResolution($img.HorizontalResolution, $img.VerticalResolution)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()
$bmp.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

$kb = [math]::Round((Get-Item $dst).Length / 1KB, 1)
Write-Host "Done: LOGO6.png => ${nw}x${nh} (${kb} KB)"
