Add-Type -AssemblyName System.Drawing

$images = @(
    @{ Name="Laboratory"; File="pexels-fauxels-1.jpg"; Out="services-1.jpg" },
    @{ Name="Technology"; File="retailer-1.png"; Out="services-2.jpg" },
    @{ Name="Manufacturing"; File="Robot-1.png"; Out="services-3.jpg" }
)

$inDir = "D:\CNBU-product-site5\pages\services\jpg"
$outDir = "D:\CNBU-product-site5\assets\img\home"

foreach ($img in $images) {
    $inPath = Join-Path $inDir $img.File
    $outPath = Join-Path $outDir $img.Out
    
    $bmp = [System.Drawing.Image]::FromFile($inPath)
    
    # Calculate new size (max width 800)
    $ratio = $bmp.Width / $bmp.Height
    $newWidth = 800
    $newHeight = [math]::Round($newWidth / $ratio)
    
    $newBmp = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
    $g = [System.Drawing.Graphics]::FromImage($newBmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($bmp, 0, 0, $newWidth, $newHeight)
    
    # Save as JPEG
    $newBmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    
    $g.Dispose()
    $newBmp.Dispose()
    $bmp.Dispose()
    Write-Host "Processed "
}
