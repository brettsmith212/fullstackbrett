# Building a Terminal-Styled Blog with Hugo and Webtui

This documentation serves as a foundational guide for integrating Hugo (a static site generator) with Webtui (a CSS library for terminal-like UI styling). Hugo handles content via Markdown files and generates static HTML using Go HTML templates. Webtui applies a retro terminal aesthetic through CSS attributes (e.g., `box-="square"` for borders, `variant-="primary"` for colors) and components (e.g., Button, Pre, Table). The integration is straightforward: link Webtui's CSS in Hugo's templates and apply its attributes to HTML elements for styling.

Webtui is framework-agnostic, requiring no JavaScript, which aligns perfectly with Hugo's static nature. Use Webtui's modular imports or full CSS for components like boxes, buttons, badges, typography, tables, and preformatted text. Customize via CSS variables (e.g., `--font-family`, `--background0`) for themes like green-on-black terminals.

## Prerequisites
- Install Hugo (extended version recommended):  
  ```bash
  # macOS (Homebrew)
  brew install hugo
  # Linux (snap)
  sudo snap install hugo --channel=extended
  hugo version  # Verify
  ```
- No installation needed for Webtui; use CDN or local file.

## Step 1: Create and Configure the Hugo Site
Create a new site:
```bash
hugo new site my-terminal-blog
cd my-terminal-blog
```

Edit `config.toml` for basics and menu:
```toml
baseURL = "http://localhost:1313/"
languageCode = "en-us"
title = "My Terminal Blog"

[menu]
  [[menu.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menu.main]]
    name = "Blog"
    url = "/blog/"
    weight = 2
  [[menu.main]]
    name = "About"
    url = "/about/"
    weight = 3
```

## Step 2: Include Webtui CSS
Webtui's CSS can be linked via CDN (full library for all components/utilities/themes). Create `layouts/partials/head.html`:
```html
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ .Title }} | {{ .Site.Title }}</title>
  <!-- Webtui full CSS (latest: v0.1.3 as of July 2025) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css">
  <!-- Optional custom overrides for terminal theme -->
  <style>
    :root {
      --font-family: "JetBrainsMono", monospace;  /* Monospace font */
      --background0: #000;  /* Black background */
      --foreground0: #00ff00;  /* Green text */
    }
  </style>
</head>
```

For local use: Download `full.css` to `static/css/webtui.css` and link as `<link rel="stylesheet" href="/css/webtui.css">`.

Optional: Add themes like Nord via `<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/theme-nord@0.1.3/dist/index.css">` after the main CSS.

## Step 3: Set Up Base Template
Create `layouts/_default/baseof.html` as the site skeleton:
```html
<!DOCTYPE html>
<html lang="{{ .Site.LanguageCode }}">
  {{ partial "head.html" . }}
  <body>
    {{ partial "header.html" . }}
    <main>
      {{ block "main" . }}{{ end }}
    </main>
    {{ partial "footer.html" . }}
  </body>
</html>
```

## Step 4: Header with Webtui Navigation
Use Webtui's Button component (`<button variant-="primary">`) and Box utility (`box-="double"`) for terminal borders. Create `layouts/partials/header.html`:
```html
<header box-="double">  <!-- Double-line border -->
  <h1>{{ .Site.Title }}</h1>
  <nav>
    {{ range .Site.Menus.main }}
      <button variant-="primary" size-="small">{{ .Name }}</button>  <!-- Styled button -->
    {{ end }}
  </nav>
</header>
```

Available Webtui attributes for buttons: `variant-` (primary, secondary, success, etc.), `size-` (small, medium, large).

## Step 5: Footer with Badge
Create `layouts/partials/footer.html` using Badge component (`is-="badge"`) and Box:
```html
<footer box-="square">  <!-- Square border -->
  <p>© {{ now.Year }} {{ .Site.Title }}</p>
  <span is-="badge" variant-="success">Powered by Hugo & Webtui</span>
</footer>
```

