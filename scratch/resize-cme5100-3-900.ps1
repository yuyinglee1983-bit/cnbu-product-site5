Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\pages\solution\com-express\cme5100\CME5100_3.png'
$tmp = 'D:\CNBU-product-site5\pages\solution\com-express\cme5100\CME5100_3_tmp.png'

$img = [System.Drawing.Image]::FromFile($src)
$nw = 900; $nh = [int]($img.Height * (900 / $img.Width))

$bmp = New-Object System.Drawing.Bitmap($nw, $nh)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)
$g.DrawImage($img, 0, 0, $nw, $nh)
$g.Dispose(); $img.Dispose()
$bmp.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Remove-Item $src -Force
Rename-Item $tmp $src

$kb = [math]::Round((Get-Item $src).Length / 1KB, 1)
Write-Host "Done: ${nw}x${nh} (${kb} KB)"
