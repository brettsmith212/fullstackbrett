# Hugo Terminal Blog - Agent Memory

## Project Overview
Terminal-styled blog using Hugo + Webtui CSS + Catppuccin theme. Supports blog posts and TIL (Today I Learned) entries.

## Key Commands
- **Dev server**: `hugo server --bind 0.0.0.0 --port 1313`
- **Build**: `hugo --cleanDestinationDir`
- **New blog post**: `hugo new blog/post-name.md`
- **New TIL**: `hugo new til/til-name.md`

## Critical Fixes Applied

### 1. Catppuccin Theme CDN
**Correct URL**: `https://cdn.jsdelivr.net/npm/@webtui/theme-catppuccin@latest/dist/index.css`
- Must include `/dist/` in path

### 2. Code Block Indentation Fix
**File**: `layouts/_default/_markup/render-codeblock.html`
```html
<pre size-="large" box-="double square" style="--pre-background: var(--background1); --box-border-color: var(--foreground1);"><code class="language-{{ .Type }}">{{ trim .Inner "\n" }}</code></pre>
```
- Keep `<code>` on same line as `<pre>` to prevent indentation

### 3. Paragraph Spacing CSS
**File**: `layouts/partials/head.html`
```css
/* Add proper spacing between elements */
article h1, article h2, article h3, article h4, article h5, article h6,
main h1, main h2, main h3, main h4, main h5, main h6 {
  margin-top: 1.5rem;
  margin-bottom: 0.5rem;
}
article p, main p { margin-bottom: 1rem; }
article pre, main pre { margin: 1rem 0; }
/* etc for ul, ol, blockquote, table */
```

### 4. Shearing Effect for Boxes
**Templates**: Use `shear-="top"` for post cards
```html
<div box-="round" shear-="top" style="--box-border-color: var(--foreground2);">
  <div class="header">
    <span><a href="{{ .Permalink }}">{{ .Title }}</a></span>
    <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
  </div>
</div>
```

**CSS for proper header overlay**:
```css
.header {
  display: flex;
  justify-content: space-between;
  padding: 0 1ch;
}
.header span {
  background-color: var(--background0);
  padding: 0 1ch;
}
```
- Header div has NO background color
- Only spans have background to allow border to show through

## Site Structure
- `content/blog/` - Blog posts
- `content/til/` - Today I Learned entries
- `layouts/index.html` - Unified feed homepage
- `layouts/blog/list.html` - Blog listing
- `layouts/til/list.html` - TIL listing
- `layouts/partials/head.html` - CSS and theme imports

## Webtui + Catppuccin Integration
- Uses `data-webtui-theme="catppuccin-mocha"` on `<html>` tag
- Box styling: `box-="round"`, `box-="double round"`
- Badges: `is-="badge" variant-="info|warning|primary|secondary"`

### Available Catppuccin CSS Variables
```css
/* Accent Colors */
--rosewater: #f5e0dc;
--flamingo: #f2cdcd;
--pink: #f5c2e7;
--mauve: #cba6f7;
--red: #f38ba8;
--maroon: #eba0ac;
--peach: #fab387;
--yellow: #f9e2af;
--green: #a6e3a1;
--teal: #94e2d5;
--sky: #89dceb;
--sapphire: #74c7ec;
--blue: #89b4fa;
--lavender: #b4befe;

/* Background / Foreground Colors */
--text: #cdd6f4;
--subtext1: #bac2de;
--subtext0: #a6adc8;
--overlay2: #9399b2;
--overlay1: #7f849c;
--overlay0: #6c7086;
--surface2: #585b70;
--surface1: #45475a;
--surface0: #313244;
--base: #1e1e2e;
--mantle: #181825;
--crust: #11111b;
```

**Usage Examples**:
- `color: var(--text)` - Main text color
- `background-color: var(--base)` - Main background
- `border-color: var(--surface0)` - Subtle borders
- `--box-border-color: var(--blue)` - Custom webtui box borders
- Accent colors for highlights: `--red`, `--green`, `--blue`, `--yellow`
- Surface hierarchy: `--base` (darkest) → `--surface0` → `--surface1` → `--surface2` (lightest backgrounds)

## Common Issues
1. **Missing posts in lists**: Run `hugo --cleanDestinationDir` to rebuild
2. **Broken shearing**: Check header CSS - spans need background, div doesn't
3. **Code indentation**: Ensure no whitespace in render-codeblock.html template
