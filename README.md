<!DOCTYPE html><html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Otto Borst • GitHub Profile</title>
  <meta name="description" content="Portfolio moderno y visual para GitHub Pages con Viazy e iShop." />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    /* Paleta iShop */
    :root{
      --turq:#1EC6B1;   /* primario */
      --coral:#FF6B6B;  /* secundario */
      --amber:#FFC93C;  /* acento */
      --gray:#F4F4F4;   /* fondo claro */
      --navy:#1B1F3B;   /* fondo oscuro */
      --bg: var(--navy);
      --text:#F7F8FA;
      --muted: #BFD7FF;
      --card: rgba(255,255,255,.06);
      --ring: var(--amber);
      --shadow: 0 10px 30px rgba(0,0,0,.45);
    }
    [data-theme="light"]{
      --bg: var(--gray);
      --text:#0f1a2b;
      --muted:#42526e;
      --card:#ffffff;
      --shadow: 0 12px 26px rgba(0,0,0,.12);
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0; font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Cantarell,Arial; color:var(--text);
      background:
        radial-gradient(1000px 600px at 90% -10%, color-mix(in oklab, var(--turq) 18%, transparent), transparent 60%),
        radial-gradient(900px 600px at -10% 110%, color-mix(in oklab, var(--coral) 16%, transparent), transparent 60%),
        var(--bg);
      line-height:1.6; letter-spacing:.1px;
    }
    a{color:inherit; text-decoration:none}
    .container{width:min(1100px,92%); margin-inline:auto}/* Nav */
.nav{position:sticky; top:0; z-index:10; backdrop-filter:blur(10px); background:linear-gradient(to bottom, rgba(0,0,0,.25), transparent)}
.nav-inner{display:flex; align-items:center; justify-content:space-between; padding:14px 0}
.brand{display:flex; gap:10px; align-items:center; font-weight:800; letter-spacing:.3px}
.logo{width:36px; height:36px; border-radius:12px; display:grid; place-items:center; background:linear-gradient(135deg,var(--turq),var(--coral)); box-shadow:var(--shadow)}

