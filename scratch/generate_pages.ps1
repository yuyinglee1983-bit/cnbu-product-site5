# Complete pages generator for CNBU-product-site5
# 27 clean files with correct index.html links

# Global functions to generate layout
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
  min-height: 55vh;
  padding: 120px 0 80px;
  display: flex; align-items: center;
  overflow: hidden;
}
.home-hero::before {
  content: '';
  position: absolute; inset: 0;
  background: radial-gradient(ellipse 80% 60% at 70% 40%, rgba(0,152,181,.18) 0%, transparent 70%);
  z-index: 1;
}
.hero-video-bg {
  position: absolute; inset: 0; z-index: 0;
  overflow: hidden;
}
.bg-vid {
  position: absolute; inset: 0;
  width: 100%; height: 100%;
  object-fit: cover;
  opacity: 0;
  transition: opacity 1.5s ease-in-out;
}
.bg-vid.active {
  opacity: 1;
}
.video-overlay {
  position: absolute; inset: 0;
  background: linear-gradient(to right, #060e1e 0%, #060e1e 20%, rgba(6,14,30,0.85) 35%, transparent 50%);
  z-index: 1;
}
.home-hero .wrap, .home-solutions .wrap { max-width: 1380px; }
.hero-content { position: relative; z-index: 2; max-width: 1100px; }
.hero-badge { display:inline-block; font-size: 14px; font-weight: 700; letter-spacing: .08em; color: var(--cyan); margin-bottom: 28px; }
.hero-badge::before { display:none; }
@keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.7)} }
.home-hero h1 {
  font-size: clamp(38px, 5.5vw, 76px);
  font-weight: 800; line-height: 1.08;
  letter-spacing: -.03em; color: #fff;
  margin-bottom: 20px;
}
.home-hero h1 em {
  font-style: normal;
  white-space: nowrap;
  background: linear-gradient(110deg, #00c2e0 0%, #7fe0ff 45%, #fff 50%, #7fe0ff 55%, #00c2e0 100%);
  background-size: 400% auto;
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: shimmer 3.5s ease infinite;
}
@keyframes shimmer { 0%{background-position:200% center} 100%{background-position:-200% center} }
.home-hero .sub { font-size: 22px; color: rgba(255,255,255,.65); line-height: 1.75; margin-bottom: 36px; }
.hero-actions { display: flex; gap: 14px; flex-wrap: wrap; }

/* ════ SOLUTIONS CAROUSEL CSS ════ */
.home-solutions { padding: 80px 0; overflow: hidden; background: #fff; }
.home-solutions .section-title { font-size: 44px; font-weight: 800; color: var(--navy); margin-bottom: 40px; }
.carousel-container { position: relative; max-width: 100%; margin: 0 auto; display: flex; align-items: center; }
.carousel-track {
  display: flex; gap: 24px; overflow-x: auto; scroll-snap-type: x mandatory;
  scroll-behavior: smooth; padding-bottom: 20px;
  -ms-overflow-style: none; scrollbar-width: none;
}
.carousel-track::-webkit-scrollbar { display: none; }
.sol-card {
  position: relative;
  flex: 0 0 calc(33.333% - 16px);
  min-width: 280px;
  background: #060e1e;
  border-radius: 8px;
  overflow: hidden;
  text-decoration: none;
  scroll-snap-align: start;
  display: block;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  padding-bottom: 106px;
}
.sol-card .img-wrap { width: 100%; aspect-ratio: 16/9; overflow: hidden; display: block; }
.sol-card .img-wrap img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
.sol-card:hover .img-wrap img { transform: scale(1.05); }
.sol-card .info-wrap {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  height: 50%;
  background: #060e1e;
  padding: 24px;
  display: flex;
  flex-direction: column;
  transform: translateY(calc(100% - 106px));
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  z-index: 2;
}
.sol-card:hover .info-wrap { transform: translateY(0); }
.sol-card h3 { font-size: 26px; font-weight: 700; color: #fff; margin-bottom: 12px; }
.sol-card .learn-more { font-size: 15px; font-weight: 600; color: var(--cyan); margin-top: 0; }
.carousel-btn {
  position: absolute; top: 40%; transform: translateY(-50%);
  width: 44px; height: 44px; border-radius: 12px;
  background: #cbd0d6; border: none;
  cursor: pointer; z-index: 10; display: flex; align-items: center; justify-content: center;
  transition: background 0.2s, transform 0.2s;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}
.carousel-btn:hover { background: #aab0b8; transform: translateY(-50%) scale(1.05); }
.carousel-btn svg { width: 22px; height: 22px; fill: none; stroke: #fff; stroke-width: 3.5; stroke-linecap: round; stroke-linejoin: round; }
.prev-btn { left: -60px; }
.next-btn { right: -60px; }
@media (max-width: 1360px) {
  .prev-btn { left: 10px; } .next-btn { right: 10px; }
}
@media (max-width: 900px) { .sol-card { flex: 0 0 calc(50% - 12px); } }
@media (max-width: 600px) { .sol-card { flex: 0 0 100%; } }
/* ════ SERVICES SECTION CSS ════ */
.home-services { padding: 80px 0; background: #1e2024; }
.home-services .wrap { max-width: 1380px; }
.home-services .section-title { font-size: 44px; font-weight: 800; color: #fff; margin-bottom: 40px; }
.services-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
.srv-card {
  position: relative; aspect-ratio: 16/10; border-radius: 12px; overflow: hidden; text-decoration: none; display: block;
}
.srv-card .img-wrap { position: absolute; inset: 0; }
.srv-card .img-wrap img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
.srv-card:hover .img-wrap img { transform: scale(1.05); }
.srv-card .overlay-base {
  position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.85) 0%, transparent 50%);
  display: flex; align-items: flex-end; padding: 28px; transition: opacity 0.3s;
}
.srv-card .overlay-base h3 { font-size: 26px; font-weight: 800; color: #fff; margin: 0; }
.srv-card .overlay-hover {
  position: absolute; bottom: 0; left: 0; right: 0; height: 50%;
  background: rgba(10, 15, 25, 0.95); padding: 28px;
  display: flex; flex-direction: column; transform: translateY(100%);
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.srv-card:hover .overlay-hover { transform: translateY(0); }
.srv-card:hover .overlay-base { opacity: 0; }
.srv-card .overlay-hover h3 { font-size: 26px; font-weight: 800; color: #fff; margin-bottom: 12px; }
.srv-card .overlay-hover p { font-size: 16px; color: #b3b8c2; line-height: 1.6; margin-bottom: 16px; }
.srv-card .overlay-hover .explore { font-size: 15px; font-weight: 600; color: var(--cyan); margin-top: auto; }

.stats-bar {
  background: var(--navy);
  display: grid; grid-template-columns: repeat(4,1fr);
}
.stat { padding: 48px 24px; border-right: 1px solid rgba(255,255,255,.08); text-align: center; }
.stat:last-child { border-right: none; }
.stat-n { font-size: 52px; font-weight: 800; color: #fff; line-height: 1; margin-bottom: 8px; }
.stat-n span { color: var(--cyan); }
.stat-l { font-size: 12px; color: rgba(255,255,255,.5); letter-spacing: .06em; text-transform: uppercase; }

@media(max-width:960px) {
  .services-grid { grid-template-columns: repeat(2,1fr); }
}
@media(max-width:640px) {
  .services-grid { grid-template-columns: 1fr; }
  .stats-bar { grid-template-columns: repeat(2,1fr); }
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
.feat-box .fi{display:none}
.feat-box h3{font-size: 22px;font-weight:800;color:var(--navy);margin-bottom:10px}
.feat-box p{font-size: 16px;color:var(--muted);line-height:1.7}
.spec-table{width:100%;border-collapse:collapse;font-size: 16px}
.spec-table th{text-align:left;padding:12px 18px;background:var(--soft);font-size: 12px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--muted);border-bottom:1px solid var(--line)}
.spec-table td{padding:14px 18px;border-bottom:1px solid var(--line);color:#2a3550}
.spec-table tr:last-child td{border-bottom:none}
.spec-table tr:hover td{background:#f7f9ff}
.two-col{display:grid;grid-template-columns:1.2fr 1fr;gap:56px;align-items:start;margin-top:48px}
.info-block h2{font-size: 38px;font-weight:800;color:var(--navy);margin-bottom:16px;letter-spacing:-.02em}
.info-block p{font-size: 18px;color:var(--muted);line-height:1.85;margin-bottom:24px}
.tag-list{display:flex;flex-wrap:wrap;gap:8px;margin-top:20px}
.tag{display:inline-block;padding:6px 14px;font-size: 15px; font-weight: 700; color: var(--blue); background: transparent}
.section-label{font-size: 13px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--blue);margin-bottom:20px;display:block}
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
.content-body h2{font-size: 32px;font-weight:800;color:var(--navy);margin-bottom:16px}
.content-body p{font-size: 18px;color:var(--muted);line-height:1.85;margin-bottom:20px}
.content-body h3{font-size: 22px;font-weight:700;color:var(--navy);margin:32px 0 12px}
.sidebar-card{padding:28px;border-radius:14px;background:var(--soft);border:1.5px solid var(--line)}
.sidebar-card h4{font-size: 13px;font-weight:700;color:var(--muted);letter-spacing:.08em;text-transform:uppercase;margin-bottom:16px}
.sidebar-card ul{list-style:none}
.sidebar-card li{padding:8px 0;font-size: 16px;color:#2a3550;border-bottom:1px solid var(--line);display:flex;align-items:center;gap:8px}
.sidebar-card li:last-child{border-bottom:none}
.sidebar-card li::before{display:none}
.stat-row{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:48px}
.stat-box{text-align:center;padding:28px 20px;background:var(--soft);border-radius:14px;border:1.5px solid var(--line)}
.stat-box .n{font-size: 42px;font-weight:800;color:var(--blue);margin-bottom:4px}
.stat-box .l{font-size: 14px;color:var(--muted)}
.news-item{padding:28px 0;border-bottom:1px solid var(--line)}
.news-item:last-child{border-bottom:none}
.news-meta{display:flex;gap:12px;align-items:center;margin-bottom:10px}
.news-tag{display:inline;font-size: 13px;font-weight:700;color:var(--blue)}
.news-date{font-size: 14px;color:var(--muted)}
.news-item h3{font-size: 24px;font-weight:700;color:var(--navy);margin-bottom:8px}
.news-item p{font-size: 16px;color:var(--muted);line-height:1.7}
.faq-section{margin-bottom:48px}
.faq-section-title{font-size: 14px;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--blue);margin-bottom:20px;padding-bottom:10px;border-bottom:2px solid var(--line)}
.faq-item{border-bottom:1px solid var(--line);padding:24px 0}
.faq-q{font-size: 18px;font-weight:700;color:var(--navy);margin-bottom:10px;display:flex;gap:12px;align-items:flex-start}
.faq-q::before{display:none}
.faq-a{font-size: 16px;color:var(--muted);line-height:1.8;padding-left:36px}
.dl-table{width:100%;border-collapse:collapse}
.dl-table th{text-align:left;padding:12px 16px;background:var(--soft);font-size: 12px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--muted);border-bottom:1px solid var(--line)}
.dl-table td{padding:14px 16px;border-bottom:1px solid var(--line);font-size: 16px;color:#2a3550}
.dl-table tr:hover td{background:#f7f9ff}
.dl-btn{display:inline-flex;align-items:center;gap:6px;padding:6px 16px;border-radius:6px;font-size: 15px;font-weight:700;background:rgba(0,94,184,.08);color:var(--blue);text-decoration:none}
.dl-btn:hover{background:rgba(0,94,184,.16)}
.dl-cat{display:inline;font-size: 13px;font-weight:700;color:var(--muted)}
.filter-bar{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:28px}
.filter-btn{padding:7px 18px;font-size: 15px;font-weight:700;border:none;background:#fff;color:var(--muted);cursor:pointer;transition:all .2s}
.filter-btn.active,.filter-btn:hover{background:var(--blue);color:#fff;}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.form-field{display:flex;flex-direction:column;gap:6px}
.form-field.full{grid-column:1/-1}
.form-field label{font-size: 14px;font-weight:700;color:var(--muted);letter-spacing:.06em;text-transform:uppercase}
.form-field input,.form-field select,.form-field textarea{padding:11px 14px;border:1.5px solid var(--line);border-radius:8px;font-size: 16px;font-family:inherit;background:#fff;transition:border-color .2s}
.form-field input:focus,.form-field select:focus,.form-field textarea:focus{outline:none;border-color:var(--blue)}
.ci-card{padding:28px;border-radius:14px;background:var(--soft);border:1.5px solid var(--line)}
.ci-item{display:flex;gap:16px;align-items:flex-start;padding:16px 0;border-bottom:1px solid var(--line)}
.ci-item:last-child{border-bottom:none}
.ci-icon{display:none}
.ci-item h4{font-size: 16px;font-weight:700;color:var(--navy);margin-bottom:4px}
.ci-item p{font-size: 16px;color:var(--muted);line-height:1.6}
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
<script src="${r}assets/js/site.js?v=1.2.7"></script>
</body>
</html>
"@

    # Write file
    $parentDir = Split-Path $file -Parent
    if (!(Test-Path $parentDir)) { New-Item -ItemType Directory -Force -Path $parentDir }
    Set-Content -Path $file -Value $html -Encoding UTF8
    Write-Host "Created: $file"
}

# ── 1. HOME ────────────────────────────────────────────────────────
$homeBody = @"
<!-- ════ HERO ════ -->
<section class="home-hero">
  <div class="hero-video-bg">
    <video class="bg-vid active" src="./assets/video/bg-hero-1.mp4" style="transform: scaleX(-1);" muted loop playsinline autoplay></video>
    <video class="bg-vid" src="./assets/video/bg-hero-2.mp4" muted loop playsinline></video>
    <video class="bg-vid" src="./assets/video/bg-hero-3.mp4" style="object-position: center top;" muted loop playsinline></video>
    <video class="bg-vid" src="./assets/video/bg-hero-4.mp4" muted loop playsinline></video>
    <div class="video-overlay"></div>
  </div>
  <div class="wrap">
    <div class="hero-content fu">
      <h1>SENAO COMPUTING<br><em>your reliable edge AI partner</em></h1>
      <p class="sub">Senao Networks delivers purpose-built servers, SmartNIC accelerators, and AI platforms<br>engineered for data centers and edge deployments worldwide.</p>
    </div>
  </div>
</section>

<!-- ════ SOLUTIONS CAROUSEL ════ -->
<section class="home-solutions">
  <div class="wrap">
    <h2 class="section-title fu">Senao Computing Solution</h2>
    <div class="carousel-container fu">
      <button class="carousel-btn prev-btn" id="sol-prev" aria-label="Previous">
        <svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>
      </button>
      <div class="carousel-track" id="solution-track">
        <a href="./pages/solution/server/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-6.jpg" alt="Server" loading="lazy"></div>
          <div class="info-wrap">
            <h3>Server</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
        <a href="./pages/solution/edge-server/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-2.jpg" alt="Edge Server" loading="lazy"></div>
          <div class="info-wrap">
            <h3>Edge Server</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
        <a href="./pages/solution/smartnic/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-3.jpg" alt="SmartNIC" loading="lazy"></div>
          <div class="info-wrap">
            <h3>SmartNIC</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
        <a href="./pages/solution/network-appliance/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-4.jpg" alt="Network Appliance" loading="lazy"></div>
          <div class="info-wrap">
            <h3>Network Appliance</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
        <a href="./pages/solution/data-center-switch/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-5.jpg" alt="Data Center Switch" loading="lazy"></div>
          <div class="info-wrap">
            <h3>Data Center Switch</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
        <a href="./pages/solution/com-express-module/index.html" class="sol-card">
          <div class="img-wrap"><img src="./assets/img/home/solution-1.jpg" alt="COM Express Module" loading="lazy"></div>
          <div class="info-wrap">
            <h3>COM Express Module</h3>
            <span class="learn-more">Learn More &rarr;</span>
          </div>
        </a>
      </div>
      <button class="carousel-btn next-btn" id="sol-next" aria-label="Next">
        <svg viewBox="0 0 24 24"><path d="M9 18l6-6-6-6"/></svg>
      </button>
    </div>
  </div>
</section>

<!-- ════ SERVICES OVERVIEW ════ -->
<section class="home-services">
  <div class="wrap fu">
    <h2 class="section-title">Services</h2>
    <div class="services-grid">
      
      <a href="./pages/services/laboratory/index.html" class="srv-card">
        <div class="img-wrap"><img src="./assets/img/home/services-1.jpg" alt="Laboratory" loading="lazy"></div>
        <div class="overlay-base">
          <h3>Laboratory</h3>
        </div>
        <div class="overlay-hover">
          <h3>Laboratory</h3>
          <p>Comprehensive testing and compliance certification facilities.</p>
          <span class="explore">Explore &rarr;</span>
        </div>
      </a>

      <a href="./pages/services/technology/index.html" class="srv-card">
        <div class="img-wrap"><img src="./assets/img/home/services-2.jpg" alt="Technology" loading="lazy"></div>
        <div class="overlay-base">
          <h3>Technology</h3>
        </div>
        <div class="overlay-hover">
          <h3>Technology</h3>
          <p>Advanced engineering and hardware design capabilities.</p>
          <span class="explore">Explore &rarr;</span>
        </div>
      </a>

      <a href="./pages/services/manufacturing/index.html" class="srv-card">
        <div class="img-wrap"><img src="./assets/img/home/services-3.jpg" alt="Manufacturing" loading="lazy"></div>
        <div class="overlay-base">
          <h3>Manufacturing</h3>
        </div>
        <div class="overlay-hover">
          <h3>Manufacturing</h3>
          <p>Global manufacturing operations with stringent quality control.</p>
          <span class="explore">Explore &rarr;</span>
        </div>
      </a>

    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\index.html" "index" 0 @() "" "" "" $homeBody

# ── 2. L1 LANDING PAGES ───────────────────────────────────────────

# About Landing
$aboutBody = @"
<section class="section">
  <div class="wrap">
    <div style="display:grid; grid-template-columns:repeat(2,1fr); gap:32px; margin-top:16px;">
      <a class="feat-box fu" href="./about-senao-computing/index.html">
        <span class="eyebrow">Company</span>
        <h3>About Senao Computing</h3>
        <p>Our story, mission, vision and technology leadership in networking and computing.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
      <a class="feat-box fu" href="./global-presence/index.html">
        <span class="eyebrow">Worldwide</span>
        <h3>Global Presence</h3>
        <p>Headquarters in Taiwan with offices in USA, Japan, and India serving global customers.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
      <a class="feat-box fu" href="./certification/index.html">
        <span class="eyebrow">Standards</span>
        <h3>Certification</h3>
        <p>Industry certifications, compliance standards, and quality management systems.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
      <a class="feat-box fu" href="./esg/index.html">
        <span class="eyebrow">Sustainability</span>
        <h3>ESG</h3>
        <p>Environmental, Social, and Governance commitments for a sustainable future.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\about\index.html" "About" 2 @("About", "") "About" "About Senao Networks" "Innovative networking and computing solutions for enterprise and edge environments worldwide." $aboutBody

# Solution Landing
$solBody = @"
<section class="section">
  <div class="wrap">
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:28px; margin-top:16px;">
      <a class="feat-box fu" href="./server/index.html">
        <div class="fi">🖥️</div>
        <h3>Server</h3>
        <p>High-density OCP DC-MHS rack servers. Dual-socket platforms for data center compute and GPU workloads.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
      <a class="feat-box fu" href="./edge-server/index.html">
        <div class="fi">📦</div>
        <h3>Edge Server</h3>
        <p>Compact, ruggedized servers for edge deployments requiring low-latency local compute.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
      <a class="feat-box fu" href="./smartnic/index.html">
        <div class="fi">⚡</div>
        <h3>SmartNIC</h3>
        <p>Offload networking, security, and storage tasks from CPU to intelligent DPU hardware.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
      <a class="feat-box fu" href="./network-appliance/index.html">
        <div class="fi">🔒</div>
        <h3>Network Appliance</h3>
        <p>Purpose-built appliances for firewall, SD-WAN, UTM, and security gateway deployments.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
      <a class="feat-box fu" href="./data-center-switch/index.html">
        <div class="fi">🔀</div>
        <h3>Data Center Switch</h3>
        <p>High-speed ToR and spine switches with ONIE support for modern data center fabrics.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
      <a class="feat-box fu" href="./com-express-module/index.html">
        <div class="fi">🔌</div>
        <h3>COM Express Module</h3>
        <p>Compact embedded computing modules for industrial, medical, and transportation applications.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Explore &rarr;</span>
      </a>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\solution\index.html" "Solution" 2 @("Solution", "") "Solution" "Hardware Solutions" "Purpose-built platforms engineered for performance, reliability, and security at every scale." $solBody

# AI Hub Landing
$aiBody = @"
<section class="section">
  <div class="wrap" style="max-width:800px;">
    <a class="feat-box fu" href="./raxel-ai/index.html" style="display:block; padding:48px; background:linear-gradient(135deg,#0b1e38,#0d3060); color:#fff; border:none; text-align:center;">
      <span class="eyebrow" style="color:var(--cyan);">Edge AI Platform</span>
      <h3 style="color:#fff; font-size: 42px; margin-top:8px; margin-bottom:12px;">RAXEL AI</h3>
      <p style="color:rgba(255,255,255,.75); font-size: 20px; max-width:560px; margin:0 auto 24px;">Query your enterprise knowledge base without sending data to the cloud. Secure, cited answers powered by on-premises AI inference &mdash; instantly deployable on Senao edge hardware.</p>
      <span class="btn btn-primary">Explore RAXEL AI</span>
    </a>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\ai-hub\index.html" "AI Hub" 2 @("AI Hub", "") "AI Hub" "Enterprise AI Platform" "On-premises AI solutions that keep your data secure &mdash; no cloud dependency required." $aiBody

# Services Landing
$svcBody = @"
<section class="section">
  <div class="wrap">
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:28px; margin-top:16px;">
      <a class="feat-box fu" href="./laboratory/index.html">
        <div class="fi">🔬</div>
        <h3>Laboratory</h3>
        <p>Testing and validation labs for product certification, compliance, and performance benchmarking.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
      <a class="feat-box fu" href="./technology/index.html">
        <div class="fi">💡</div>
        <h3>Technology</h3>
        <p>R&D and technology development services including firmware, BIOS, and system-level integration.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
      <a class="feat-box fu" href="./manufacturing/index.html">
        <div class="fi">🏭</div>
        <h3>Manufacturing</h3>
        <p>SMT automated production lines with 6-Sigma quality standards and 72-hour burn-in testing.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Learn More &rarr;</span>
      </a>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\services\index.html" "Services" 2 @("Services", "") "Services" "Engineering Services" "End-to-end design, testing, and manufacturing services to bring your product to market faster." $svcBody

# News Landing
$newsBody = @"
<section class="section">
  <div class="wrap">
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:28px; margin-top:16px;">
      <a class="feat-box fu" href="./news/index.html">
        <div class="fi">📢</div>
        <h3>News</h3>
        <p>Press releases, product launches, and company announcements.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">View News &rarr;</span>
      </a>
      <a class="feat-box fu" href="./events/index.html">
        <div class="fi">📅</div>
        <h3>Events</h3>
        <p>Trade shows, webinars, partner events, and speaking engagements.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">View Events &rarr;</span>
      </a>
      <a class="feat-box fu" href="./blog/index.html">
        <div class="fi">✍️</div>
        <h3>Blog</h3>
        <p>Technical insights, engineering perspectives, and industry analysis.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Read Blog &rarr;</span>
      </a>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\news\index.html" "News" 2 @("News", "") "Media Center" "News &amp; Media" "Latest announcements, industry events, and technical insights from Senao Networks." $newsBody

# Support Landing
$supBody = @"
<section class="section">
  <div class="wrap">
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:28px; margin-top:16px;">
      <a class="feat-box fu" href="./contact-us/index.html">
        <div class="fi">✉️</div>
        <h3>Contact Us</h3>
        <p>Technical inquiries, quotation requests, and partnership proposals. Response within one business day.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Get in Touch &rarr;</span>
      </a>
      <a class="feat-box fu" href="./downloads/index.html">
        <div class="fi">📥</div>
        <h3>Downloads</h3>
        <p>Product datasheets, firmware updates, technical specifications, and installation guides.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">Go to Downloads &rarr;</span>
      </a>
      <a class="feat-box fu" href="./faq/index.html">
        <div class="fi">❓</div>
        <h3>FAQ</h3>
        <p>Frequently asked questions about products, ordering, warranty, and technical support.</p>
        <span style="color:var(--blue); font-size: 17px; font-weight:700; margin-top:14px; display:inline-block;">View FAQ &rarr;</span>
      </a>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\support\index.html" "Support" 2 @("Support", "") "Support" "Customer Support" "Technical resources, documentation, and direct assistance from our engineering team." $supBody


# ── 3. L2 SUBPAGES ──────────────────────────────────────────────

# ─ ABOUT SUBPAGES ──────────────────────────────
$aboutCorpBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Pioneering Compute &amp; Network Technology</h2>
    <p>Established with a mission to deliver top-tier network and computing infrastructure, Senao Networks has evolved into a global leader in high-performance hardware design, validation, and manufacturing.</p>
    <p>We work closely with cloud service providers (CSPs), telecom operators, and enterprises to develop platforms optimized for virtualization, AI inference, software-defined networking (SDN), and next-generation security gateways.</p>
    <h3>Our Mission</h3>
    <p>To empower the global transition to the AI &amp; Edge era through reliable, open, and high-performance server, networking, and acceleration technology.</p>
    <h3>Our Core Strengths</h3>
    <p>We pride ourselves on our deep technical expertise across multiple engineering disciplines, including high-speed hardware board design, BIOS/BMC firmware customization, thermal simulation and testing, and advanced SMT production systems.</p>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>Company Info</h4>
      <ul>
        <li>Founded: 1999</li>
        <li>Headquarters: Taoyuan, Taiwan</li>
        <li>R&amp;D Centers: Taiwan &amp; USA</li>
        <li>Employees: 1,200+ Globally</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\about\about-senao-computing\index.html" "About Senao Computing" 3 @("About", "pages/about/index.html", "About Senao Computing", "") "About &middot; Company" "About Senao Computing" "A global leader in high-performance network security appliances, OCP-compliant servers, and custom firmware design." $aboutCorpBody

$aboutPresenceBody = @"
<section style="background:#f8fafc; padding:64px 0 48px; border-bottom:1px solid #e8edf4;">
  <div class="wrap fu">
    <h2 style="font-size: 31px; font-weight:800; color:var(--navy); margin-bottom:32px;">Global Coverage Map</h2>
    <div style="text-align:center;">
      <img src="https://statics.senaonetworks.com/wp-content/uploads/2025/08/29152816/senao-map-2025_en-1.png" alt="Senao Networks Global Presence Map" style="max-width:100%; margin:0 auto; display:block; border-radius:12px; box-shadow:0 4px 24px rgba(0,0,0,.08);">
    </div>
  </div>
</section>
<section style="background:#fff; padding:60px 0;">
  <div class="wrap fu">
    <div>
      <style>
      .loc-card { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; align-items: center; margin-bottom: 32px; padding: 28px 32px; border-radius: 14px; background: #fff; border: 1.5px solid #edf0f5; transition: transform .32s cubic-bezier(.4,0,.2,1), box-shadow .32s cubic-bezier(.4,0,.2,1), border-color .32s ease; }
      .loc-card:hover { transform: translateY(-8px); box-shadow: 0 16px 48px rgba(0,50,120,.12), 0 4px 12px rgba(0,50,120,.07); border-color: rgba(0,94,184,.25); }
      @media(max-width:860px){ .loc-card { grid-template-columns: 1fr; } }
      .loc-info { list-style:none; padding:0; margin:0; }
      .loc-info li { display: flex; gap: 14px; align-items: flex-start; padding: 6px 0; font-size: 14px; color: #444; border-bottom: 1px solid #f0f2f5; }
      .loc-info li:last-child { border-bottom: none; }
      .loc-info .lbl { font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #999; min-width: 34px; padding-top: 2px; flex-shrink: 0; }
      </style>

      <h2 style="font-size:26px; font-weight:700; color:#1a1a1a; text-align:left; display:table; border-bottom:3px solid #f5a623; padding-bottom:10px; margin-bottom:48px;">
        Senao Networks Global Presence &amp; Subsidiaries
      </h2>

      <!-- Taiwan Headquarters -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">Taiwan (Headquarters)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Senao Networks Inc.</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>No. 500, Fuxing 3rd Rd., Guishan Dist.,<br>Taoyuan City 333001, Taiwan</span></li>
            <li><span class="lbl">Phone</span><span>+886-3-3289289</span></li>
            <li><span class="lbl">Fax</span><span>+886-3-396-2222</span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3614.8!2d121.3!3d25.06!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2z6b6N5bGx5Y2A5b6M5YWo5LiJ6Lev500!5e0!3m2!1szh-TW!2stw!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>

      <!-- Taiwan Nangang R&D -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">Taiwan (Nangang R&amp;D Center)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Senao Networks Inc.</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>10F, Building B, No. 209, Sec. 1, Nangang Rd.,<br>Taipei City 115018, Taiwan</span></li>
            <li><span class="lbl">Phone</span><span>+886-2-2786-2986</span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3615.5!2d121.6!3d25.05!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zQua5kiwgTm8uIDIwOSDljZfmuqbot69kuIHmqZ8!5e0!3m2!1szh-TW!2stw!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>

      <!-- USA -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">USA (Sales &amp; Technical Support)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Senao Networks USA Inc.</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>860 N McCarthy Blvd Ste 200,<br>Milpitas, CA 95035, USA</span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3172.0!2d-121.9!3d37.43!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2s860+N+McCarthy+Blvd+%23200!5e0!3m2!1sen!2sus!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>

      <!-- Japan -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">Japan (Sales &amp; Technical Support)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Senao Networks Japan Inc.</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>10F, EXPERT TAMACHI,<br>3-6-14 Shibaura, Minato-ku,<br>Tokyo 108-0023, Japan</span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.8!2d139.74!3d35.64!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2s10F%2C+EXPERT+TAMACHI!5e0!3m2!1sen!2sjp!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>

      <!-- India -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">India (Sales, R&amp;D &amp; Operations Center)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Senao Networks Private Limited</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>Unit #901, 9th Floor, Gowra Palladium, Hi-Tech City,<br>Hyderabad, Telangana 500081, India</span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3806.3!2d78.37!3d17.44!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2s%23901+Gowra+Palladium!5e0!3m2!1sen!2sin!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>

      <!-- Emplus (Taiwan, Senao Group) -->
      <div class="loc-card">
        <div>
          <p style="color:#005bac; font-weight:700; font-size:15px; margin-bottom:6px;">Taiwan (Senao Group)</p>
          <h3 style="font-size:22px; font-weight:800; color:#1a1a1a; margin-bottom:20px;">Emplus Technologies Inc.</h3>
          <ul class="loc-info">
            <li><span class="lbl">Address</span><span>10F, Building B, No. 209, Sec. 1, Nangang Rd.,<br>Taipei City 115018, Taiwan</span></li>
            <li><span class="lbl">Website</span><span><a href="https://www.emplustech.com/" style="color:#005bac;">www.emplustech.com</a></span></li>
          </ul>
        </div>
        <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3615.5!2d121.6!3d25.05!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2z115!5e0!3m2!1szh-TW!2stw!4v1"
            width="100%" height="320" style="border:0; border-radius:4px; display:block;"
            allowfullscreen loading="lazy">
          </iframe>
        </div>
      </div>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\about\global-presence\index.html" "Global Presence" 3 @("About", "pages/about/index.html", "Global Presence", "") "About &middot; Locations" "Global Presence" "Global R&amp;D hubs, business offices, and advanced manufacturing sites serving customers worldwide." $aboutPresenceBody

$aboutCertBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Certified Quality Management Systems</h2>
    <p>Quality and reliability are built into every product we design and build. Senao Networks adheres to strict international engineering, manufacturing, and environmental standards.</p>
    <p>Our facilities are fully certified and undergo regular independent audits to guarantee consistent output quality and regulatory compliance.</p>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-top:24px;">
      <div style="padding:16px; border:1px solid var(--line); border-radius:8px;">
        <h4 style="font-weight:700; color:var(--navy);">ISO 9001:2015</h4>
        <p style="font-size: 17px; color:var(--muted); margin-top:4px;">Quality Management Systems</p>
      </div>
      <div style="padding:16px; border:1px solid var(--line); border-radius:8px;">
        <h4 style="font-weight:700; color:var(--navy);">ISO 14001:2015</h4>
        <p style="font-size: 17px; color:var(--muted); margin-top:4px;">Environmental Management Systems</p>
      </div>
      <div style="padding:16px; border:1px solid var(--line); border-radius:8px;">
        <h4 style="font-weight:700; color:var(--navy);">ISO 27001:2022</h4>
        <p style="font-size: 17px; color:var(--muted); margin-top:4px;">Information Security Management</p>
      </div>
      <div style="padding:16px; border:1px solid var(--line); border-radius:8px;">
        <h4 style="font-weight:700; color:var(--navy);">TL 9000</h4>
        <p style="font-size: 17px; color:var(--muted); margin-top:4px;">Telecom Quality Standards</p>
      </div>
    </div>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>Compliance</h4>
      <ul>
        <li>CE Compliance</li>
        <li>FCC Certification</li>
        <li>UL Safety Standards</li>
        <li>RoHS/REACH Compliant</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\about\certification\index.html" "Certification" 3 @("About", "pages/about/index.html", "Certification", "") "About &middot; Quality" "Certification" "Quality standards, environmental certifications, and security compliance certificates." $aboutCertBody

$aboutEsgBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Environmental, Social, &amp; Governance</h2>
    <p>Sustainability is core to our corporate development. We work diligently to minimize our environmental footprint, support our global workforce, and adhere to strict ethics standards.</p>
    <div class="stat-row" style="margin-top:24px;">
      <div class="stat-box"><div class="n">30%</div><div class="l">Carbon Reduction by 2028</div></div>
      <div class="stat-box"><div class="n">100%</div><div class="l">RoHS Compliant Materials</div></div>
      <div class="stat-box"><div class="n">98%</div><div class="l">Waste Recycling Rate</div></div>
      <div class="stat-box"><div class="n">A+</div><div class="l">ESG Audit Score</div></div>
    </div>
    <h3>Green Manufacturing</h3>
    <p>Our production facilities utilize high-efficiency HVAC networks, automated solar energy offsets, and comprehensive recycling systems for packaging and electronic components.</p>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>ESG Milestones</h4>
      <ul>
        <li>Renewable Energy Target</li>
        <li>Supply Chain Audits</li>
        <li>Diverse Workplace Policy</li>
        <li>CSR Volunteer Programs</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\about\esg\index.html" "ESG" 3 @("About", "pages/about/index.html", "ESG", "") "About &middot; ESG" "ESG" "Environmental, social responsibility, and corporate governance initiatives at Senao Networks." $aboutEsgBody


# ─ SOLUTION SUBPAGES ───────────────────────────
function BuildSolutionPage($file, $pname, $desc, $bodyExtra = "") {
    $breadcrumbs = @("Solution", "pages/solution/index.html", $pname, "")
    $solBody = @"
<section class="section">
  <div class="wrap fu">
    <div class="feat-grid">
      <div class="feat-box">
        <div class="fi">⚡</div>
        <h3>High Performance</h3>
        <p>Optimized at the hardware and board level for maximum computing efficiency and throughput.</p>
      </div>
      <div class="feat-box">
        <div class="fi">🛡️</div>
        <h3>Secure &amp; Reliable</h3>
        <p>Features hardware Root-of-Trust (RoT), secure boot, and dual-redundant BMC firmware.</p>
      </div>
      <div class="feat-box">
        <div class="fi">🌱</div>
        <h3>Energy Efficient</h3>
        <p>Engineered with efficient PSU configurations and automated power-saving states.</p>
      </div>
    </div>

    <div class="two-col">
      <div class="info-block">
        <span class="section-label">Product Overview</span>
        <h2>${pname} Platform</h2>
        <p>${desc}</p>
        <p>Our platforms are designed to address the challenging cooling and computing requirements of enterprise edge, high-throughput telecom gateway nodes, and multi-tenant cloud facilities.</p>
        <div class="tag-list">
          <span class="tag">OCP Compliant</span>
          <span class="tag">Redundant PSU</span>
          <span class="tag">BIOS Tweaking</span>
          <span class="tag">PCIe Gen 5</span>
        </div>
      </div>
      <div>
        <span class="section-label">Technical Specifications</span>
        <table class="spec-table">
          <thead><tr><th>Feature</th><th>Specification</th></tr></thead>
          <tbody>
            <tr><td>Architecture</td><td>x86-64 / ARM Neoverse</td></tr>
            <tr><td>Memory Slots</td><td>Up to 32x DDR5 DIMM</td></tr>
            <tr><td>Storage Options</td><td>NVMe / SATA3 Hot-swap</td></tr>
            <tr><td>Management</td><td>IPMI 2.0 / Redfish BMC</td></tr>
            <tr><td>Form Factor</td><td>1U/2U Rackmount or Modular</td></tr>
          </tbody>
        </table>
      </div>
    </div>
    ${bodyExtra}
  </div>
</section>
"@
    BuildPage $file $pname 3 $breadcrumbs "Solution &middot; Platform" $pname $desc $solBody
}

BuildSolutionPage "D:\CNBU-product-site5\pages\solution\server\index.html" "Server" "High-density OCP DC-MHS rack servers engineered for data center compute and GPU workloads."
BuildSolutionPage "D:\CNBU-product-site5\pages\solution\edge-server\index.html" "Edge Server" "Compact, ruggedized servers built for edge environments requiring low-latency local compute."
BuildSolutionPage "D:\CNBU-product-site5\pages\solution\smartnic\index.html" "SmartNIC" "Offload networking, security, and storage tasks from the CPU to purpose-built DPU hardware."
BuildSolutionPage "D:\CNBU-product-site5\pages\solution\network-appliance\index.html" "Network Appliance" "Purpose-built platforms for enterprise firewall, SD-WAN nodes, UTM gateways, and secure branch connectivity."
BuildSolutionPage "D:\CNBU-product-site5\pages\solution\data-center-switch\index.html" "Data Center Switch" "High-speed 100GbE/400GbE ToR and spine switches supporting Open Network Install Environment (ONIE)."
BuildSolutionPage "D:\CNBU-product-site5\pages\solution\com-express-module\index.html" "COM Express Module" "Embedded Computer-on-Module solutions for industrial automation, smart medical devices, and transit control."


# ─ AI HUB SUBPAGE ──────────────────────────────
$raxBody = @"
<style>
.page-hero { display: none !important; }

/* ── Split Section ────────────────────────── */
.split-section {
  padding: 0;
  background: #fff;
  border-bottom: 1px solid var(--line);
  overflow: hidden;
}
.split-inner {
  display: grid;
  grid-template-columns: 2fr 5fr;
  min-height: 420px;
  max-width: 100%;
}
.split-left {
  padding: 56px 48px 56px 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background: #fff;
}
.split-eyebrow {display:none}
.split-left h2 {
  font-size: clamp(22px, 2.5vw, 34px);
  font-weight: 800;
  line-height: 1.2;
  letter-spacing: -.025em;
  color: var(--navy);
  margin: 0;
}
.split-right {
  position: relative;
  overflow: hidden;
  background: #060e1e;
  aspect-ratio: auto;
}
.split-right video {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}
.split-right::before {
  content: "";
  position: absolute;
  top: 0; left: 0; bottom: 0;
  width: 140px;
  z-index: 2;
  background: linear-gradient(90deg,
    rgba(255,255,255,1)    0%,
    rgba(255,255,255,0.96) 10%,
    rgba(255,255,255,0.82) 28%,
    rgba(255,255,255,0.55) 50%,
    rgba(255,255,255,0.22) 72%,
    rgba(255,255,255,0.05) 88%,
    transparent            100%
  );
  pointer-events: none;
}

/* ── Use Case Cards (Flow Diagram Design) ─── */
.usecase-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  margin-top: 0;
}
.usecase-card {
  background: #fff;
  border: 1.5px solid #dde4ef;
  border-radius: 14px;
  padding: 22px 22px 20px;
  position: relative;
  overflow: hidden;
  transition: box-shadow .25s ease, transform .25s ease;
}
.usecase-card:hover {
  box-shadow: 0 8px 32px rgba(0,94,184,.10);
  transform: translateY(-3px);
}
/* Card header with emoji + title */
.uc-card-head {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 8px;
}
.uc-card-icon { display: none; }
.uc-card-title {
  font-size: 20px;
  font-weight: 800;
  color: #005EB8;
  letter-spacing: -.02em;
  margin: 0;
}
.uc-card-desc {
  font-size: 12.5px;
  line-height: 1.65;
  color: #5a6d88;
  margin: 0 0 14px;
}
/* Flow diagram */
.uc-diagram {
  display: flex;
  align-items: stretch;
  gap: 0;
  font-size: 11px;
  min-height: 140px;
}
/* Column wrapper with label on top */
.uc-diagram-col { display: flex; flex-direction: column; }
/* Label row */
.uc-diagram-label {
  font-size: 9.5px;
  font-weight: 700;
  letter-spacing: .12em;
  text-transform: uppercase;
  color: #8899b0;
  margin-bottom: 6px;
  text-align: center;
}
/* DATA SOURCES box */
.uc-src-box {
  flex: 1;
  background: #eef4ff;
  border: 1.5px solid #c5d8f5;
  border-radius: 8px;
  padding: 10px 11px;
}
.uc-src-box ul {
  list-style: none; padding: 0; margin: 0;
}
.uc-src-box ul li {
  font-size: 11px;
  color: #3a4f6e;
  padding: 2px 0;
  line-height: 1.4;
}
/* Arrow between sections */
.uc-arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 6px;
  color: #005EB8;
  font-size: 16px;
  font-weight: 700;
  flex-shrink: 0;
  align-self: center;
  margin-top: 18px;
}
/* RAXEL BOUNDARY dashed box */
.uc-boundary-col { flex: 1.6; display: flex; flex-direction: column; }
.uc-boundary-box {
  flex: 1;
  border: 2px dashed #005EB8;
  border-radius: 8px;
  padding: 8px 8px;
  background: #f5f8ff;
  display: flex;
  align-items: stretch;
  gap: 0;
}
/* Engine blocks column */
.uc-engines {
  display: flex;
  flex-direction: column;
  gap: 4px;
  flex: 1;
}
.uc-engine-block {
  background: #005EB8;
  border-radius: 5px;
  padding: 5px 8px;
  color: #fff;
  font-size: 10.5px;
  font-weight: 700;
  line-height: 1.2;
}
.uc-engine-sub {
  font-size: 9px;
  font-weight: 400;
  color: rgba(255,255,255,.8);
  display: block;
  margin-top: 1px;
}
/* inner arrow */
.uc-inner-arrow {
  display: flex;
  align-items: center;
  padding: 0 5px;
  color: #005EB8;
  font-size: 14px;
  font-weight: 700;
  flex-shrink: 0;
}
/* AI Response */
.uc-response { flex: 1; }
.uc-response-label {
  font-size: 9px;
  font-weight: 700;
  letter-spacing: .1em;
  text-transform: uppercase;
  color: #005EB8;
  margin-bottom: 4px;
}
.uc-response ul {
  list-style: none; padding: 0; margin: 0;
}
.uc-response ul li {
  font-size: 10.5px;
  color: #3a4f6e;
  padding: 1.5px 0;
  line-height: 1.35;
}
.uc-response ul li.hi { color: #d97706; font-weight: 600; }
/* USERS box */
.uc-users-box {
  flex: 1;
  background: #edfbf2;
  border: 1.5px solid #a8d8b8;
  border-radius: 8px;
  padding: 10px 11px;
}
.uc-users-box ul {
  list-style: none; padding: 0; margin: 0;
}
.uc-users-box ul li {
  font-size: 11px;
  color: #2d5a3d;
  padding: 2px 0;
  line-height: 1.4;
}

/* ── Feature Grid ─────────────────────────── */
.feat-section {
  padding: 72px 0;
  background: var(--soft);
}
.feat-section .section-label {
  font-size: 11px;
  font-weight: 700;
  letter-spacing: .18em;
  text-transform: uppercase;
  color: var(--cyan);
  margin-bottom: 36px;
  display: block;
}
.feat-grid-2 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}
.feat-card {
  padding: 28px 32px;
  background: #fff;
  border: 1.5px solid var(--line);
  border-radius: 12px;
  transition: all .3s cubic-bezier(.4,0,.2,1);
  position: relative;
  overflow: hidden;
}
.feat-card::before {
  content: "";
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, #005EB8, #00c2e0);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform .35s cubic-bezier(.4,0,.2,1);
}
.feat-card:hover { border-color: #005EB8; box-shadow: 0 0 0 1px rgba(0,94,184,.15), 0 20px 48px rgba(0,94,184,.12); transform: translateY(-5px); }
.feat-card:hover::before { transform: scaleX(1); }
.feat-card h4 { font-size: 16px; font-weight: 800; color: var(--navy); margin-bottom: 10px; }
.feat-card p { font-size: 13px; line-height: 1.75; color: var(--muted); margin-bottom: 14px; }
.feat-card ul { list-style: none; padding: 0; margin: 0; }
.feat-card ul li {
  font-size: 12.5px;
  color: var(--muted);
  padding: 5px 0;
  border-bottom: 1px solid var(--line);
  display: flex;
  align-items: flex-start;
  gap: 8px;
  line-height: 1.5;
}
.feat-card ul li:last-child { border-bottom: none; }
.feat-card ul li::before { content: "›"; color: var(--blue); font-weight: 700; flex-shrink: 0; }

/* ── Deploy Cards ──────────────────────────── */
.deploy-section {
  padding: 72px 0;
  background: #fff;
  border-top: 1px solid var(--line);
}
.deploy-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  margin-top: 40px;
}
.deploy-card {
  padding: 28px 32px;
  background: var(--soft);
  border: 1.5px solid var(--line);
  border-radius: 12px;
  transition: all .3s cubic-bezier(.4,0,.2,1);
  position: relative;
  overflow: hidden;
}
.deploy-card::before {
  content: "";
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, #005EB8, #00c2e0);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform .35s cubic-bezier(.4,0,.2,1);
}
.deploy-card:hover { border-color: #005EB8; box-shadow: 0 16px 40px rgba(0,94,184,.10); transform: translateY(-4px); }
.deploy-card:hover::before { transform: scaleX(1); }
.deploy-card h4 { font-size: 16px; font-weight: 800; color: var(--navy); margin-bottom: 10px; }
.deploy-card p { font-size: 13px; line-height: 1.75; color: var(--muted); margin: 0; }

/* ── Hardware Cards ────────────────────────── */
.hw-section {
  padding: 72px 0;
  background: linear-gradient(180deg, #060e1e 0%, #0b1e38 100%);
}
.hw-section .section-title { color: #fff; margin-bottom: 12px; }
.hw-section-sub { font-size: 16px; color: rgba(255,255,255,.6); margin-bottom: 40px; }
.hw-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 24px;
}
.hw-card {
  padding: 28px 32px;
  background: rgba(255,255,255,.04);
  border: 1px solid rgba(255,255,255,.08);
  border-radius: 12px;
  transition: background .2s;
}
.hw-card:hover { background: rgba(0,94,184,.08); }
.hw-card h4 { font-size: 22px; font-weight: 800; color: #fff; margin-bottom: 6px; letter-spacing: -.02em; }
.hw-role { font-size: 12px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: rgba(0,94,184,.9); margin-bottom: 12px; }
.hw-desc { font-size: 13px; color: rgba(255,255,255,.6); line-height: 1.7; }

@media (max-width: 900px) {
  .split-inner { grid-template-columns: 1fr; }
  .split-left  { padding: 48px 0 32px; }
  .split-right { min-height: 260px; }
  .split-right::before { display: none; }
  .feat-grid-2, .usecase-grid, .deploy-grid { grid-template-columns: 1fr; }
  .hw-grid { grid-template-columns: 1fr; }
}

/* ── RAXEL Hero Override ─────────────────── */
.raxel-hero {
  padding: 180px 0 171px;
  min-height: 669px;
  background: #060e1e;
  border-bottom: none;
  position: relative;
  overflow: hidden;
}
/* Video background layer */
.raxel-hero-video-bg {
  position: absolute;
  inset: 0;
  z-index: 0;
}
.raxel-hero-video-bg video {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}
/* Dark overlay for text readability */
.raxel-hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(6,14,30,.80) 0%, rgba(0,20,60,.50) 100%);
  z-index: 1;
}
.raxel-hero .wrap {
  position: relative;
  z-index: 2;
  max-width: 1380px;
}
.raxel-hero-inner {
  display: flex;
  flex-direction: column;
  gap: 28px;
  max-width: 820px;
}
/* double-line title */
.raxel-h1 {
  font-size: clamp(36px, 5vw, 60px);
  font-weight: 800;
  line-height: 1.08;
  letter-spacing: -.03em;
  color: #fff;
  margin: 0;
}
.raxel-h1 .accent {
  background: linear-gradient(90deg, #4da6ff 0%, #00c2e0 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
/* sub-titles */
.raxel-sub {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.raxel-sub-main {
  font-size: 17px;
  font-weight: 500;
  color: rgba(255,255,255,.85);
  letter-spacing: -.01em;
}
.raxel-sub-accent {
  font-size: 16px;
  color: rgba(255,255,255,.6);
  font-style: italic;
}
/* keyword row */
.raxel-keywords {
  font-size: 13px;
  font-weight: 600;
  color: rgba(255,255,255,.5);
  letter-spacing: .02em;
  margin-top: 4px;
}
/* Breadcrumb on dark bg */
.raxel-hero .breadcrumb a { color: rgba(255,255,255,.7); }
.raxel-hero .breadcrumb a:hover { color: #4da6ff; }
.raxel-hero .breadcrumb .sep { color: rgba(255,255,255,.3); }
.raxel-hero .breadcrumb > span:last-child { color: rgba(255,255,255,.9); }

/* ── Raxel Video Section ──────────────────── */
.raxel-video-section {
  padding: 64px 0;
  background: #fff;
  border-bottom: 1px solid var(--line);
}
.raxel-video-header {
  text-align: center;
  margin-bottom: 40px;
}
.raxel-brand-logo {
  display: block;
  margin: 0 auto 20px;
  height: 53px;
  width: auto;
  object-fit: contain;
}
.raxel-video-title {
  font-size: clamp(28px, 3.5vw, 44px);
  font-weight: 800;
  color: var(--navy);
  letter-spacing: -.025em;
  margin: 0 0 12px;
}
.raxel-video-sub {
  font-size: 17px;
  color: var(--muted);
  max-width: 560px;
  margin: 0 auto;
  line-height: 1.7;
}
.raxel-video-wrap {
  width: calc(100% - 48px);
  max-width: 1100px;
  min-height: 360px;
  margin: 0 auto;
  border-radius: 16px;
  overflow: hidden;
  background: #060e1e;
  box-shadow: 0 8px 48px rgba(0,94,184,.15);
}
.raxel-video-wrap video {
  width: 100%;
  height: auto;
  min-height: 360px;
  display: block;
  object-fit: cover;
}


/* ── Tab Section ───────────────────────────── */
.tab-section {
  padding: 80px 0 88px;
  background: linear-gradient(180deg, #f7f9fc 0%, #fff 60%);
  border-bottom: 1px solid var(--line);
}
.tab-header {
  text-align: center;
  margin-bottom: 40px;
}
.tab-main-title {
  font-size: clamp(26px, 3vw, 40px);
  font-weight: 800;
  color: var(--navy);
  letter-spacing: -.025em;
  margin: 0 0 12px;
}
.tab-main-desc {
  font-size: 16px;
  color: var(--muted);
  max-width: 540px;
  margin: 0 auto;
  line-height: 1.7;
}
/* Tab pill bar */
.tab-pills {
  display: flex;
  background: var(--soft);
  border: 1px solid var(--line);
  border-radius: 12px;
  padding: 5px;
  gap: 4px;
  margin-bottom: 36px;
  max-width: 520px;
  margin-left: auto;
  margin-right: auto;
}
.tab-pill {
  flex: 1;
  padding: 11px 20px;
  border: none;
  border-radius: 8px;
  font-size: 13.5px;
  font-weight: 700;
  cursor: pointer;
  transition: all .22s cubic-bezier(.4,0,.2,1);
  background: transparent;
  color: var(--muted);
  letter-spacing: .01em;
  font-family: inherit;
}
.tab-pill.active {
  background: #005EB8;
  color: #fff;
  box-shadow: 0 4px 16px rgba(0,94,184,.28);
}
.tab-pill:hover:not(.active) {
  background: #fff;
  color: var(--ink);
}
/* Tab panels */
.tab-panel {
  display: none;
  animation: tabFadeIn .3s ease;
}
.tab-panel.active { display: block; }
@keyframes tabFadeIn {
  from { opacity:0; transform:translateY(10px); }
  to   { opacity:1; transform:translateY(0); }
}
/* Usecase grid inside tab */
.tab-section .usecase-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 24px;
  margin-top: 0;
}
.tab-section .usecase-card {
  padding: 28px 28px 24px;
  background: #ffffff;
  border: 1.5px solid var(--line);
  border-radius: 14px;
  box-shadow: 0 2px 16px rgba(0,0,0,.05);
  position: relative;
  overflow: hidden;
  transition: all .3s cubic-bezier(.4,0,.2,1);
}
.tab-section .usecase-card::before {
  content: "";
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, #005EB8, #00c2e0);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform .35s cubic-bezier(.4,0,.2,1);
}
.tab-section .usecase-card:hover {
  border-color: #005EB8;
  box-shadow: 0 12px 40px rgba(0,94,184,.12);
  transform: translateY(-4px);
}
.tab-section .usecase-card:hover::before { transform: scaleX(1); }
.tab-section .usecase-card h4 {
  font-size: 20px;
  font-weight: 800;
  color: var(--navy);
  margin: 4px 0 10px;
}
.tab-section .usecase-card > p {
  font-size: 13px;
  line-height: 1.75;
  color: var(--muted);
  margin: 0 0 18px;
}
.tab-section .uc-flow {
  background: #f4f7fb;
  border: 1px solid #dce5ef;
}
.tab-section .uc-col-center {
  background: rgba(0,94,184,.04);
}
.uc-tag {
  display: inline-block;
  font-size: 10.5px;
  font-weight: 700;
  letter-spacing: .12em;
  text-transform: uppercase;
  color: var(--blue);
  margin-bottom: 10px;
}
/* ── Product Capabilities simple card ───────── */
.cap-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}
.cap-card {
  background: #fff;
  border: 1.5px solid #dde4ef;
  border-radius: 14px;
  padding: 28px 28px 26px;
  transition: box-shadow .25s ease, transform .25s ease;
}
.cap-card:hover {
  box-shadow: 0 8px 32px rgba(0,94,184,.10);
  transform: translateY(-3px);
}
.cap-card-title {
  font-size: 20px;
  font-weight: 800;
  color: #0b1e38;
  letter-spacing: -.02em;
  margin: 0 0 10px;
  text-align: left;
}
.cap-card-desc {
  font-size: 13px;
  line-height: 1.65;
  color: #2563a8;
  margin: 0 0 18px;
}
.cap-list {
  list-style: none;
  padding: 0;
  margin: 0;
  border-top: 1px solid #eaeef5;
  padding-top: 14px;
}
.cap-list li {
  font-size: 13px;
  color: #3a4f6e;
  padding: 5px 0;
  line-height: 1.5;
  display: flex;
  align-items: flex-start;
  gap: 7px;
}
.cap-list li::before {
  content: "›";
  color: #005EB8;
  font-weight: 700;
  font-size: 15px;
  line-height: 1.3;
  flex-shrink: 0;
}
/* Feat card icon */
.feat-icon-wrap {
  font-size: 28px;
  margin-bottom: 14px;
  line-height: 1;
}

</style>

<section class="raxel-hero">
<!-- Video background -->
<div class="raxel-hero-video-bg">
  <video autoplay muted loop playsinline preload="metadata">
    <source src="../../../image/RAXELAI_HERO_c.mp4" type="video/mp4">
  </video>
</div>
<div class="raxel-hero-overlay"></div>
<div class="wrap fu">
  <nav class="breadcrumb">
    <a href="../../../index.html">Home</a><span class="sep">›</span>
    <a href="../../../pages/solutions/index.html">Solutions</a><span class="sep">›</span>
    <span>RAXEL AI</span>
  </nav>
  <div class="raxel-hero-inner">
    <h1 class="raxel-h1">
      The Enterprise AI Platform<br>
      <span class="accent">Built to Stay On-Premises</span>
    </h1>
    <div class="raxel-sub">
      <p class="raxel-sub-main">Designed for mid-size enterprises &middot; Local deployment &middot; Full governance</p>
      <p class="raxel-sub-accent">Your data. Your infrastructure. Your AI advantage.</p>
    </div>
    <p class="raxel-keywords">On-Premises &middot; Data Sovereignty &middot; Ready Out of the Box</p>
  </div>
</div>
</section>


<!-- ════ VIDEO: Why Raxel ════ -->
<section class="raxel-video-section">
  <div class="wrap">
    <div class="raxel-video-header fu">
      <img src="../../../image/raxel-black.png" alt="RAXEL" class="raxel-brand-logo">
      <h2 class="raxel-video-title">Why Raxel</h2>
      <p class="raxel-video-sub">Your proprietary data is your competitive edge. Keep it that way.</p>
    </div>
    <div class="raxel-video-wrap">
      <video autoplay muted loop playsinline preload="auto" style="width:100%;height:auto;display:block">
        <source src="../../../image/raxel-hero.mp4" type="video/mp4">
      </video>
    </div>
  </div>
</section>

<!-- ════ WHY RAXEL CARDS ════ -->
<section class="section" style="padding:72px 0;background:#fff;border-bottom:1px solid var(--line)">
  <div class="wrap">
    <div class="card-grid col3">
      <div class="f-card fu d1">
        <h3>Data Sovereignty</h3>
        <p>All computation happens inside your infrastructure. Customer data, process records, and financial information never leave your firewall — fully compliant with data protection regulations.</p>
      </div>
      <div class="f-card fu d2">
        <h3>Governance Depth</h3>
        <p>Sensitive data classification, complete audit trails, SSO identity integration, and department-level access control — AI adoption that meets enterprise compliance standards.</p>
      </div>
      <div class="f-card fu d3">
        <h3>Ready Out of the Box</h3>
        <p>Hardware and software ship as an integrated solution. No large IT team required. Business users ask questions in natural language and get value from day one.</p>
      </div>
    </div>
  </div>
</section>


<!-- ════ TABBED: SOLVING ENTERPRISE PROBLEMS ════ -->
<section class="tab-section">
  <div class="wrap">
    <div class="tab-header fu">
      <h2 class="tab-main-title">Solving Real Enterprise Problems</h2>
      <p class="tab-main-desc">From industry use cases to product capabilities — find the right entry point for your organization.</p>
    </div>

    <!-- Tab Pills -->
    <div class="tab-pills" role="tablist">
      <button class="tab-pill active" data-tab="usecases" role="tab" aria-selected="true">
        Industry Use Cases
      </button>
      <button class="tab-pill" data-tab="capabilities" role="tab" aria-selected="false">
        Product Capabilities
      </button>
    </div>

    <!-- Panel: Industry Use Cases -->
    <div class="tab-panel active" id="panel-usecases">
      <div class="usecase-grid">

        <!-- Smart Manufacturing -->
        <div class="usecase-card">
          <div class="uc-card-head">
            <h4 class="uc-card-title">Smart Manufacturing</h4>
          </div>
          <p class="uc-card-desc">Decades of tribal knowledge, scattered manuals, and siloed production data — unified inside Raxel. Floor technicians get instant cited answers. Knowledge stays when people leave.</p>
          <div class="uc-diagram">
            <!-- DATA SOURCES -->
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Data Sources</div>
              <div class="uc-src-box">
                <ul>
                  <li>Equipment Manuals</li><li>Maintenance Logs</li>
                  <li>Process SOPs</li><li>Quality Reports</li>
                  <li>Production Data</li><li>Supplier Records</li>
                </ul>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <!-- RAXEL BOUNDARY -->
            <div class="uc-boundary-col">
              <div class="uc-diagram-label">Raxel Boundary</div>
              <div class="uc-boundary-box">
                <div class="uc-engines">
                  <div class="uc-engine-block">Knowledge Engine<span class="uc-engine-sub">Ingest · Index · Retrieve</span></div>
                  <div class="uc-engine-block">AI Reasoning<span class="uc-engine-sub">Understand · Answer · Cite</span></div>
                  <div class="uc-engine-block">Governance Layer<span class="uc-engine-sub">Permissions · Audit</span></div>
                </div>
                <div class="uc-inner-arrow">→</div>
                <div class="uc-response">
                  <div class="uc-response-label">AI Response</div>
                  <ul>
                    <li>Root cause answer</li><li>Cited source doc</li>
                    <li>Defect trend</li><li>Traceability report</li>
                    <li class="hi">Training guide</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <!-- USERS -->
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Users</div>
              <div class="uc-users-box">
                <ul>
                  <li>Floor Technicians</li><li>Quality Engineers</li>
                  <li>Process Managers</li><li>New Hires</li>
                  <li>Procurement</li><li>Plant Managers</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Smart Retail -->
        <div class="usecase-card">
          <div class="uc-card-head">
            <h4 class="uc-card-title">Smart Retail</h4>
          </div>
          <p class="uc-card-desc">Store, e-commerce, inventory, and membership systems unified inside Raxel. Business users get data-driven answers without waiting for IT — customer data never touches the cloud.</p>
          <div class="uc-diagram">
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Data Sources</div>
              <div class="uc-src-box">
                <ul>
                  <li>POS / Store Systems</li><li>E-Commerce Platform</li>
                  <li>Inventory System</li><li>Membership DB</li>
                  <li>Supplier / ERP</li><li>Promo Records</li>
                </ul>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-boundary-col">
              <div class="uc-diagram-label">Raxel Boundary</div>
              <div class="uc-boundary-box">
                <div class="uc-engines">
                  <div class="uc-engine-block">Data Integration<span class="uc-engine-sub">Connect · Unify · Normalize</span></div>
                  <div class="uc-engine-block">NL to Query<span class="uc-engine-sub">Parse · Execute · Visualize</span></div>
                  <div class="uc-engine-block">Governance Layer<span class="uc-engine-sub">Permissions · Audit</span></div>
                </div>
                <div class="uc-inner-arrow">→</div>
                <div class="uc-response">
                  <div class="uc-response-label">AI Response</div>
                  <ul>
                    <li>SKU performance</li><li>Return rate analysis</li>
                    <li>Promo effectiveness</li><li>Inventory forecast</li>
                    <li class="hi">Trend charts</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Users</div>
              <div class="uc-users-box">
                <ul>
                  <li>Store Managers</li><li>Marketing Teams</li>
                  <li>Buyers / Procurement</li><li>Regional Directors</li>
                  <li>Operations Teams</li><li>Executives</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Smart Office -->
        <div class="usecase-card">
          <div class="uc-card-head">
            <h4 class="uc-card-title">Smart Office</h4>
          </div>
          <p class="uc-card-desc">Contracts, approvals, and meeting minutes consolidated into one queryable knowledge base. Employees get cited answers — sensitive documents never uploaded to external AI tools.</p>
          <div class="uc-diagram">
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Data Sources</div>
              <div class="uc-src-box">
                <ul>
                  <li>Contracts / NAS</li><li>Approvals / ERP</li>
                  <li>Meeting Minutes</li><li>Reports / Policies</li>
                  <li>HR Documents</li><li>Email / Decisions</li>
                </ul>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-boundary-col">
              <div class="uc-diagram-label">Raxel Boundary</div>
              <div class="uc-boundary-box">
                <div class="uc-engines">
                  <div class="uc-engine-block">Document Intelligence<span class="uc-engine-sub">Parse · Chunk · Embed</span></div>
                  <div class="uc-engine-block">Semantic Retrieval<span class="uc-engine-sub">Search · Rank · Cite</span></div>
                  <div class="uc-engine-block">Governance Layer<span class="uc-engine-sub">SSO · Role Access · Audit</span></div>
                </div>
                <div class="uc-inner-arrow">→</div>
                <div class="uc-response">
                  <div class="uc-response-label">AI Response</div>
                  <ul>
                    <li>Contract clause answer</li><li>Cross-doc comparison</li>
                    <li>Decision summary</li><li class="hi">Policy lookup</li>
                    <li class="hi">Source cited always</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Users</div>
              <div class="uc-users-box">
                <ul>
                  <li>Legal / Compliance</li><li>Finance Teams</li>
                  <li>HR Departments</li><li>All Staff</li>
                  <li>Procurement</li><li>Executives</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Smart Security -->
        <div class="usecase-card">
          <div class="uc-card-head">
            <h4 class="uc-card-title">Smart Security</h4>
          </div>
          <p class="uc-card-desc">All logs analyzed inside the firewall. Threats surfaced before damage is done, incidents reconstructed in minutes — security data never sent to an external platform for analysis.</p>
          <div class="uc-diagram">
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Data Sources</div>
              <div class="uc-src-box">
                <ul>
                  <li>System / App Logs</li><li>Access Records</li>
                  <li>Network Traffic</li><li>Endpoint Alerts</li>
                  <li>Firewall Events</li><li>Auth / IAM Logs</li>
                </ul>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-boundary-col">
              <div class="uc-diagram-label">Raxel Boundary</div>
              <div class="uc-boundary-box">
                <div class="uc-engines">
                  <div class="uc-engine-block">Log Aggregation<span class="uc-engine-sub">Collect · Normalize · Index</span></div>
                  <div class="uc-engine-block">Anomaly Detection<span class="uc-engine-sub">Pattern · Score · Alert</span></div>
                  <div class="uc-engine-block">Governance Layer<span class="uc-engine-sub">Audit · Compliance · Report</span></div>
                </div>
                <div class="uc-inner-arrow">→</div>
                <div class="uc-response">
                  <div class="uc-response-label">AI Response</div>
                  <ul>
                    <li>Daily risk summary</li><li class="hi">Anomalous accounts</li>
                    <li>Incident timeline</li><li>Threat patterns</li>
                    <li class="hi">Compliance report</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="uc-arrow">→</div>
            <div class="uc-diagram-col" style="flex:1">
              <div class="uc-diagram-label">Users</div>
              <div class="uc-users-box">
                <ul>
                  <li>IT Managers</li><li>Security Teams</li>
                  <li>Compliance Officers</li><li>Risk Management</li>
                  <li>Auditors</li><li>Executives</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

      </div><!-- /usecase-grid -->
    </div><!-- /panel-usecases -->

    <!-- Panel: Product Capabilities -->

    <div class="tab-panel" id="panel-capabilities">
      <div class="cap-grid">

        <!-- Document Intelligence -->
        <div class="cap-card">
          <h4 class="cap-card-title">Document Intelligence</h4>
          <p class="cap-card-desc">Transform unstructured enterprise content — PDFs, Word files, scanned documents, presentations — into a queryable, citable, and comparable knowledge resource.</p>
          <ul class="cap-list">
            <li>Multi-format parsing: PDF, Word, Excel, scanned images</li>
            <li>Semantic search — find relevant content without exact keywords</li>
            <li>Cross-document comparison</li>
            <li>Source citation on every answer — no hallucinated content</li>
            <li>Role-based access control by department</li>
          </ul>
        </div>

        <!-- IT Operations -->
        <div class="cap-card">
          <h4 class="cap-card-title">IT Operations</h4>
          <p class="cap-card-desc">Turn the flood of daily logs, alerts, and tickets from noise into actionable intelligence — protecting more with less manual effort.</p>
          <ul class="cap-list">
            <li>Multi-source log aggregation and semantic analysis</li>
            <li>Anomaly pattern recognition with proactive alerts</li>
            <li>Natural language log queries</li>
            <li>Incident timeline reconstruction for forensic investigation</li>
            <li>Auto-generated compliance reports</li>
          </ul>
        </div>

        <!-- Enterprise Knowledge -->
        <div class="cap-card">
          <h4 class="cap-card-title">Enterprise Knowledge</h4>
          <p class="cap-card-desc">Organizational knowledge shouldn't live only in people's heads. Make every document, every decision, and every lesson learned available to whoever needs it next.</p>
          <ul class="cap-list">
            <li>Unified knowledge ingestion from documents and systems</li>
            <li>Mixed retrieval across structured and unstructured content</li>
            <li>Version tracking — always the most current information</li>
            <li>Query audit trail — who asked what, and when</li>
            <li>Cross-language support for mixed environments</li>
          </ul>
        </div>

        <!-- Data Insights -->
        <div class="cap-card">
          <h4 class="cap-card-title">Data Insights</h4>
          <p class="cap-card-desc">Structured enterprise data shouldn't be accessible only to those who can write SQL. Enable every business user to talk directly to their data.</p>
          <ul class="cap-list">
            <li>Natural language to query — ask in plain language</li>
            <li>Cross-source integration: ERP, CRM, MES, and more</li>
            <li>Auto-generated visualizations on demand</li>
            <li>Business language mapping — no field names needed</li>
            <li>Role-based query permissions</li>
          </ul>
        </div>

      </div><!-- /cap-grid -->
    </div><!-- /panel-capabilities -->

  </div>
</section>


<!-- ════ DEPLOYMENT OPTIONS ════ -->
<section class="deploy-section">
  <div class="wrap">
    <h2 class="section-title fu">Flexible Deployment for Every Scale</h2>
    <p class="section-desc fu">From a single site to a multi-branch federation, Raxel adapts to your infrastructure.</p>
    <div class="deploy-grid">
      <div class="deploy-card fu d1">
        <h4>Federated Deployment</h4>
        <p>The SR810 at headquarters serves as the central knowledge hub, while SR710 units at branch locations handle local computation. Each site processes data on-premises; knowledge is shared across locations within authorized boundaries.</p>
      </div>
      <div class="deploy-card fu d2">
        <h4>Standalone Local Deployment</h4>
        <p>Ideal for single-site or departmental rollouts. Full functionality runs within your internal environment with no external dependencies. Operations continue even without internet connectivity.</p>
      </div>
    </div>
  </div>
</section>


<!-- ════ HARDWARE PRODUCT LINE ════ -->
<section class="hw-section">
  <div class="wrap">
    <h2 class="section-title fu">Hardware Product Line</h2>
    <p class="hw-section-sub fu">Integrated hardware and software — ship together, deploy immediately.</p>
    <div class="hw-grid">
      <div class="hw-card fu d1">
        <h4>SE210</h4>
        <div class="hw-role">AI Security Appliance</div>
        <div class="hw-desc">Edge AI firewall for traffic monitoring and threat detection. Evolving as a standalone AI security product line.</div>
      </div>
      <div class="hw-card fu d2">
        <h4>SR710</h4>
        <div class="hw-role">Primary Compute Platform</div>
        <div class="hw-desc">GPU-accelerated, full-featured platform for mid-size enterprise deployments. Also functions as a branch node in federated architectures.</div>
      </div>
      <div class="hw-card fu d3">
        <h4>SR810</h4>
        <div class="hw-role">Enterprise Knowledge Hub</div>
        <div class="hw-desc">The central node in federated deployments. Manages cross-site knowledge synchronization and access policies. Designed for headquarters deployment.</div>
      </div>
      <div class="hw-card fu d4">
        <h4>AI Box</h4>
        <div class="hw-role">Entry-Level Solution</div>
        <div class="hw-desc">Ideal for small-team deployments or proof-of-concept evaluations. Single-unit setup, fast onboarding, low upfront cost.</div>
      </div>
    </div>
  </div>
</section>


    </div>
  </div>
</section>


<script>
// Tab switching
(function(){
  var pills = document.querySelectorAll('.tab-pill');
  pills.forEach(function(pill){
    pill.addEventListener('click', function(){
      var target = pill.getAttribute('data-tab');
      // Update pills
      pills.forEach(function(p){ p.classList.remove('active'); p.setAttribute('aria-selected','false'); });
      pill.classList.add('active'); pill.setAttribute('aria-selected','true');
      // Update panels
      document.querySelectorAll('.tab-panel').forEach(function(panel){ panel.classList.remove('active'); });
      var targetPanel = document.getElementById('panel-'+target);
      if(targetPanel){ targetPanel.classList.add('active'); }
    });
  });
})();

</script>
"@
BuildPage "D:\CNBU-product-site5\pages\ai-hub\raxel-ai\index.html" "RAXEL AI" 3 @("AI Hub", "pages/ai-hub/index.html", "RAXEL AI", "") "AI Hub &middot; Platform" "RAXEL AI Platform" "On-premises enterprise RAG platform for secure, private data querying with full citation." $raxBody


# ─ SERVICES SUBPAGES ───────────────────────────
$labBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Rigorous Certification &amp; Validation Labs</h2>
    <p>Our state-of-the-art testing facilities ensure every hardware design meets international regulatory and safety guidelines before commercial production.</p>
    <h3>Available Testing Services</h3>
    <ul>
      <li style="margin-bottom:12px;"><strong>EMC/EMI Testing:</strong> Pre-compliance testing for FCC, CE, VCCI, and BSMI standards.</li>
      <li style="margin-bottom:12px;"><strong>Thermal &amp; Acoustic:</strong> Advanced wind tunnel simulation and thermal imaging analysis under heavy load conditions.</li>
      <li style="margin-bottom:12px;"><strong>Signal Integrity:</strong> High-bandwidth oscilloscope validation for PCIe Gen 5 and 112G PAM4 lines.</li>
    </ul>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>Lab Scope</h4>
      <ul>
        <li>EMI/EMC chambers</li>
        <li>Acoustic test chambers</li>
        <li>Environmental chambers</li>
        <li>Vibration &amp; drop testing</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\services\laboratory\index.html" "Laboratory" 3 @("Services", "pages/services/index.html", "Laboratory", "") "Services &middot; Labs" "Laboratory Services" "Testing and validation services including EMI/EMC pre-compliance, thermal validation, and environmental testing." $labBody

$techBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Full-Stack System Engineering</h2>
    <p>We provide full-stack product development services from initial board design to customized BIOS/BMC firmware development and OS driver optimization.</p>
    <h3>Our Technology Expertise</h3>
    <ul>
      <li style="margin-bottom:12px;"><strong>Hardware Board Design:</strong> High-speed PCB design with multi-gigabit routing.</li>
      <li style="margin-bottom:12px;"><strong>Firmware Customization:</strong> Tailored UEFI BIOS and Redfish-compliant OpenBMC firmware.</li>
      <li style="margin-bottom:12px;"><strong>BSP Integration:</strong> Custom Linux Board Support Packages (BSP) and driver development.</li>
    </ul>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>Tech Stack</h4>
      <ul>
        <li>Intel / AMD / ARM</li>
        <li>UEFI BIOS / Coreboot</li>
        <li>OpenBMC / AMI</li>
        <li>Custom Linux Drivers</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\services\technology\index.html" "Technology" 3 @("Services", "pages/services/index.html", "Technology", "") "Services &middot; R&amp;D" "Technology Services" "Software and hardware engineering services including BIOS/BMC customization and Linux driver integration." $techBody

$mfgBody = @"
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Advanced Automated Manufacturing</h2>
    <p>Our Taoyuan factory utilizes high-precision SMT lines and robotic assembly networks to deliver consistent quality and scalable output volume.</p>
    <h3>Manufacturing Standards</h3>
    <p>Senao Networks applies 6-Sigma methodologies and automated optical inspection (AOI) to guarantee production yield and component accuracy.</p>
    <h3>Reliability Testing</h3>
    <p>All finished server and appliance platforms undergo strict 72-hour high-temperature burn-in testing to minimize early-life failure rates.</p>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>Production Capacity</h4>
      <ul>
        <li>Precision SMT Lines</li>
        <li>Automated Solder Paste</li>
        <li>3D AOI Validation</li>
        <li>72-Hr Burn-in testing</li>
      </ul>
    </div>
  </div>
</div></div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\services\manufacturing\index.html" "Manufacturing" 3 @("Services", "pages/services/index.html", "Manufacturing", "") "Services &middot; Production" "Manufacturing Services" "World-class SMT automated assembly lines with advanced burn-in testing and optical validation." $mfgBody


# ─ NEWS SUBPAGES ───────────────────────────────
$newsSubBody = @"
<section class="section"><div class="wrap fu">
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Corporate</span><span class="news-date">October 12, 2025</span></div>
    <h3>Senao Networks Joins Open Compute Project (OCP) as Community Member</h3>
    <p>TAIPEI, TAIWAN &mdash; Senao Networks announced today that it has officially joined the OCP community. This partnership highlights our commitment to open-source hardware design, interoperability, and energy-efficient data center architectures.</p>
  </div>
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Product</span><span class="news-date">August 28, 2025</span></div>
    <h3>Senao Launches SX906 SmartNIC Accelerator Platform</h3>
    <p>MILPITAS, CA &mdash; Designed to address high-performance storage and virtualization workloads, the SX906 features dual 100GbE ports, integrated crypto engines, and ARM-based control plane compute.</p>
  </div>
</div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\news\news\index.html" "News" 3 @("News", "pages/news/index.html", "News", "") "News &middot; Releases" "Press Releases" "Latest corporate news, product announcements, and business developments at Senao Networks." $newsSubBody

$eventSubBody = @"
<section class="section"><div class="wrap fu">
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Exhibition</span><span class="news-date">June 3–7, 2025</span></div>
    <h3>Computex 2025 Exhibition</h3>
    <p>Taipei Nangang Exhibition Center, Booth M0804. Join us as we present our latest OCP DC-MHS server platforms, RAXEL AI demonstration hubs, and new edge virtualization appliances.</p>
  </div>
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Conference</span><span class="news-date">October 15–17, 2025</span></div>
    <h3>OCP Global Summit 2025</h3>
    <p>San Jose Convention Center, CA. Visit the Senao kiosk to view our modular DPU cards and custom BMC software integration demos.</p>
  </div>
</div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\news\events\index.html" "Events" 3 @("News", "pages/news/index.html", "Events", "") "News &middot; Events" "Upcoming Events" "Trade shows, tech summits, webinars, and industrial expos where Senao Networks is participating." $eventSubBody

$blogSubBody = @"
<section class="section"><div class="wrap fu">
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Engineering</span><span class="news-date">November 4, 2025</span></div>
    <h3>Understanding OCP DC-MHS Server Architecture Standard</h3>
    <p>A technical analysis of the new Data Center Modular Hardware System (DC-MHS) standard, and how it simplifies motherboard design, BMC customization, and multi-vendor server deployments.</p>
  </div>
  <div class="news-item">
    <div class="news-meta"><span class="news-tag">Security</span><span class="news-date">September 19, 2025</span></div>
    <h3>Securing the Edge: Hardware Root-of-Trust (RoT) Integration</h3>
    <p>How embedded security chips and secure boot signatures protect remote network edge appliances from physical and side-channel security threats.</p>
  </div>
</div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\news\blog\index.html" "Blog" 3 @("News", "pages/news/index.html", "Blog", "") "News &middot; Blog" "Engineering Blog" "Deep-dive hardware analysis, software tips, and engineering columns from our R&amp;D leads." $blogSubBody


# ─ SUPPORT SUBPAGES ────────────────────────────
$contactSubBody = @"
<section class="section">
  <div class="wrap">
    <div class="contact-grid fu">
      <!-- Form -->
      <div>
        <h2 style="font-size: 29px; font-weight:800; color:var(--navy); margin-bottom:24px;">Send Us a Message</h2>
        <form style="display:grid; gap:16px;">
          <div class="form-grid">
            <div class="form-field">
              <label>Name *</label>
              <input type="text" placeholder="Your full name">
            </div>
            <div class="form-field">
              <label>Email *</label>
              <input type="email" placeholder="your@company.com">
            </div>
            <div class="form-field">
              <label>Company</label>
              <input type="text" placeholder="Company name">
            </div>
            <div class="form-field">
              <label>Phone</label>
              <input type="tel" placeholder="+1 (555) 000-0000">
            </div>
            <div class="form-field full">
              <label>Inquiry Type</label>
              <select>
                <option value="">Select inquiry type...</option>
                <option>Product Technical Inquiry</option>
                <option>Request a Quote</option>
                <option>Partnership Proposal</option>
                <option>OEM / ODM Inquiry</option>
                <option>Customer Support</option>
                <option>Media / Press</option>
              </select>
            </div>
            <div class="form-field full">
              <label>Message *</label>
              <textarea rows="6" placeholder="Please describe your needs in detail..."></textarea>
            </div>
          </div>
          <div>
            <button type="submit" class="btn btn-primary">Submit Inquiry</button>
          </div>
        </form>
      </div>
      <!-- Contact Info -->
      <div>
        <div class="ci-card">
          <div class="ci-item">
            <div class="ci-icon">📧</div>
            <div>
              <h4>Email</h4>
              <p>sales@senao-networks.com<br>support@senao-networks.com</p>
            </div>
          </div>
          <div class="ci-item">
            <div class="ci-icon">📞</div>
            <div>
              <h4>Phone (Taiwan HQ)</h4>
              <p>+886-3-3289289<br>Monday–Friday 09:00–18:00 CST</p>
            </div>
          </div>
          <div class="ci-item">
            <div class="ci-icon">📍</div>
            <div>
              <h4>Headquarters</h4>
              <p>No. 500, Fuxing 3rd Rd.,<br>Guishan Dist., Taoyuan 333001, Taiwan</p>
            </div>
          </div>
          <div class="ci-item">
            <div class="ci-icon">🌐</div>
            <div>
              <h4>USA Office</h4>
              <p>860 N McCarthy Blvd Ste 200<br>Milpitas, CA 95035, USA</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
"@
BuildPage "D:\CNBU-product-site5\pages\support\contact-us\index.html" "Contact Us" 3 @("Support", "pages/support/index.html", "Contact Us", "") "Support &middot; Contact" "Contact Us" "Technical inquiries, quotation requests, and partnership proposals. Our consultants will respond within one business day." $contactSubBody

$dlSubBody = @"
<section class="section"><div class="wrap fu">
  <div class="filter-bar">
    <button class="filter-btn active">All</button>
    <button class="filter-btn">Server</button>
    <button class="filter-btn">SmartNIC</button>
    <button class="filter-btn">Network Appliance</button>
    <button class="filter-btn">AI Hub</button>
    <button class="filter-btn">Firmware</button>
  </div>
  <table class="dl-table">
    <thead><tr><th>Product</th><th>Document</th><th>Category</th><th>Version</th><th>Action</th></tr></thead>
    <tbody>
      <tr><td>SR710 Server</td><td>SR710 Product Datasheet</td><td><span class="dl-cat">Datasheet</span></td><td>v1.2</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>SR810 GPU Server</td><td>SR810 Technical Specification</td><td><span class="dl-cat">Datasheet</span></td><td>v1.0</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>SX906 SmartNIC</td><td>SX906 Product Brief</td><td><span class="dl-cat">Datasheet</span></td><td>v2.1</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>SX906 SmartNIC</td><td>SX906 Integration Guide</td><td><span class="dl-cat">Guide</span></td><td>v1.3</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>RAXEL AI</td><td>RAXEL AI Platform Overview</td><td><span class="dl-cat">Datasheet</span></td><td>v1.0</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>RAXEL AI</td><td>RAXEL AI Deployment Guide</td><td><span class="dl-cat">Guide</span></td><td>v1.1</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>NA-3000 Appliance</td><td>NA-3000 Technical Spec</td><td><span class="dl-cat">Datasheet</span></td><td>v1.0</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>DC-5000 Switch</td><td>DC-5000 400GbE Datasheet</td><td><span class="dl-cat">Datasheet</span></td><td>v1.0</td><td><a class="dl-btn" href="#">↓ PDF</a></td></tr>
      <tr><td>SR710 Server</td><td>BMC Firmware v2.5.1</td><td><span class="dl-cat">Firmware</span></td><td>v2.5.1</td><td><a class="dl-btn" href="#">↓ ZIP</a></td></tr>
      <tr><td>SX906 SmartNIC</td><td>NIC Driver Package (Linux)</td><td><span class="dl-cat">Driver</span></td><td>v4.1.0</td><td><a class="dl-btn" href="#">↓ TAR</a></td></tr>
    </tbody>
  </table>
</div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\support\downloads\index.html" "Downloads" 3 @("Support", "pages/support/index.html", "Downloads", "") "Support &middot; Resources" "Downloads" "Datasheets, firmware, technical specifications, and integration guides for all Senao products." $dlSubBody

$faqSubBody = @"
<section class="section"><div class="wrap" style="max-width:860px">
  <div class="faq-section fu">
    <div class="faq-section-title">Products &amp; Solutions</div>
    <div class="faq-item">
      <div class="faq-q">What is the difference between the SR710 and SR810 server platforms?</div>
      <div class="faq-a">The SR710 is our standard dual-socket compute platform optimized for CPU-intensive workloads, while the SR810 extends the platform with up to 8x GPU slots for AI inference and HPC applications. Both platforms are OCP DC-MHS compliant.</div>
    </div>
    <div class="faq-item">
      <div class="faq-q">Does the SX906 SmartNIC support VMware vSphere?</div>
      <div class="faq-a">Yes. The SX906 is certified with VMware vSphere 8.x and supports VMware NSX for hardware-accelerated micro-segmentation and distributed firewall enforcement.</div>
    </div>
    <div class="faq-item">
      <div class="faq-q">Which NOS options are supported on the Data Center Switch?</div>
      <div class="faq-a">Our switches ship with ONIE pre-installed and support SONiC, Cumulus Linux, and any ONIE-compatible network operating system. We can also pre-load a customer-specified NOS image.</div>
    </div>
  </div>
  <div class="faq-section fu">
    <div class="faq-section-title">Ordering &amp; OEM</div>
    <div class="faq-item">
      <div class="faq-q">What is the minimum order quantity for OEM customers?</div>
      <div class="faq-a">MOQ varies by product line. For servers and SmartNICs, typical MOQ starts at 50 units for customized configurations. Please contact our sales team for specific pricing and lead times.</div>
    </div>
    <div class="faq-item">
      <div class="faq-q">Can Senao Networks customize BIOS or firmware for OEM projects?</div>
      <div class="faq-a">Yes. We offer full BIOS and BMC firmware customization including splash screens, feature flags, Redfish API extensions, and secure boot configuration for OEM customers with volume commitments.</div>
    </div>
  </div>
  <div class="faq-section fu">
    <div class="faq-section-title">Technical Support &amp; Warranty</div>
    <div class="faq-item">
      <div class="faq-q">What is the standard warranty on Senao server products?</div>
      <div class="faq-a">All server platforms carry a standard 3-year next-business-day on-site warranty in Taiwan, with global depot repair options. Extended 5-year and 7-year warranty programs are available.</div>
    </div>
    <div class="faq-item">
      <div class="faq-q">How do I access 24/7 technical support?</div>
      <div class="faq-a">Enterprise support customers have access to our 24/7 technical hotline and dedicated support portal. Standard support is available Monday through Friday 09:00–18:00 CST. Contact us to upgrade your support level.</div>
    </div>
  </div>
</div></section>
"@
BuildPage "D:\CNBU-product-site5\pages\support\faq\index.html" "FAQ" 3 @("Support", "pages/support/index.html", "FAQ", "") "Support &middot; FAQ" "Frequently Asked Questions" "Common questions about our products, ordering, and technical support." $faqSubBody

Write-Host "All 27 pages generated successfully"

























