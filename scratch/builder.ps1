# Master generator for CNBU-product-site5
# 27 clean files with correct file:// compatible index.html links

function BuildPage($file, $title, $depth, $breadcrumbs, $eyebrow, $h1, $desc, $body) {
    # Calculate root relative path
    $r = ""
    for ($i = 0; $i -lt $depth; $i++) { $r += "../" }
    if ($depth -eq 0) { $r = "./" }

    # Build breadcrumb HTML
    $bcHTML = ""
    if ($breadcrumbs.Count -gt 0) {
        $bcHTML += "<nav class=`"breadcrumb`"><a href=`"${r}index.html`">Home</a>"
        for ($i = 0; $i -lt $breadcrumbs.Count; $i += 2) {
            $label = $breadcrumbs[$i]
            $link = $breadcrumbs[$i+1]
            $bcHTML += "<span class=`"sep`">&rsaquo;</span>"
            if ($link) {
                $bcHTML += "<a href=`"${r}${link}`">${label}</a>"
            } else {
                $bcHTML += "<span>${label}</span>"
            }
        }
        $bcHTML += "</nav>"
    }

    # Style extensions
    $styleExtra = ""
    if ($title -eq "index") {
        # Homepage styles
        $styleExtra = @"
<style>
.home-hero {
  position: relative;
  background: linear-gradient(140deg, #060e1e 0%, #0b2252 55%, #0d3a6b 100%);
  min-height: 88vh;
  display: flex; align-items: center;
  overflow: hidden;
}
.home-hero::before {
  content: '';
  position: absolute; inset: 0;
  background: radial-gradient(ellipse 80% 60% at 70% 40%, rgba(0,152,181,.18) 0%, transparent 70%);
}
.hero-content { position: relative; z-index: 2; max-width: 720px; }
.hero-badge {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 5px 14px; border: 1px solid rgba(0,152,181,.4);
  border-radius: 100px; font-size: 11px; font-weight: 700;
  letter-spacing: .08em; color: var(--cyan);
  background: rgba(0,152,181,.1); margin-bottom: 28px;
}
.hero-badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: var(--cyan); animation: pulse 2s ease infinite; }
@keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.7)} }
.home-hero h1 {
  font-size: clamp(40px, 6vw, 80px);
  font-weight: 800; line-height: 1.06;
  letter-spacing: -.04em; color: #fff;
  margin-bottom: 22px;
}
.home-hero h1 em {
  font-style: normal;
  background: linear-gradient(110deg, #00c2e0 0%, #7fe0ff 45%, #fff 50%, #7fe0ff 55%, #00c2e0 100%);
  background-size: 400% auto;
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: shimmer 3.5s ease infinite;
}
@keyframes shimmer { 0%{background-position:200% center} 100%{background-position:-200% center} }
.home-hero .sub { font-size: 18px; color: rgba(255,255,255,.65); line-height: 1.8; margin-bottom: 40px; }
.hero-actions { display: flex; gap: 14px; flex-wrap: wrap; }
.sections-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0;
  border-top: 1px solid var(--line);
}
.sec-block {
  padding: 48px 36px;
  border-right: 1px solid var(--line);
  border-bottom: 1px solid var(--line);
  transition: background .2s;
}
.sec-block:last-child, .sec-block:nth-child(3) { border-right: none; }
.sec-block:hover { background: #f7f9ff; }
.sec-icon { font-size: 28px; margin-bottom: 16px; }
.sec-block h2 { font-size: 18px; font-weight: 800; color: var(--navy); margin-bottom: 10px; }
.sec-block .sec-desc { font-size: 13px; color: var(--muted); line-height: 1.7; margin-bottom: 20px; }
.sec-links { list-style: none; display: flex; flex-direction: column; gap: 6px; }
.sec-links a {
  font-size: 13px; font-weight: 600; color: var(--blue);
  display: flex; align-items: center; gap: 6px;
  transition: gap .2s, color .2s;
}
.sec-links a::before { content: '→'; font-size: 11px; }
.sec-links a:hover { gap: 10px; color: var(--cyan); }
.stats-bar {
  background: var(--navy);
  display: grid; grid-template-columns: repeat(4,1fr);
}
.stat { padding: 36px 24px; border-right: 1px solid rgba(255,255,255,.08); text-align: center; }
.stat:last-child { border-right: none; }
.stat-n { font-size: 40px; font-weight: 800; color: #fff; line-height: 1; margin-bottom: 6px; }
.stat-n span { color: var(--cyan); }
.stat-l { font-size: 12px; color: rgba(255,255,255,.5); letter-spacing: .06em; text-transform: uppercase; }
@media(max-width:900px) {
  .sections-row { grid-template-columns: repeat(2,1fr); }
  .sec-block:nth-child(3) { border-right: 1px solid var(--line); }
  .sec-block:nth-child(2n) { border-right: none; }
  .stats-bar { grid-template-columns: repeat(2,1fr); }
}
@media(max-width:560px) {
  .sections-row { grid-template-columns: 1fr; }
  .sec-block { border-right: none !important; }
}
</style>
"@
    } elseif ($file -match "solution[\\/][^\\/]+[\\/]index\.html$") {
        # Solution detail pages styles
        $styleExtra = @"
<style>
.feat-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-bottom:56px}
.feat-box{padding:32px 28px;border:1.5px solid var(--line);border-radius:14px;background:#fff;transition:border-color .25s,box-shadow .25s}
.feat-box:hover{border-color:rgba(0,94,184,.35);box-shadow:0 12px 32px rgba(0,50,120,.08)}
.feat-box .fi{font-size:32px;margin-bottom:16px}
.feat-box h3{font-size:18px;font-weight:800;color:var(--navy);margin-bottom:10px}
.feat-box p{font-size:14px;color:var(--muted);line-height:1.7}
.spec-table{width:100%;border-collapse:collapse;font-size:14px}
.spec-table th{text-align:left;padding:12px 18px;background:var(--soft);font-size:11px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--muted);border-bottom:1px solid var(--line)}
.spec-table td{padding:14px 18px;border-bottom:1px solid var(--line);color:#2a3550}
.spec-table tr:last-child td{border-bottom:none}
.spec-table tr:hover td{background:#f7f9ff}
.two-col{display:grid;grid-template-columns:1.2fr 1fr;gap:56px;align-items:start;margin-top:48px}
.info-block h2{font-size:32px;font-weight:800;color:var(--navy);margin-bottom:16px;letter-spacing:-.02em}
.info-block p{font-size:15px;color:var(--muted);line-height:1.85;margin-bottom:24px}
.tag-list{display:flex;flex-wrap:wrap;gap:8px;margin-top:20px}
.tag{display:inline-block;padding:6px 14px;border-radius:100px;font-size:12px;font-weight:700;color:var(--blue);background:rgba(0,94,184,.08);border:1px solid rgba(0,94,184,.15)}
.section-label{font-size:11px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--blue);margin-bottom:20px;display:block}
@media(max-width:960px){.two-col{grid-template-columns:1fr;gap:40px}}
@media(max-width:860px){.feat-grid{grid-template-columns:repeat(2,1fr)}}
@media(max-width:560px){.feat-grid{grid-template-columns:1fr}}
</style>
"@
    } else {
        # standard subpage layout styles
        $styleExtra = @"
<style>
.content-grid{display:grid;grid-template-columns:2fr 1fr;gap:56px;align-items:start}
.content-body h2{font-size:28px;font-weight:800;color:var(--navy);margin-bottom:16px}
.content-body p{font-size:15px;color:var(--muted);line-height:1.85;margin-bottom:20px}
.content-body h3{font-size:18px;font-weight:700;color:var(--navy);margin:32px 0 12px}
.sidebar-card{padding:28px;border-radius:14px;background:var(--soft);border:1.5px solid var(--line)}
.sidebar-card h4{font-size:13px;font-weight:700;color:var(--muted);letter-spacing:.08em;text-transform:uppercase;margin-bottom:16px}
.sidebar-card ul{list-style:none}
.sidebar-card li{padding:8px 0;font-size:14px;color:#2a3550;border-bottom:1px solid var(--line);display:flex;align-items:center;gap:8px}
.sidebar-card li:last-child{border-bottom:none}
.sidebar-card li::before{content:"\\2713";color:var(--blue);font-weight:700;font-size:12px}
.stat-row{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:48px}
.stat-box{text-align:center;padding:28px 20px;background:var(--soft);border-radius:14px;border:1.5px solid var(--line)}
.stat-box .n{font-size:36px;font-weight:800;color:var(--blue);margin-bottom:4px}
.stat-box .l{font-size:12px;color:var(--muted)}
.news-item{padding:28px 0;border-bottom:1px solid var(--line)}
.news-item:last-child{border-bottom:none}
.news-meta{display:flex;gap:12px;align-items:center;margin-bottom:10px}
.news-tag{display:inline-block;padding:3px 10px;border-radius:100px;font-size:11px;font-weight:700;background:rgba(0,94,184,.08);color:var(--blue)}
.news-date{font-size:12px;color:var(--muted)}
.news-item h3{font-size:20px;font-weight:700;color:var(--navy);margin-bottom:8px}
.news-item p{font-size:14px;color:var(--muted);line-height:1.7}
.faq-section{margin-bottom:48px}
.faq-section-title{font-size:14px;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--blue);margin-bottom:20px;padding-bottom:10px;border-bottom:2px solid var(--line)}
.faq-item{border-bottom:1px solid var(--line);padding:24px 0}
.faq-q{font-size:16px;font-weight:700;color:var(--navy);margin-bottom:10px;display:flex;gap:12px;align-items:flex-start}
.faq-q::before{content:"Q";display:inline-block;min-width:24px;height:24px;border-radius:50%;background:var(--blue);color:#fff;font-size:11px;font-weight:800;text-align:center;line-height:24px;flex-shrink:0;margin-top:1px}
.faq-a{font-size:14px;color:var(--muted);line-height:1.8;padding-left:36px}
.dl-table{width:100%;border-collapse:collapse}
.dl-table th{text-align:left;padding:12px 16px;background:var(--soft);font-size:11px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--muted);border-bottom:1px solid var(--line)}
.dl-table td{padding:14px 16px;border-bottom:1px solid var(--line);font-size:14px;color:#2a3550}
.dl-table tr:hover td{background:#f7f9ff}
.dl-btn{display:inline-flex;align-items:center;gap:6px;padding:6px 16px;border-radius:6px;font-size:12px;font-weight:700;background:rgba(0,94,184,.08);color:var(--blue);text-decoration:none}
.dl-btn:hover{background:rgba(0,94,184,.16)}
.dl-cat{display:inline-block;padding:3px 10px;border-radius:100px;font-size:11px;font-weight:700;background:var(--soft);color:var(--muted)}
.filter-bar{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:28px}
.filter-btn{padding:7px 18px;border-radius:100px;font-size:13px;font-weight:700;border:1.5px solid var(--line);background:#fff;color:var(--muted);cursor:pointer;transition:all .2s}
.filter-btn.active,.filter-btn:hover{background:var(--blue);color:#fff;border-color:var(--blue)}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.form-field{display:flex;flex-direction:column;gap:6px}
.form-field.full{grid-column:1/-1}
.form-field label{font-size:12px;font-weight:700;color:var(--muted);letter-spacing:.06em;text-transform:uppercase}
.form-field input,.form-field select,.form-field textarea{padding:11px 14px;border:1.5px solid var(--line);border-radius:8px;font-size:14px;font-family:inherit;background:#fff;transition:border-color .2s}
.form-field input:focus,.form-field select:focus,.form-field textarea:focus{outline:none;border-color:var(--blue)}
.ci-card{padding:28px;border-radius:14px;background:var(--soft);border:1.5px solid var(--line)}
.ci-item{display:flex;gap:16px;align-items:flex-start;padding:16px 0;border-bottom:1px solid var(--line)}
.ci-item:last-child{border-bottom:none}
.ci-icon{width:44px;height:44px;border-radius:10px;background:rgba(0,94,184,.08);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
.ci-item h4{font-size:14px;font-weight:700;color:var(--navy);margin-bottom:4px}
.ci-item p{font-size:13px;color:var(--muted);line-height:1.6}
.contact-grid{display:grid;grid-template-columns:3fr 2fr;gap:56px;align-items:start}
@media(max-width:860px){.content-grid{grid-template-columns:1fr}.stat-row{grid-template-columns:repeat(2,1fr)}.contact-grid{grid-template-columns:1fr}}
</style>
"@
    }

    # Generate standard wrapper
    $html = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${title} | Senao Networks</title>
<meta name="description" content="${desc}">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Noto+Sans+TC:wght@400;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${r}assets/css/styles.css?v=1.1.9">
${styleExtra}
</head>
<body data-root="${r}">
<header id="site-header"></header>
<main>
"@

    # Add page hero (if not index)
    if ($title -ne "index") {
        $html += @"

<section class="page-hero">
  <div class="wrap fu">
    ${bcHTML}
    <h1>${h1}</h1>
    <p class="page-desc">${desc}</p>
  </div>
</section>
"@
    }

    # Append body and footer
    $html += @"

${body}
<section class="cta-band">
  <div class="wrap"><div class="cta-inner fu">
    <div class="cta-text"><h2>Ready to Build Your Infrastructure?</h2><p>Our technical consultants will respond within one business day.</p></div>
    <div class="cta-actions">
      <a href="${r}pages/support/downloads/index.html" class="btn btn-ghost">Downloads</a>
      <a href="${r}pages/support/contact-us/index.html" class="btn btn-primary">Contact Us</a>
    </div>
  </div></div>
</section>
</main>
<footer id="site-footer"></footer>
<script src="${r}assets/js/site.js?v=1.2.3"></script>
</body>
</html>
"@

    # Write file
    $parentDir = Split-Path $file -Parent
    if (!(Test-Path $parentDir)) { New-Item -ItemType Directory -Force -Path $parentDir }
    Set-Content -Path $file -Value $html -Encoding UTF8
    Write-Host "Created: $file"
}






