/* Buttons & chips */
.btn{display:inline-flex; align-items:center; gap:10px; padding:12px 16px; border-radius:14px; font-weight:700; border:1px solid transparent; box-shadow:var(--shadow)}
.btn.primary{background:linear-gradient(135deg, var(--turq), var(--coral)); color:#07121a}
.btn.ghost{background:transparent; color:var(--text); border-color: color-mix(in oklab, var(--text) 25%, transparent)}
.chip{padding:7px 12px; border-radius:999px; background:color-mix(in oklab, var(--card) 70%, transparent); border:1px solid color-mix(in oklab, var(--text) 14%, transparent); font-size:.92rem}

/* Cards */
.card{background:linear-gradient(180deg, color-mix(in oklab, var(--card) 92%, transparent), color-mix(in oklab, #000 12%, transparent)); border:1px solid color-mix(in oklab, var(--text) 12%, transparent); border-radius:18px; box-shadow:var(--shadow)}

/* Hero */
.hero{display:grid; grid-template-columns: 1.2fr .8fr; gap:28px; align-items:center; padding:70px 0 36px}
@media (max-width:900px){.hero{grid-template-columns:1fr; padding:48px 0 12px}}
.badge{display:inline-flex; gap:8px; align-items:center; padding:8px 12px; border:1px dashed color-mix(in oklab, var(--text) 20%, transparent); border-radius:999px; font-size:.9rem; color:var(--muted)}
.title{font-size:clamp(2rem, 4vw, 3.2rem); line-height:1.15; margin:14px 0 10px}
.subtitle{color:var(--muted); font-size:1.05rem}

/* Skills marquee */
.ticker{overflow:hidden; mask:linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent)}
.row{display:flex; gap:12px; animation:slide 18s linear infinite}
.row .chip{background:rgba(255,255,255,.06)}
@keyframes slide{to{transform:translateX(-50%)}}

/* Sections */
section{padding:44px 0}
.section-head{display:flex; align-items:end; justify-content:space-between; margin-bottom:18px}
.section-title{font-size:1.5rem}
.section-desc{color:var(--muted)}

/* Grid */
.grid{display:grid; gap:18px}
.grid-3{grid-template-columns: repeat(3, 1fr)}
@media (max-width:1000px){.grid-3{grid-template-columns: repeat(2, 1fr)}}
@media (max-width:640px){.grid-3{grid-template-columns: 1fr}}

/* Project */
.project{overflow:hidden; transition:transform .25s ease}
.project:hover{transform:translateY(-4px)}
.banner{aspect-ratio:16/9; border-radius:14px; display:grid; place-items:center; border:1px solid color-mix(in oklab, var(--text) 10%, transparent); background:linear-gradient(135deg, color-mix(in oklab, var(--turq) 20%, transparent), color-mix(in oklab, var(--coral) 20%, transparent))}
.project h3{margin:12px 0 6px}
.project p{margin:0; color:var(--muted)}

/* Timeline */
.timeline{position:relative}
.timeline::before{content:""; position:absolute; left:12px; top:0; bottom:0; width:2px; background:color-mix(in oklab, var(--text) 14%, transparent)}
.titem{position:relative; margin-left:34px; padding:12px 12px 12px 18px}
.titem::before{content:""; position:absolute; left:-25px; top:16px; width:12px; height:12px; border-radius:50%; background:linear-gradient(135deg,var(--turq),var(--coral)); border:2px solid var(--bg)}

/* Footer */
footer{padding:28px 0 54px; color:var(--muted); font-size:.95rem}
.footer-links{display:flex; gap:12px; flex-wrap:wrap}

/* Inputs */
.input{width:100%; padding:12px 14px; border-radius:12px; border:1px solid color-mix(in oklab, var(--text) 18%, transparent); background:color-mix(in oklab, var(--card) 94%, transparent); color:var(--text); outline:none}
.input:focus{box-shadow:0 0 0 4px color-mix(in oklab, var(--ring) 25%, transparent); border-color:var(--ring)}

.theme-toggle{border:1px solid color-mix(in oklab, var(--text) 25%, transparent); background:transparent; color:inherit; border-radius:12px; padding:10px 12px; cursor:pointer}

  </style>
</head>
<body>
  <header class="nav">
    <div class="container nav-inner">
      <div class="brand">
        <div class="logo" aria-hidden="true">🛠️</div>
        <span>Otto Borst</span>
      </div>
      <nav>
        <a class="btn primary" href="#proyectos">Proyectos</a>
        <a class="btn ghost" href="#contacto">Contacto</a>
        <button class="theme-toggle" aria-label="Cambiar tema" id="themeToggle">🌓</button>
      </nav>
    </div>
  </header>  <main class="container">
    <!-- HERO -->
    <section class="hero">
      <div>
        <span class="badge">👋 Hola, soy <strong>&nbsp;Otto</strong> — Full‑Stack • Flutter • JS</span>
        <h1 class="title">Creo productos rápidos, accesibles y con buen diseño.</h1>
        <p class="subtitle">Actualmente construyendo <strong>Viazy</strong> (transporte con QR y mapas en tiempo real) y co‑desarrollando <strong>iShop</strong> (e‑commerce móvil) usando la paleta corporativa.</p>
        <div style="display:flex; gap:12px; flex-wrap:wrap; margin-top:18px">
          <a class="btn primary" href="https://github.com/" target="_blank" rel="noopener">⭐ Ver mi GitHub</a>
          <a class="btn ghost" href="mailto:tu.email@ejemplo.com">Escríbeme</a>
        </div>
        <div class="ticker" style="margin-top:18px">
          <div class="row">
            <span class="chip">Flutter</span>
            <span class="chip">Dart</span>
            <span class="chip">JavaScript</span>
            <span class="chip">TypeScript</span>
            <span class="chip">Node.js</span>
            <span class="chip">PHP</span>
            <span class="chip">MySQL</span>
            <span class="chip">Firebase</span>
            <span class="chip">Git</span>
            <!-- Duplicado para loop suave -->
            <span class="chip">Flutter</span>
            <span class="chip">Dart</span>
            <span class="chip">JavaScript</span>
            <span class="chip">TypeScript</span>
            <span class="chip">Node.js</span>
            <span class="chip">PHP</span>
            <span class="chip">MySQL</span>
            <span class="chip">Firebase</span>
            <span class="chip">Git</span>
          </div>
        </div>
      </div>
      <aside class="card" style="padding:18px">
        <h3 style="margin:0 0 8px">Logros rápidos</h3>
        <ul style="margin:0; padding-left:18px; color:var(--muted)">
          <li>+5 proyectos móviles publicados</li>
          <li>CI/CD con GitHub Actions</li>
          <li>Arquitectura limpia y pruebas</li>
        </ul>
        <div style="margin-top:12px; display:flex; gap:8px; flex-wrap:wrap">
          <span class="chip">Open Source</span>
          <span class="chip">UX First</span>
          <span class="chip">Performance</span>
        </div>
      </aside>
    </section><!-- PROYECTOS -->
<section id="proyectos">
  <div class="section-head">
    <div>
      <h2 class="section-title">Proyectos destacados</h2>
      <p class="section-desc">Código limpio, documentación y foco en UX.</p>
    </div>
  </div>
  <div class="grid grid-3">
    <!-- Viazy -->
    <article class="project card" style="padding:12px">
      <div class="banner" aria-hidden="true">🚌</div>
      <div style="padding:12px 6px 6px">
        <h3>Viazy — App de transporte</h3>
        <p>Boletos interlocales con QR único, rutas interurbanas en vivo y agente virtual.</p>
        <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:10px">
          <span class="chip">Flutter</span>
          <span class="chip">Firebase</span>
          <span class="chip">Map SDK</span>
        </div>
      </div>
    </article>
    <!-- iShop -->
    <article class="project card" style="padding:12px">
      <div class="banner" aria-hidden="true">🛍️</div>
      <div style="padding:12px 6px 6px">
        <h3>iShop — E‑commerce móvil <span style="font-size:.9rem; opacity:.75">(en desarrollo)</span></h3>
        <p>Arquitectura limpia, consumo de APIs, estado con Riverpod y UI accesible en la paleta iShop.</p>
        <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:10px">
          <span class="chip">Flutter</span>
          <span class="chip">REST</span>
          <span class="chip">Riverpod</span>
        </div>
        <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:10px">
          <a class="chip" href="#" aria-label="Repositorio iShop (temporal)">Repositorio (temp)</a>
          <a class="chip" href="#" aria-label="Roadmap iShop (temporal)">Roadmap (temp)</a>
        </div>
      </div>
    </article>
    <!-- WalletSegura -->
    <article class="project card" style="padding:12px">
      <div class="banner" aria-hidden="true">💳</div>
      <div style="padding:12px 6px 6px">
        <h3>WalletSegura — Pago con custodia</h3>
        <p>Prototipo con liberación condicionada tras confirmación de entrega. Node.js • PostgreSQL.</p>
        <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:10px">
          <span class="chip">Node.js</span>
          <span class="chip">NestJS</span>
          <span class="chip">PostgreSQL</span>
        </div>
      </div>
    </article>
  </div>
</section>

<!-- EXPERIENCIA -->
<section id="experiencia">
  <div class="section-head">
    <div>
      <h2 class="section-title">Experiencia</h2>
      <p class="section-desc">Una mezcla de producto, código y comunidad.</p>
    </div>
  </div>
  <div class="card" style="padding:8px 8px 6px">
    <div class="timeline">
      <div class="titem">
        <h4>Founder & Dev — Viazy <span style="opacity:.7; font-weight:500">(2025 — Presente)</span></h4>
        <p style="color:var(--muted); margin:0">Arquitectura, DevOps y publicación con mapas en vivo.</p>
      </div>
      <div class="titem">
        <h4>Desarrollador Mobile — Freelance <span style="opacity:.7; font-weight:500">(2023 — 2025)</span></h4>
        <p style="color:var(--muted); margin:0">Apps Flutter multilenguaje, pasarelas de pago y BaaS.</p>
      </div>
      <div class="titem">
        <h4>Full‑Stack — Proyectos académicos <span style="opacity:.7; font-weight:500">(2019 — 2023)</span></h4>
        <p style="color:var(--muted); margin:0">APIs REST, SQL y despliegue en VPS/Cloud.</p>
      </div>
    </div>
  </div>
</section>

<!-- CONTACTO -->
<section id="contacto">
  <div class="section-head">
    <div>
      <h2 class="section-title">Contacto</h2>
      <p class="section-desc">¿Construimos algo juntos? Estoy disponible para colaborar.</p>
    </div>
  </div>
  <div class="card" style="padding:18px">
    <form class="grid" style="grid-template-columns:1fr 1fr; gap:14px" onsubmit="event.preventDefault(); alert('¡Gracias! Te responderé pronto.');">
      <label>
        <span class="sr-only">Nombre</span>
        <input aria-label="Nombre" required placeholder="Tu nombre" class="input" />
      </label>
      <label>
        <span class="sr-only">Email</span>
        <input aria-label="Email" required placeholder="tu@email.com" type="email" class="input" />
      </label>
      <label style="grid-column:1/-1">
        <span class="sr-only">Mensaje</span>
        <textarea aria-label="Mensaje" required placeholder="Cuéntame tu idea…" class="input" rows="4"></textarea>
      </label>
      <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap">
        <button class="btn primary" type="submit">Enviar</button>
        <a class="btn ghost" download href="#">Descargar CV (PDF)</a>
        <a class="btn ghost" href="https://www.linkedin.com/" target="_blank" rel="noopener">LinkedIn</a>
        <a class="btn ghost" href="https://x.com/" target="_blank" rel="noopener">X/Twitter</a>
      </div>
    </form>
  </div>
</section>

  </main>  <footer class="container" role="contentinfo">
    <div class="footer-links">
      <a href="https://github.com/" target="_blank" rel="noopener">GitHub</a>•
      <a href="#">Política de privacidad</a>•
      <a href="#">Términos</a>
    </div>
    <div style="margin-top:6px">© <span id="y"></span> Otto Borst. Construido con HTML.
    </div>
  </footer>  <style>.sr-only{position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); white-space:nowrap; border:0}</style>  <script>
    // Año
    document.getElementById('y').textContent = new Date().getFullYear();
    // Tema
    const root = document.documentElement; const btn = document.getElementById('themeToggle');
    const saved = localStorage.getItem('theme'); if(saved){root.setAttribute('data-theme', saved)}
    btn.addEventListener('click', ()=>{ const next = root.getAttribute('data-theme') === 'light' ? 'dark' : 'light'; root.setAttribute('data-theme', next); localStorage.setItem('theme', next)});
    if(!saved){ root.setAttribute('data-theme', window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark'); }
  </script></body>
</html>
