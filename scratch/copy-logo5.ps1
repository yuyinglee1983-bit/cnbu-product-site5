Add-Type -AssemblyName System.Drawing

$src = 'D:\CNBU-product-site5\LOGO5.png'
$img = [System.Drawing.Image]::FromFile($src)
Write-Host "Original: $($img.Width) x $($img.Height)"

# Keep PNG for logo (transparency support), just optimize size
# Copy to assets/img/LOGO5.png as-is (PNG logos often need transparency)
$dst1 = 'D:\CNBU-product-site5\assets\img\LOGO5.png'
Copy-Item $src $dst1 -Force
$img.Dispose()

$kb = [math]::Round((Get-Item $dst1).Length / 1KB, 1)
Write-Host "Copied to assets/img/LOGO5.png ($kb KB)"
