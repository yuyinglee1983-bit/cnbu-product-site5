/* ── site.js — shared header & footer injection ── */

/* ─ NAV CONFIG ─────────────────────────────────── */
const NAV = [
  {
    label: 'About', href: 'pages/about/index.html',
    children: [
      { label: 'About Senao Computing', href: 'pages/about/about-senao-computing/index.html' },
      { label: 'Global Presence',       href: 'pages/about/global-presence/index.html' },
      { label: 'Certification',         href: 'pages/about/certification/index.html' },
      { label: 'ESG',                   href: 'pages/about/esg/index.html' },
    ]
  },
  {
    label: 'Solution', href: 'pages/solution/index.html',
    children: [
      { label: 'Server',              href: 'pages/solution/server/index.html' },
      { label: 'Edge Server',         href: 'pages/solution/edge-server/index.html' },
      { label: 'SmartNIC',            href: 'pages/solution/smartnic/index.html' },
      { label: 'Network Appliance',   href: 'pages/solution/network-appliance/index.html' },
      { label: 'Data Center Switch',  href: 'pages/solution/data-center-switch/index.html' },
      { label: 'COM Express Module',  href: 'pages/solution/com-express-module/index.html' },
    ]
  },
  {
    label: 'AI Hub', href: 'pages/ai-hub/index.html',
    children: [
      { label: 'RAXEL AI', href: 'pages/ai-hub/raxel-ai/index.html' },
    ]
  },
  {
    label: 'Services', href: 'pages/services/index.html',
    children: [
      { label: 'Laboratory',   href: 'pages/services/laboratory/index.html' },
      { label: 'Technology',   href: 'pages/services/technology/index.html' },
      { label: 'Manufacturing',href: 'pages/services/manufacturing/index.html' },
    ]
  },
  {
    label: 'News', href: 'pages/news/index.html',
    children: [
      { label: 'News',   href: 'pages/news/news/index.html' },
      { label: 'Events', href: 'pages/news/events/index.html' },
      { label: 'Blog',   href: 'pages/news/blog/index.html' },
    ]
  },
  {
    label: 'Support', href: 'pages/support/index.html',
    children: [
      { label: 'Downloads',  href: 'pages/support/downloads/index.html' },
      { label: 'FAQ',        href: 'pages/support/faq/index.html' },
    ]
  },
];

/* ─ ROOT RESOLVER ───────────────────────────────── */
function getRoot() {
  return document.body.dataset.root || './';
}

