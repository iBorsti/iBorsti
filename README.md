<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Portfolio • Otto Borst</title>
  <meta name="description" content="Portfolio moderno, minimalista y responsive para GitHub Pages." />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    :root{
      --bg: #1B1F3B;
      --panel: rgba(255,255,255,0.06);
      --text: #F4F4F4;
      --muted:#FFC93C;
      --acc1: #1EC6B1;
      --acc2: #FF6B6B;
      --ring: #FFC93C;
      --card:#0f1320;
      --shadow: 0 10px 30px rgba(0,0,0,.35);
    }
    [data-theme="light"]{
      --bg:#F4F4F4; --panel: rgba(18,18,18,0.06); --text:#1B1F3B; --muted:#475569; --acc1:#1EC6B1; --acc2:#FF6B6B; --ring:#FFC93C; --card:#ffffff; --shadow: 0 10px 25px rgba(0,0,0,.08);
    }
    *{box-sizing:border-box}
    body{
      margin:0; font-family:Inter,system-ui, sans-serif;
      background: var(--bg);
      color:var(--text);
    }
    a{color:inherit; text-decoration:none}
    .container{width:min(1100px, 92%); margin-inline:auto}
    .btn{
      border:1px solid transparent; background:linear-gradient(135deg, var(--acc1), var(--acc2));
      color:#fff; font-weight:700; padding:12px 16px; border-radius:14px; box-shadow:var(--shadow)
    }
    .btn.secondary{background:transparent; color:var(--text); border-color: var(--muted)}
    .chip{padding:8px 12px; border-radius:999px; background:var(--panel); border:1px solid var(--muted); color:var(--muted)}
    .card{background:var(--card); border-radius:18px; box-shadow:var(--shadow)}
  </style>
</head>
<body>
  <main class="container">
    <section class="hero">
      <div>
        <span>👋 Hola, soy Otto — Full‑Stack • Flutter • JS</span>
        <h1>Construyo productos digitales rápidos y atractivos</h1>
        <p>Me enfoco en experiencias móviles y web con rendimiento real, arquitectura limpia y buen diseño. Aquí verás mi trabajo, incluyendo <strong>Viazy</strong> e <strong>iShop</strong>.</p>
        <div class="cta">
          <a class="btn" href="https://github.com/" target="_blank">⭐ Ver mi GitHub</a>
          <a class="btn secondary" href="mailto:tu.email@ejemplo.com">Escríbeme</a>
        </div>
      </div>
    </section>

    <section id="proyectos">
      <h2>Proyectos destacados</h2>
      <div class="grid grid-3">
        <article class="project card">
          <div>
            <h3>Viazy — App de transporte</h3>
            <p>Venta de boletos interlocales con QR, rutas interurbanas en vivo y soporte virtual.</p>
            <div class="skill-badges">
              <span class="chip">Flutter</span>
              <span class="chip">Firebase</span>
              <span class="chip">Map SDK</span>
            </div>
          </div>
        </article>
        <article class="project card">
          <div>
            <h3>iShop — E‑commerce móvil</h3>
            <p>Plataforma de compras con arquitectura limpia, APIs, estado con Riverpod y diseño accesible usando la paleta corporativa.</p>
            <div class="skill-badges">
              <span class="chip">Flutter</span>
              <span class="chip">REST</span>
              <span class="chip">Riverpod</span>
            </div>
          </div>
        </article>
      </div>
    </section>
  </main>
</body>
</html>
