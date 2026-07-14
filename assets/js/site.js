/* ── site.js — shared header & footer injection ── */

/* ─ NAV CONFIG ─────────────────────────────────── */
const NAV = [
  {
    label: 'About', href: 'pages/about/index.html',
    children: [
      { label: 'About Senao Computing', href: 'pages/about/about-senao-computing/index.html', image: 'pages/about/buildings.jpeg' },
      { label: 'Global Presence',       href: 'pages/about/global-presence/index.html',       image: 'pages/about/buildings.jpeg' },
      { label: 'Certification',         href: 'pages/about/certification/index.html',         image: 'pages/about/buildings.jpeg' },
      { label: 'ESG',                   href: 'pages/about/esg/index.html',                   image: 'pages/about/buildings.jpeg' },
    ]
  },
  {
    label: 'Solution', href: 'pages/solution/index.html',
    children: [
      {
        label: 'Server',
        href: 'pages/solution/server/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'SR610', href: 'pages/solution/server/sr610/index.html' },
          { label: 'SR710', href: 'pages/solution/server/sr710/index.html' },
          { label: 'SR810', href: 'pages/solution/server/sr810/index.html' }
        ]
      },
      {
        label: 'Edge Server',
        href: 'pages/solution/edge-server/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'SE110', href: 'pages/solution/edge-server/se110/index.html' },
          { label: 'SE210', href: 'pages/solution/edge-server/se210/index.html' }
        ]
      },
      {
        label: 'SmartNIC',
        href: 'pages/solution/smartnic/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'SX904', href: 'pages/solution/smartnic/sx904/index.html' },
          { label: 'SX906', href: 'pages/solution/smartnic/sx906/index.html' }
        ]
      },
      {
        label: 'Data Center Switch',
        href: 'pages/solution/data-center-switch/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'SND Series', href: 'pages/solution/data-center-switch/snd-series/index.html' }
        ]
      },
      {
        label: 'Edge Appliance',
        href: 'pages/solution/edge-appliance/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'SC9435B', href: 'pages/solution/edge-appliance/sc9435b/index.html' },
          { label: 'SA9832b', href: 'pages/solution/edge-appliance/sa9832b/index.html' },
          { label: 'Edge SCM', href: 'pages/solution/edge-appliance/edge-scm/index.html' }
        ]
      },
      {
        label: 'COM Express',
        href: 'pages/solution/com-express/index.html',
        image: 'pages/solution/solution.jpg',
        items: [
          { label: 'COM7000', href: 'pages/solution/com-express/com7000/index.html' },
          { label: 'CME5100', href: 'pages/solution/com-express/cme5100/index.html' }
        ]
      }
    ]
  },
  {
    label: 'AI Hub', href: 'pages/ai-hub/index.html',
    children: [
      { label: 'RAXEL AI', href: 'pages/ai-hub/raxel-ai/index.html', image: 'pages/ai-hub/raxel-ai/raxel.jpg' },
    ]
  },
  {
    label: 'Services', href: 'pages/services/index.html',
    children: [
      { label: 'Laboratory',   href: 'pages/services/laboratory/index.html',   image: 'pages/services/jpg/services.jpg' },
      { label: 'Technology',   href: 'pages/services/technology/index.html',   image: 'pages/services/jpg/services.jpg' },
      { label: 'Manufacturing',href: 'pages/services/manufacturing/index.html', image: 'pages/services/jpg/services.jpg' },
    ]
  },
  {
    label: 'News', href: 'pages/news/index.html',
    children: [
      { label: 'News',   href: 'pages/news/news/index.html',   image: 'pages/news/news.jpg' },
      { label: 'Events', href: 'pages/news/events/index.html', image: 'pages/news/news.jpg' },
      { label: 'Blog',   href: 'pages/news/blog/index.html',   image: 'pages/news/news.jpg' },
    ]
  },
  {
    label: 'Support', href: 'pages/support/index.html',
    children: [
      { label: 'Downloads', href: 'pages/support/downloads/index.html', image: 'pages/support/support.jpg' },
      { label: 'FAQ',       href: 'pages/support/faq/index.html',       image: 'pages/support/support.jpg' },
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

  // Inject fonts: Roboto (body) + Open Sans (alternate) + Manrope (headings)
  if (!document.getElementById('outfit-font')) {
    const link = document.createElement('link');
    link.id = 'outfit-font';
    link.rel = 'stylesheet';
    link.href = 'https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@400;600;700&family=Manrope:wght@500;600;700;800&family=Noto+Sans+TC:wght@400;700;800&display=swap';
    document.head.appendChild(link);
  }

  const navHTML = NAV.map(item => {
    const defaultChild = item.children && item.children[0] ? item.children[0] : { label: item.label, href: item.href };
    const dropHTML = item.children ? item.children.map((c, idx) => {
      const itemsAttr = c.items ? ` data-items='${JSON.stringify(c.items)}'` : '';
      const imageAttr = c.image ? ` data-image="${root}${c.image}"` : '';
      return `<a class="mega-menu-link${idx === 0 ? ' active' : ''}" data-href="${root}${c.href}" data-label="${c.label}"${itemsAttr}${imageAttr}>${c.label}</a>`;
    }).join('') : '';

    let rightContent = '';
    let placeholderStyle = '';
    if (defaultChild.items) {
      const pillsHTML = defaultChild.items.map(sub =>
        `<a href="${root}${sub.href}" class="mega-pill-btn">${sub.label}</a>`
      ).join('');
      rightContent = `
        <div class="mega-pills-container">
          <div class="mega-pills-title">${defaultChild.label}</div>
          <div class="mega-pills-grid">${pillsHTML}</div>
        </div>`;
      if (defaultChild.image) {
        placeholderStyle = `background-image:url('${root}${defaultChild.image}');background-size:cover;background-position:center;background-color:#111;`;
      }
    } else {
      if (defaultChild.image) {
        placeholderStyle = `background-image:url('${root}${defaultChild.image}');background-size:cover;background-position:center;background-color:#111;`;
      }
      rightContent = `
        <a href="${root}${defaultChild.href}" class="mega-featured-link">
          <span class="mega-featured-title">${defaultChild.label} &rsaquo;</span>
        </a>`;
    }

    return `
      <li class="nav-item">
        <a class="nav-link" href="${root}${item.href}">${item.label}</a>
        ${item.children && item.children.length > 0 ? `
        <div class="drop-menu">
          <div class="drop-menu-inner mega-menu-grid">
            <div class="mega-menu-left">
              ${dropHTML}
            </div>
            <div class="mega-menu-right">
              <div class="mega-image-placeholder" style="${placeholderStyle}">
                ${rightContent}
              </div>
            </div>
          </div>
        </div>
        ` : ''}
      </li>`;
  }).join('');

  header.innerHTML = `
    <div class="wrap hd-inner">
      <a class="hd-logo" href="${root}index.html">
        <img src="${root}assets/img/LOGO6.png" alt="Senao Computing" style="height:46px; display:block;">
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
      .hd-inner { display:flex; align-items:center; width:100%; padding-top:0; padding-bottom:0; height:72px; position:relative; }
      .hd-logo { display:flex; align-items:center; margin-left:-90px; }
      .hd-nav { margin-left:auto; margin-right:56px; }
      .nav-list { list-style:none; display:flex; gap:28px; }
      .nav-item { position:static; }
      .nav-link {
        display:flex;
        align-items:center;
        height:72px;
        font-size:16px;
        font-weight:700;
        color:var(--navy);
        transition:color .2s;
        cursor:pointer;
        position: relative;
      }
      .nav-link::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background-color: var(--blue);
        transform: scaleX(0);
        transition: transform 0.2s ease;
      }
      .nav-link:hover::after, .nav-link.active::after {
        transform: scaleX(1);
      }
      .nav-link:hover, .nav-link.active { color:var(--blue); }
      .drop-menu {
        opacity: 0;
        visibility: hidden;
        transform: translateX(-50%) translateY(8px);
        transition: opacity 0.25s cubic-bezier(0.4,0,0.2,1), transform 0.25s cubic-bezier(0.4,0,0.2,1), visibility 0.25s;
        position: absolute;
        top: 100%;
        left: 50%;
        padding-top: 12px;
        z-index: 200;
        pointer-events: none;
      }
      .drop-menu.active {
        opacity: 1;
        visibility: visible;
        transform: translateX(-50%) translateY(0);
        pointer-events: auto;
      }
      .mega-menu-grid {
        display: grid;
        grid-template-columns: 260px 380px;
        min-height: 340px;
        background: #fff;
        border-radius: 0;
        box-shadow: 0 16px 48px rgba(0,30,80,.16);
        overflow: hidden;
        border: 1px solid #e4e8f0;
      }
      .mega-menu-left {
        padding: 16px;
        display: flex;
        flex-direction: column;
        gap: 2px;
        background: #fff;
      }
      .mega-menu-link {
        display: block;
        padding: 10px 14px;
        font-size: 15px;
        font-weight: 500;
        color: #4a5568;
        border-radius: 8px;
        transition: all .2s ease;
        text-decoration: none;
        text-align: left;
        cursor: default;
      }
      .mega-menu-link:hover, .mega-menu-link.active {
        background: rgba(0, 94, 184, 0.06);
        color: #005EB8;
        font-weight: 600;
      }
      .mega-menu-right {
        background: #f1f5f9;
        padding: 12px;
        display: flex;
        align-items: stretch;
      }
      .mega-image-placeholder {
        flex: 1;
        background: #cccccc;
        border-radius: 0;
        display: flex;
        align-items: flex-start;
        justify-content: flex-start;
        padding: 20px;
        position: relative;
        overflow: hidden;
        transition: filter 0.2s ease;
      }
      .mega-image-placeholder::after {
        content: '';
        position: absolute;
        inset: 0;
        background: linear-gradient(to bottom, rgba(0,0,0,0.60) 0%, transparent 60%);
        pointer-events: none;
        z-index: 1;
      }
      .mega-image-placeholder:hover {
        filter: brightness(0.88);
      }
      .mega-featured-link {
        color: #ffffff;
        font-size: 18px;
        font-weight: 700;
        text-decoration: none;
        position: relative;
        z-index: 2;
        width: 100%;
        text-align: left;
        text-shadow: 0 2px 4px rgba(0,0,0,0.3);
      }
      .mega-featured-link:hover {
        color: #e0f2fe;
      }
      .mega-pills-container {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 16px;
        position: relative;
        z-index: 2;
      }
      .mega-pills-title {
        font-size: 15px;
        font-weight: 800;
        color: #ffffff;
        text-transform: uppercase;
        letter-spacing: .05em;
        border-bottom: 1.5px solid rgba(255,255,255,0.35);
        padding-bottom: 8px;
        text-align: left;
        text-shadow: 0 1px 3px rgba(0,0,0,0.4);
      }
      .mega-pills-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
      }
      .mega-pill-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 6px 14px;
        background: #ffffff;
        border: 1px solid #d1d5da;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 700;
        color: #0b1e38;
        text-decoration: none;
        transition: all 0.2s ease;
        box-shadow: 0 2px 4px rgba(0,0,0,0.04);
      }
      .mega-pill-btn:hover {
        border-color: var(--blue);
        color: var(--blue);
        box-shadow: 0 4px 8px rgba(0,94,184,0.12);
        transform: translateY(-1px);
      }
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
  const root = getRoot();
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

    // Interactive Hover on Left Links to Update Right Details
    const leftLinks = menu.querySelectorAll('.mega-menu-link');
    leftLinks.forEach(leftLink => {
      leftLink.addEventListener('mouseenter', () => {
        leftLinks.forEach(l => l.classList.remove('active'));
        leftLink.classList.add('active');
        
        const itemsData = leftLink.getAttribute('data-items');
        const label = leftLink.getAttribute('data-label');
        const href = leftLink.getAttribute('data-href');
        const image = leftLink.getAttribute('data-image');
        
        const placeholder = menu.querySelector('.mega-image-placeholder');
        if (placeholder) {
          // Update background image
          if (image) {
            placeholder.style.backgroundImage = `url('${image}')`;
            placeholder.style.backgroundSize = 'cover';
            placeholder.style.backgroundPosition = 'center';
          } else {
            placeholder.style.backgroundImage = '';
            placeholder.style.backgroundColor = '#cccccc';
          }
          if (itemsData) {
            const subItems = JSON.parse(itemsData);
            const pillsHTML = subItems.map(sub =>
              `<a href="${root}${sub.href}" class="mega-pill-btn">${sub.label}</a>`
            ).join('');
            placeholder.innerHTML = `
              <div class="mega-pills-container">
                <div class="mega-pills-title">${label}</div>
                <div class="mega-pills-grid">${pillsHTML}</div>
              </div>`;
          } else {
            placeholder.innerHTML = `
              <a href="${href}" class="mega-featured-link">
                <span class="mega-featured-title">${label} &rsaquo;</span>
              </a>`;
          }
        }
      });
    });
  });
}

/* ─ FOOTER ──────────────────────────────────────── */
function buildFooter() {
  const root = getRoot();
  const footer = document.getElementById('site-footer');
  if (!footer) return;

  footer.innerHTML = `
    <div class="wrap">
      <div style="display:grid;grid-template-columns:220px 1fr;gap:56px;padding-bottom:32px;border-bottom:1px solid #e4e8f0;align-items:start">

        <!-- LEFT: Logo image centered -->
        <div style="display:flex;justify-content:center;align-items:center;padding-top:12px;min-height:120px">
          <a href="https://www.senaonetworks.com/en/" style="display:block;width:100%;">
            <img src="${root}LOGO3.png" alt="Senao Computing" style="width:100%;height:auto;display:block;">
          </a>
        </div>

        <!-- RIGHT: 6 nav columns uniform grid -->
        <div style="display:grid;grid-template-columns:repeat(6,1fr);gap:20px">
          ${NAV.map(sec => `
            <div>
              <h4 style="font-size:16px;font-weight:700;color:#005EB8;margin-bottom:18px">${sec.label}</h4>
              <ul style="list-style:none">
                ${sec.children.map(c =>
                  `<li style="padding-bottom:14px"><a href="${root}${c.href}" style="font-size:14px;color:#2a3550;line-height:1.65;display:block;white-space:nowrap;transition:color .2s" onmouseover="this.style.color='#005EB8'" onmouseout="this.style.color='#2a3550'">${c.label}</a></li>`
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
