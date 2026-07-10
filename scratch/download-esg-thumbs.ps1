$dir = 'D:\CNBU-product-site5\pages\about\esg\thumbnails'
New-Item -ItemType Directory -Force -Path $dir | Out-Null

$imgs = [ordered]@{
  'esg-2024.png' = 'https://statics.senaonetworks.com/wp-content/uploads/2026/01/28112037/ESG_cover_2024_en.png'
  'esg-2023.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2024/11/22161609/ESG_cover_2023.jpg'
  'esg-2022.png' = 'https://www.staging6.senaonetworks.com/wp-content/uploads/ESG_cover_2022_en.png'
  'esg-2021.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2022/12/29140640/cover-en-final.jpg'
  'esg-2020.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2021/11/25110349/csr_report_2020_en.jpg'
  'esg-2019.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2020/11/06115030/report_2019_en-1.jpg'
  'esg-2018.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2020/07/13112925/csr_report_2018_en.jpg'
  'esg-2017.jpg' = 'https://statics.senaonetworks.com/wp-content/uploads/2020/07/13112928/csr_report_2017_en.jpg'
}

foreach ($name in $imgs.Keys) {
  $url = $imgs[$name]
  $out = Join-Path $dir $name
  try {
    Invoke-WebRequest -Uri $url -OutFile $out -TimeoutSec 20 -UseBasicParsing
    $kb = [math]::Round((Get-Item $out).Length / 1KB, 1)
    Write-Host "OK: $name ($kb KB)"
  } catch {
    Write-Host "FAIL: $name - $_"
  }
}
