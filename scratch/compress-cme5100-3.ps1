Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\scratch\CME5100_3_src.png'
$dst = 'D:\CNBU-product-site5\pages\solution\com-express\cme5100\CME5100_3.png'

$img = [System.Drawing.Image]::FromFile($src)
Write-Host "Original: $($img.Width) x $($img.Height) px"

# Resize to max 1200px wide, keep aspect ratio, preserve transparency
$maxW = 1200
if ($img.Width -gt $maxW) {
    $ratio = $maxW / $img.Width
    $nw = $maxW; $nh = [int]($img.Height * $ratio)
} else { $nw = $img.Width; $nh = $img.Height }

$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$bmp.SetResolution($img.HorizontalResolution, $img.VerticalResolution)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()

$bmp.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Remove-Item $src -Force

$kb = [math]::Round((Get-Item $dst).Length / 1KB, 1)
Write-Host "Done: CME5100_3.png => ${nw}x${nh} (${kb} KB)"