Badge variants: success, info, warning, danger, etc.

## Step 6: Blog Layouts
- List of posts (`layouts/_default/list.html`):
```html
{{ define "main" }}
  <div box-="round">  <!-- Rounded border -->
    <h2>Blog Posts</h2>
    <ul>
      {{ range .Pages }}
        <li>
          <a href="{{ .Permalink }}">{{ .Title }}</a>
          <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
        </li>
      {{ end }}
    </ul>
  </div>
{{ end }}
```

- Single post (`layouts/_default/single.html`):
```html
{{ define "main" }}
  <article box-="double">
    <h1>{{ .Title }}</h1>
    <p><span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span></p>
    {{ .Content }}  <!-- Markdown-rendered content -->
  </article>
{{ end }}
```

Box values: square, round, double, single, etc.

## Step 7: Add Content
Create Markdown posts:
```bash
hugo new blog/my-first-post.md
```
Edit `content/blog/my-first-post.md`:
```markdown
---
title: "My First Terminal Post"
date: 2025-07-16
---
This is terminal-styled content!

```python
print("Code snippet")
```

| Table | Example |
|-------|---------|
| Row1  | Data1   |

<image-card alt="Image" src="/path/to/image.jpg" ></image-card>
```

## Step 8: Build and Serve
```bash
hugo server  # Local preview: http://localhost:1313
hugo  # Build to /public/
```

## Handling Markdown Elements with Webtui
Webtui styles Markdown output (e.g., via Hugo's Blackfriday renderer) using components:

- **Code Snippets**: Uses Pre component for `<pre><code>`. Apply attributes like `size-="large"`.
  Example in template or Markdown HTML:
  ```html
  <pre size-="large" style="--pre-background: var(--background1);">
    console.log("Styled code");
  </pre>
  ```
  No syntax highlighting; add external JS if needed.

- **Images**: No dedicated styling; wrap in Box for borders.
  Example:
  ```html
  <div box-="double">
    <img src="/path/to/image.jpg" alt="Framed image">
  </div>
  ```

- **Tables**: Table component styles `<table>` with borders via `--table-border-color`.
  Example:
  ```html
  <table style="--table-border-color: var(--foreground2);">
    <thead><tr><th>Header</th></tr></thead>
    <tbody><tr><td>Data</td></tr></tbody>
  </table>
  ```

- **Lists**: Typography handles `<ul>/<ol>`. Use `marker-="tree"` for custom bullets.
  Example:
  ```html
  <ul marker-="tree open">
    <li>Item 1</li>
    <li>Item 2</li>
  </ul>
  ```

- **Headings/Paragraphs/Blockquotes**: Automatic monospace and spacing via Typography. Apply `is-="typography-block"` to wrappers.

## Available Webtui Components and Utilities
- **Box**: Borders (e.g., `box-="round"`).
- **Button**: Interactive styles (e.g., `variant-="success" size-="large"`).
- **Badge**: Labels (e.g., `is-="badge" variant-="info"`).
- **Typography**: Text elements; supports inline/block.
- **Pre**: Code blocks.
- **Table**: Grids with borders.
- **Other**: Input, Checkbox, Spinner (for future JS if added).
- **Utilities**: CSS layers for precedence; variables for themes (e.g., `--foreground0`).

## Customization Tips
- Enforce terminal feel with CSS vars in `head.html`.
- For advanced builds, use Hugo's asset pipeline: Create `assets/css/main.css` with `@import "@webtui/css";`, then process in templates: `{{ $css := resources.Get "css/main.css" | css.Build | minify | fingerprint }} <link rel="stylesheet" href="{{ $css.RelPermalink }}">`.
- Test for responsiveness; Webtui uses CSS layers and variables for easy overrides.
- Extend with Hugo shortcodes for reusable Webtui elements (e.g., `layouts/shortcodes/terminal-box.html`: `<div box-="double">{{ .Inner }}</div>`).

This setup provides a minimal, functional terminal blog. Expand by adding more layouts or content types.