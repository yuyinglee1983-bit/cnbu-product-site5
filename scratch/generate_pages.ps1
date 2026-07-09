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
<section class="section">
  <div class="wrap fu">
    <div style="margin-bottom: 48px;">
      <h2 style="font-size: 31px; font-weight:800; color:var(--navy); margin-bottom:16px;">Global Coverage Map</h2>
      <div style="background:#eaeff5; border-radius:12px; padding:24px; text-align:center; border:1px solid var(--line);">
        <img src="https://statics.senaonetworks.com/wp-content/uploads/2025/08/29152816/senao-map-2025_en-1.png" alt="Senao Networks Global Presence Map" style="max-width:100%; border-radius:8px; box-shadow:0 6px 18px rgba(0,0,0,.08); margin:0 auto;">
      </div>
    </div>
    <div class="content-grid">
      <div class="content-body">
        <h2>Senao Networks Global Presence &amp; Subsidiaries</h2>
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:28px; margin-top:24px;">
          <div>
            <h3 style="margin-top:0;">Taiwan (HQ &amp; Manufacturing)</h3>
            <p><strong>Senao Networks, Inc.</strong><br>No. 500, Fuxing 3rd Rd., Guishan Dist., Taoyuan City 333, Taiwan<br>Tel: +886-3-3289289</p>
          </div>
          <div>
            <h3 style="margin-top:0;">United States (R&amp;D &amp; Sales)</h3>
            <p><strong>Senao Networks USA, Inc.</strong><br>860 N McCarthy Blvd Ste 200, Milpitas, CA 95035, USA<br>Tel: +1-408-943-8080</p>
          </div>
          <div>
            <h3 style="margin-top:0;">Japan Office (Business Development)</h3>
            <p><strong>Senao Networks Japan</strong><br>Tokyo, Japan<br>Email: sales-jp@senao-networks.com</p>
          </div>
          <div>
            <h3 style="margin-top:0;">India R&amp;D Center (Software Engineering)</h3>
            <p><strong>Senao Networks India Pvt. Ltd.</strong><br>Bangalore, India<br>Email: support-in@senao-networks.com</p>
          </div>
        </div>
      </div>
      <div>
        <div class="sidebar-card">
          <h4>Global Network</h4>
          <ul>
            <li>R&amp;D Centers: 2</li>
            <li>Production Sites: 1</li>
            <li>Sales Hubs: 4</li>
            <li>Global Logistics support</li>
          </ul>
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
<section class="section"><div class="wrap fu"><div class="content-grid">
  <div class="content-body">
    <h2>Secure, Private Enterprise AI Intelligence</h2>
    <p>RAXEL AI is an on-premises Retrieval-Augmented Generation (RAG) platform that allows teams to query massive internal document libraries with cited, reliable answers.</p>
    <p>By running entirely on Senao GPU-accelerated server platforms, your data never leaves your facility. Perfect for legal, financial, and product engineering teams with strict compliance mandates.</p>
    <h3>Why On-Premises RAG?</h3>
    <p>Unlike public API models, RAXEL AI does not expose proprietary data to external cloud servers, eliminating the risk of corporate data leaks or compliance violations.</p>
  </div>
  <div>
    <div class="sidebar-card">
      <h4>System Specs</h4>
      <ul>
        <li>Supported Models: Llama 3, Mistral</li>
        <li>Vector Store: pgvector, Qdrant</li>
        <li>Hardware: GPU-accelerated</li>
        <li>Format Support: PDF, DOCX, MD</li>
      </ul>
    </div>
  </div>
</div></div></section>
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
























