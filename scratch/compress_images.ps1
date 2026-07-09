Add-Type -AssemblyName System.Drawing

$srcDir = "D:\CNBU-product-site5\home\jpg"
$destDir = "D:\CNBU-product-site5\assets\img\home"

if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir }

$mappings = @{
    "18484.jpg" = "solution-1.jpg"
    "AdobeStock_101018337.jpeg" = "solution-2.jpg"
    "shutterstock_58645486.jpg" = "solution-3.jpg"
    "vecteezy_a-person-holding-a-lightbulb-with-a-glowing-futuristic_67670335.jpg" = "solution-4.jpg"
    "vecteezy_ai-information-service-management-person-holds-global-to_49045809.jpg" = "solution-5.jpg"
    "vecteezy_ai-processor-glowing-on-circuit-board_69638995.jpg" = "solution-6.jpg"
}

$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]80)

foreach ($file in Get-ChildItem -Path $srcDir -File) {
    if ($mappings.ContainsKey($file.Name)) {
        $newName = $mappings[$file.Name]
        $destPath = Join-Path $destDir $newName
        
        $img = [System.Drawing.Image]::FromFile($file.FullName)
        
        $targetWidth = 800
        if ($img.Width -gt $targetWidth) {
            $ratio = $targetWidth / $img.Width
            $targetHeight = [math]::Round($img.Height * $ratio)
            
            $newImg = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
            $g = [System.Drawing.Graphics]::FromImage($newImg)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.DrawImage($img, 0, 0, $targetWidth, $targetHeight)
            $g.Dispose()
            
            $newImg.Save($destPath, $jpegCodec, $encoderParams)
            $newImg.Dispose()
            Write-Host "Resized and saved: $newName"
        } else {
            $img.Save($destPath, $jpegCodec, $encoderParams)
            Write-Host "Saved (no resize needed): $newName"
        }
        $img.Dispose()
    }
}
Write-Host "Done!"