/* ─ HEADER ──────────────────────────────────────── */
function buildHeader() {
  const root = getRoot();
  const header = document.getElementById('site-header');
  if (!header) return;

  const navHTML = NAV.map(item => {
    const dropHTML = item.children.map(c =>
      `<a class="drop-link" href="${root}${c.href}">${c.label}</a>`
    ).join('');
    return `
      <li class="nav-item">
        <a class="nav-link" href="${root}${item.href}">${item.label}</a>
        <div class="drop-menu">
          <div class="drop-menu-inner">${dropHTML}</div>
        </div>
      </li>`;
  }).join('');

  header.innerHTML = `
    <div class="wrap hd-inner">
      <a class="hd-logo" href="${root}index.html">
        <img src="${root}assets/img/LOGO2.png" alt="Senao Networks" style="height:46px; display:block;">
      </a>
      <nav class="hd-nav">
        <ul class="nav-list">${navHTML}</ul>
      </nav>
      <div class="hd-actions">
        <div class="hd-search-wrapper">
          <div class="hd-search-container" id="hdSearch">
            <input type="text" class="hd-search-input" placeholder="I'm looking for...">
            <button class="hd-search-btn" aria-label="Search" onclick="document.getElementById('hdSearch').classList.toggle('active'); document.querySelector('.hd-search-input').focus();">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </button>
          </div>
        </div>
        <div class="hd-lang">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
          <span class="hd-lang-text">EN</span>
          <svg class="hd-lang-arrow" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
          <div class="hd-lang-menu">
            <a href="#">EN</a>
            <a href="#">CH</a>
            <a href="#">JP</a>
          </div>
        </div>
      </div>
    </div>`;

  /* inject header styles once */
  if (!document.getElementById('hd-style')) {
    const s = document.createElement('style');
    s.id = 'hd-style';
    s.textContent = `
      #site-header { height:auto; background:#ffffff; border-bottom:1px solid var(--line); }
      .hd-inner { display:flex; align-items:center; width:100%; padding-top:0; padding-bottom:0; height:72px; }
      .hd-logo { display:flex; align-items:center; margin-left:-90px; }
      .hd-nav { margin-left:auto; margin-right:56px; }
      .nav-list { list-style:none; display:flex; gap:28px; }
      .nav-item { position:relative; }
      .nav-link { display:flex; align-items:center; padding:8px 0; font-size:16px; font-weight:700; color:var(--navy); transition:color .2s; cursor:pointer; }
      .nav-link:hover, .nav-link.active { color:var(--blue); }
      .drop-menu {
        opacity: 0;
        visibility: hidden;
        transform: translateY(8px);
        transition: opacity 0.2s cubic-bezier(0.4,0,0.2,1), transform 0.2s cubic-bezier(0.4,0,0.2,1), visibility 0.2s;
        position: absolute;
        top: 100%;
        left: 0;
        padding-top: 12px;
        min-width: 220px;
        z-index: 200;
        pointer-events: none;
      }
      .drop-menu.active {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
        pointer-events: auto;
      }
      .drop-menu-inner {
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 12px 40px rgba(0,50,120,.18);
        padding: 10px 6px;
        border: 1px solid var(--line);
      }
      .drop-link { display:block; padding:9px 16px; font-size:15px; font-weight:500; color:#2a3550; border-radius:7px; transition:background .18s,color .18s; }
      .drop-link:hover { background:rgba(0,94,184,.08); color:var(--blue); }
      .hd-actions { display:flex; align-items:center; gap:24px; }
      .hd-search-wrapper { position:relative; width:40px; height:40px; }
      .hd-search-container {
        position:absolute; right:0; top:0; z-index:100;
        display:flex; align-items:center; height:40px; width:40px;
        border-radius:20px; border:1.5px solid transparent; background:transparent;
        transition:all 0.3s cubic-bezier(0.4,0,0.2,1); overflow:hidden;
      }
      .hd-search-container.active { width:260px; border-color:#d1d5da; background:#fff; box-shadow:0 4px 12px rgba(0,0,0,0.08); }
      .hd-search-container.active:focus-within { border-color:var(--blue); }
      .hd-search-input {
        width:0; opacity:0; border:none; background:transparent;
        font-size:15px; color:var(--navy); padding:0; pointer-events:none;
        transition:opacity 0.2s; flex-grow:1;
      }
      .hd-search-container.active .hd-search-input { width:100%; opacity:1; padding:0 0 0 16px; pointer-events:auto; }
      .hd-search-input:focus { outline:none; }
      .hd-search-btn {
        background:none; border:none; cursor:pointer; display:flex; align-items:center; justify-content:center;
        width:40px; height:40px; flex-shrink:0; transition:color .2s; padding:0;
      }
      .hd-search-btn:hover svg { stroke:var(--blue); }
      .hd-lang { position:relative; display:flex; align-items:center; gap:6px; cursor:pointer; color:#666; transition:color .2s; padding:10px 0; }
      .hd-lang:hover { color:var(--blue); }
      .hd-lang:hover svg { stroke:var(--blue); }
      .hd-lang-text { font-size:16px; font-weight:600; margin-left:2px; }
      .hd-lang-arrow { margin-top:2px; transition:transform 0.2s; }
      .hd-lang:hover .hd-lang-arrow { transform:rotate(180deg); }
      .hd-lang-menu {
        position:absolute; top:100%; right:-10px; background:#fff; border:1px solid var(--line); border-radius:8px; 
        padding:8px 0; min-width:80px; box-shadow:0 8px 24px rgba(0,0,0,0.12);
        opacity:0; visibility:hidden; transform:translateY(8px);
        transition:all 0.2s; display:flex; flex-direction:column; z-index:200;
      }
      .hd-lang:hover .hd-lang-menu { opacity:1; visibility:visible; transform:translateY(0); }
      .hd-lang-menu a { padding:8px 20px; font-size:15px; font-weight:600; color:var(--muted); transition:background .2s,color .2s; text-align:center; }
      .hd-lang-menu a:hover { background:rgba(0,94,184,.08); color:var(--blue); }
      .hd-cta { padding:10px 22px; font-size:16px; border-radius:8px; font-weight:700; }
    `;
    document.head.appendChild(s);
  }
}

