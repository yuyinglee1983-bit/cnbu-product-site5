Add-Type -AssemblyName System.Drawing

# Copy 2023 as 2022 placeholder
$src23 = 'D:\CNBU-product-site5\pages\about\esg\thumbnails\esg-2023.jpg'
$out22 = 'D:\CNBU-product-site5\pages\about\esg\thumbnails\esg-2022.jpg'
Copy-Item $src23 $out22 -Force
Write-Host "Copied 2023 as 2022 placeholder"

# Compress all thumbnails to max 300x420 (portrait cover ratio), quality 82
$files = Get-ChildItem 'D:\CNBU-product-site5\pages\about\esg\thumbnails' -Filter '*.*' |
  Where-Object { $_.Extension -in '.jpg','.jpeg','.png' }

foreach ($f in $files) {
  $src = $f.FullName
  # Force save as jpg regardless of original format
  $outPath = [System.IO.Path]::ChangeExtension($src, '.jpg')

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
  $bmp.Save($outPath, $enc, $params)
  $bmp.Dispose()

  # Remove original if it was PNG (now saved as jpg)
  if ($f.Extension -eq '.png' -and $outPath -ne $src) {
    Remove-Item $src -Force
  }

  $kb = [math]::Round((Get-Item $outPath).Length / 1KB, 1)
  Write-Host "Done: $([System.IO.Path]::GetFileName($outPath)) => ${nw}x${nh} (${kb} KB)"
}
