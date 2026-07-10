Add-Type -AssemblyName System.Drawing

$files = @(
  'D:\CNBU-product-site5\pages\solution\solution.png',
  'D:\CNBU-product-site5\pages\solution\solution.jpg',
  'D:\CNBU-product-site5\pages\services\services.jpg',
  'D:\CNBU-product-site5\pages\about\buildings.jpeg',
  'D:\CNBU-product-site5\pages\news\news.jpg'
)

foreach ($f in $files) {
  if (Test-Path $f) {
    $img = [System.Drawing.Image]::FromFile($f)
    $kb = [math]::Round((Get-Item $f).Length / 1KB, 1)
    $name = [System.IO.Path]::GetFileName($f)
    Write-Host "$name => $($img.Width) x $($img.Height) | $kb KB"
    $img.Dispose()
  }
}