/* ─ DROPDOWN MANAGER ────────────────────────────── */
function initNavbarDropdowns() {
  const items = document.querySelectorAll('.nav-item');
  items.forEach(item => {
    const link = item.querySelector('.nav-link');
    const menu = item.querySelector('.drop-menu');
    if (!menu || !link) return;

    let timeoutId = null;

    const showMenu = () => {
      clearTimeout(timeoutId);
      // Close all other active menus first
      items.forEach(otherItem => {
        if (otherItem !== item) {
          const otherLink = otherItem.querySelector('.nav-link');
          const otherMenu = otherItem.querySelector('.drop-menu');
          if (otherLink) otherLink.classList.remove('active');
          if (otherMenu) otherMenu.classList.remove('active');
        }
      });
      link.classList.add('active');
      menu.classList.add('active');
    };

    const hideMenu = () => {
      timeoutId = setTimeout(() => {
        link.classList.remove('active');
        menu.classList.remove('active');
      }, 250); // 250ms buffer to prevent accidental closes
    };

    item.addEventListener('mouseenter', showMenu);
    item.addEventListener('mouseleave', hideMenu);
  });
}

/* ─ FOOTER ──────────────────────────────────────── */
function buildFooter() {
  const root = getRoot();
  const footer = document.getElementById('site-footer');
  if (!footer) return;

  footer.innerHTML = `
    <div class="wrap">
      <div style="display:grid;grid-template-columns:160px 1fr;gap:56px;padding-bottom:32px;border-bottom:1px solid #e4e8f0;align-items:start">

        <!-- LEFT: Logo image centered -->
        <div style="display:flex;justify-content:center;align-items:center;padding-top:12px;min-height:120px">
          <img src="${root}LOGO3.png" alt="Senao" style="height:90px;display:block">
        </div>

        <!-- RIGHT: 6 nav columns uniform grid -->
        <div style="display:grid;grid-template-columns:repeat(6,1fr);gap:20px">
          ${NAV.map(sec => `
            <div>
              <h4 style="font-size:16px;font-weight:700;color:#005EB8;margin-bottom:18px">${sec.label}</h4>
              <ul style="list-style:none">
                ${sec.children.map(c =>
                  `<li style="margin-bottom:12px"><a href="${root}${c.href}" style="font-size:14px;color:#2a3550;line-height:1.5;transition:color .2s" onmouseover="this.style.color='#005EB8'" onmouseout="this.style.color='#2a3550'">${c.label}</a></li>`
                ).join('')}
              </ul>
            </div>`).join('')}
        </div>

      </div>
      <div style="padding-top:24px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px">
        <p style="font-size:13px;color:#9aa3b5">© 2026 Senao Networks Inc. All rights reserved.</p>
        <p style="font-size:13px;color:#9aa3b5">Taiwan · USA · Japan · India</p>
      </div>
    </div>`;
}

/* ─ FADE-UP OBSERVER ────────────────────────────── */
function initFadeUp() {
  const io = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) { e.target.classList.add('visible'); io.unobserve(e.target); }
    });
  }, { threshold: 0.1 });
  document.querySelectorAll('.fu').forEach(el => io.observe(el));
}

/* ─ HERO VIDEO CAROUSEL ──────────────────────── */
function initHeroCarousel() {
  const vids = document.querySelectorAll('.bg-vid');
  if (vids.length === 0) return;
  let cur = 0;
  setInterval(() => {
    vids[cur].classList.remove('active');
    let next = (cur + 1) % vids.length;
    vids[next].classList.add('active');
    vids[next].play().catch(()=>{});
    cur = next;
  }, 4000);
}

/* ─ SOLUTION CAROUSEL ────────────────────────────── */
function initSolutionCarousel() {
  const track = document.getElementById('solution-track');
  const prev = document.getElementById('sol-prev');
  const next = document.getElementById('sol-next');
  if (!track || !prev || !next) return;
  
  const scrollAmt = 320; // approximate width of one card + gap
  
  prev.addEventListener('click', () => {
    track.scrollBy({ left: -scrollAmt, behavior: 'smooth' });
  });
  
  next.addEventListener('click', () => {
    track.scrollBy({ left: scrollAmt, behavior: 'smooth' });
  });
}

// Close search if clicked outside
document.addEventListener('click', function(e) {
  const searchContainer = document.getElementById('hdSearch');
  if (searchContainer && searchContainer.classList.contains('active')) {
    if (!searchContainer.contains(e.target)) {
      searchContainer.classList.remove('active');
    }
  }
});

/* ─ INIT ────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  buildHeader();
  buildFooter();
  initNavbarDropdowns();
  initFadeUp();
  if (typeof initHeroCarousel === 'function') initHeroCarousel();
  initSolutionCarousel();
});
