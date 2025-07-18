# Implementation Plan

## Prerequisites and Installation
- [x] Step 0: Install Dependencies and Set Up Environment
  - **Task**: Install Hugo and prepare the development environment
  - **Description**: Ensure Hugo is installed (extended version recommended for asset processing). Webtui requires no installation as it's a CSS library linked via CDN. Verify setup before proceeding. Define CSS layers for proper precedence and include the Catppuccin theme for consistent terminal styling.
  - **Files**: None
  - **Step Dependencies**: None
  - **Agent Instructions**: 
    - For Arch Linux (Hyprland): Run `sudo pacman -Syu hugo` to install the latest Hugo (v0.148.1 as of July 2025). Verify with `hugo version`.
    - For other systems: Follow https://gohugo.io/installation/ (e.g., `brew install hugo` on macOS).
    - Download a monospace font like JetBrains Mono if needed for terminal styling, and ensure it's loaded (e.g., via Google Fonts or local).
    - No install for Webtui; use CDN: https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css.
    - For Catppuccin theme, use CDN: https://cdn.jsdelivr.net/npm/@webtui/theme-catppuccin@latest/index.css.

## Foundation Setup
- [x] Step 1: Initialize Repository and Basic Structure
  - **Task**: Set up Git repository, create Hugo site structure, and configure basic settings
  - **Description**: Establish the foundation for the terminal blog by initializing version control and creating the basic Hugo site structure with Webtui and Catppuccin theme integration, including proper theming and ASCII box usage for card-like structures.
  - **Files**: 
    - `.gitignore`: Add Hugo build directories (e.g., `/public`, `/resources`)
    - `config.toml`: Update with menu structure including TIL section
    - `content/blog/`: Create blog content directory
    - `content/til/`: Create Today I Learned content directory
    - `layouts/partials/head.html`: Include Webtui CSS and Catppuccin theme, define layers, custom styles for headers
    - `layouts/_default/baseof.html`: Base template skeleton with body styling for terminal background and data-webtui-theme attribute
  - **Step Dependencies**: Step 0
  - **Agent Instructions**: 
    - Run `git init` in the project directory.
    - Create Hugo site: `hugo new site my-terminal-blog --force` (if directory exists).
    - Update `config.toml`:
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
          name = "TIL"
          url = "/til/"
          weight = 3
        [[menu.main]]
          name = "About"
          url = "/about/"
          weight = 4
      ```
    - Create `layouts/partials/head.html` for Webtui with layers and Catppuccin theme:
      ```html
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{{ .Title }} | {{ .Site.Title }}</title>
        <style>
          @layer base, utils, components;
        </style>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/theme-catppuccin@latest/index.css">
        <style>
          :root {
            --font-family: "JetBrainsMono", monospace;
            --box-border-color: var(--foreground0);
            --box-rounded-radius: 4px;
            --box-border-width: 1px;
            --box-double-border-width: 2px;
          }
          .header {
            display: flex;
            justify-content: space-between;
            background-color: var(--background0);
            padding: 0 1ch;
          }
          .header span {
            background-color: var(--background0);
            padding: 0 1ch;
          }
        </style>
      </head>
      ```
    - Create `layouts/_default/baseof.html`:
      ```html
      <!DOCTYPE html>
      <html lang="{{ .Site.LanguageCode }}" data-webtui-theme="catppuccin-mocha">
        {{ partial "head.html" . }}
        <body style="background-color: var(--background0); color: var(--foreground0); font-family: var(--font-family); padding: 1rem; margin: 0;">
          {{ partial "header.html" . }}
          <main>
            {{ block "main" . }}{{ end }}
          </main>
          {{ partial "footer.html" . }}
        </body>
      </html>
      ```
    - Create directories: `mkdir -p content/blog content/til`

- [x] Step 2: Create Content Archetypes
  - **Task**: Set up content templates for rapid blog post and TIL creation
  - **Description**: Create archetype templates to standardize frontmatter and structure for both blog posts and TIL entries, enabling quick content creation with consistent metadata
  - **Files**:
    - `archetypes/blog.md`: Template for blog posts with title, date, draft status, and tags
    - `archetypes/til.md`: Template for TIL entries with simplified frontmatter and TIL flag
  - **Step Dependencies**: Step 1
  - **Agent Instructions**: Create archetype files.
    - `archetypes/blog.md`:
      ```markdown
      ---
      title: "{{ replace .Name "-" " " | title }}"
      date: {{ .Date }}
      draft: true
      tags: []
      ---
      ```
    - `archetypes/til.md`:
      ```markdown
      ---
      title: "{{ replace .Name "-" " " | title }}"
      date: {{ .Date }}
      til: true
      tags: []
      ---
      ```

## Content Rendering Enhancement
- [x] Step 3: Implement Markdown Render Hooks
  - **Task**: Create custom render hooks for code blocks and images to automatically apply Webtui styling
  - **Description**: Replace default Hugo markdown rendering with custom templates that automatically wrap code blocks and images in Webtui components, ensuring consistent terminal styling without manual HTML in markdown. Use ASCII boxes for borders.
  - **Files**:
    - `layouts/_default/_markup/render-codeblock.html`: Style code blocks with Webtui pre component, large size, and double square borders
    - `layouts/_default/_markup/render-image.html`: Wrap images in rounded ASCII boxes with optional captions
  - **Step Dependencies**: Step 1
  - **Agent Instructions**: Create render hooks.
    - `render-codeblock.html`:
      ```html
      <pre size-="large" box-="double square" style="--pre-background: var(--background1); --box-border-color: var(--foreground1);">
        <code class="language-{{ .Type }}">{{ trim .Text "\n" }}</code>
      </pre>
      ```
    - `render-image.html`:
      ```html
      <div box-="round" style="--box-border-color: var(--foreground2);">
        <img src="{{ .Destination }}" alt="{{ .Text }}" />
        {{ if .Title }}<p>{{ .Title }}</p>{{ end }}
      </div>
      ```

## Section-Specific Templates
- [x] Step 4: Create TIL Section Templates
  - **Task**: Implement specialized templates for Today I Learned content display
  - **Description**: Create list and single page templates specifically for TIL entries that present them in a concise, scannable format appropriate for short learning items, using ASCII boxes for card-like structures around each entry.
  - **Files**:
    - `layouts/til/list.html`: List view for TIL entries with each entry in an ASCII box card
    - `layouts/til/single.html`: Single TIL entry view with smaller heading, concise layout, and double border box
    - `layouts/partials/header.html`: Header with navigation, wrapped in box
    - `layouts/partials/footer.html`: Footer with badge, wrapped in box
  - **Step Dependencies**: Step 1, Step 2
  - **Agent Instructions**: Create TIL templates and partials. Use shear-="top" for overlaying titles on boxes. Use badge variants that align with Catppuccin theme (e.g., info, secondary).
    - `layouts/til/list.html`:
      ```html
      {{ define "main" }}
        <div box-="double round" style="--box-border-color: var(--foreground0);">
          <h2>Today I Learned</h2>
          {{ range .Pages }}
            <div box-="round" shear-="top" style="--box-border-color: var(--foreground2);">
              <div class="header">
                <span><a href="{{ .Permalink }}">{{ .Title }}</a></span>
                <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
              </div>
              <p>{{ .Summary }}</p>
            </div>
          {{ end }}
        </div>
      {{ end }}
      ```
    - `layouts/til/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double round" shear-="top" style="--box-border-color: var(--foreground0);">
          <div class="header">
            <span><h3>{{ .Title }}</h3></span>  <!-- Smaller heading for TIL -->
            <span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span>
          </div>
          {{ .Content }}
        </article>
      {{ end }}
      ```
    - Add `header.html` and `footer.html` as per foundational guide examples, but wrap in box-="square" for terminal frame. For example, in header.html:
      ```html
      <header box-="square">
        <nav>
          {{ range .Site.Menus.main }}
            <a href="{{ .URL }}">{{ .Name }}</a>
          {{ end }}
        </nav>
      </header>
      ```
    - Similarly for footer.html with a badge.

- [x] Step 5: Enhance Blog Templates
  - **Task**: Refine existing blog templates based on foundation
  - **Description**: Update and enhance the blog list and single page templates to ensure they properly integrate with the unified feed system and maintain consistent Webtui styling, using ASCII boxes for each post card.
  - **Files**:
    - `layouts/blog/list.html`: Enhanced blog post listing with each post in an ASCII box card
    - `layouts/blog/single.html`: Refined single blog post template with shear for title
  - **Step Dependencies**: Step 3
  - **Agent Instructions**: Create or enhance blog templates. Use shear-="top" for headers.
    - `layouts/blog/list.html`:
      ```html
      {{ define "main" }}
        <div box-="double round" style="--box-border-color: var(--foreground0);">
          <h2>Blog Posts</h2>
          {{ range .Pages }}
            <div box-="round" shear-="top" style="--box-border-color: var(--foreground2);">
              <div class="header">
                <span><a href="{{ .Permalink }}">{{ .Title }}</a></span>
                <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
              </div>
              <p>{{ .Summary }}</p>
            </div>
          {{ end }}
        </div>
      {{ end }}
      ```
    - `layouts/blog/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double round" shear-="top" style="--box-border-color: var(--foreground0);">
          <div class="header">
            <span><h1>{{ .Title }}</h1></span>
            <span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span>
          </div>
          {{ .Content }}
        </article>
      {{ end }}
      ```

## Unified Feed Implementation
- [ ] Step 6: Create Unified Running Feed
  - **Task**: Implement homepage template that combines blog posts and TIL entries in chronological order
  - **Description**: Create a unified feed that aggregates content from both blog and TIL sections, displaying them in reverse chronological order with clear visual distinction between content types, using individual ASCII box cards for each entry.
  - **Files**:
    - `layouts/index.html`: Homepage template that queries both blog and TIL sections and displays unified feed with boxed cards
  - **Step Dependencies**: Step 4, Step 5
  - **Agent Instructions**: Create `index.html`. Use shear-="top" for card titles.
    ```html
    {{ define "main" }}
      <div box-="double round" style="--box-border-color: var(--foreground0);">
        <h2>Recent Updates</h2>
        {{ $pages := union (where .Site.Pages "Section" "blog") (where .Site.Pages "Section" "til") }}
        {{ $pages = $pages.ByDate.Reverse }}
        <ul>
          {{ range first 10 $pages }}
            <li box-="round" shear-="top" style="--box-border-color: var(--foreground2);">
              <div class="header">
                <span><a href="{{ .Permalink }}">{{ .Title }}</a></span>
                {{ if eq .Section "til" }}
                  <span is-="badge" variant-="warning">TIL</span>
                {{ else }}
                  <span is-="badge" variant-="primary">Blog</span>
                {{ end }}
                <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
              </div>
              {{ if eq .Section "blog" }}<p>{{ .Summary }}</p>{{ end }}
            </li>
          {{ end }}
        </ul>
      </div>
    {{ end }}
    ```

## Optional Enhancements
- [ ] Step 7: Create Content Shortcodes
  - **Task**: Develop reusable shortcodes for common Webtui components
  - **Description**: Create Hugo shortcodes that make it easy to add terminal-styled elements like boxes, badges, and other Webtui components directly in markdown content, including variants for ASCII boxes.
  - **Files**:
    - `layouts/shortcodes/divbox.html`: Shortcode for wrapping content in Webtui ASCII boxes with variant support
    - `layouts/shortcodes/terminal-badge.html`: Shortcode for adding styled badges with correct variants
  - **Step Dependencies**: Step 6
  - **Agent Instructions**: Create shortcodes. Use box- variants and shear if specified.
    - `divbox.html`:
      ```html
      <div box-="{{ .Get "type" | default "square" }}" shear-="{{ .Get "shear" | default "" }}">
        {{ .Inner }}
      </div>
      ```
      Usage: `{{< divbox type="round" >}}Content{{< /divbox >}}`
    - `terminal-badge.html`:
      ```html
      <span is-="badge" variant-="{{ .Get "variant" | default "info" }}">{{ .Inner }}</span>
      ```
      Usage: `{{< terminal-badge variant="success" >}}Text{{< /terminal-badge >}}`

## Deployment and Automation
- [ ] Step 8: Set Up Build and Deployment
  - **Task**: Configure automated build and deployment pipeline
  - **Description**: Set up GitHub Actions workflow for automatic building and deployment of the Hugo site when changes are pushed to the repository
  - **Files**:
    - `.github/workflows/hugo.yml`: GitHub Actions workflow for building and deploying Hugo site
  - **Step Dependencies**: Step 6
  - **Agent Instructions**: Create `hugo.yml`:
    ```yaml
    name: Deploy Hugo site to Pages

    on:
      push:
        branches: [ main ]
      workflow_dispatch:

    permissions:
      contents: read
      pages: write
      id-token: write

    concurrency:
      group: "pages"
      cancel-in-progress: false

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v4
          - name: Setup Hugo
            uses: peaceiris/actions-hugo@v3
            with:
              hugo-version: '0.148.1'
              extended: true
          - name: Build
            run: hugo --minify
          - name: Upload artifact
            uses: actions/upload-pages-artifact@v3
            with:
              path: ./public

      deploy:
        environment:
          name: github-pages
          url: ${{ steps.deployment.outputs.page_url }}
        runs-on: ubuntu-latest
        needs: build
        steps:
          - name: Deploy to GitHub Pages
            id: deployment
            uses: actions/deploy-pages@v4
    ```

## Testing and Verification
- [ ] Step 9: Content Testing and Verification
  - **Task**: Create sample content and verify all features work correctly
  - **Description**: Generate sample blog posts and TIL entries to test all templates, render hooks, and the unified feed functionality
  - **Files**:
    - `content/blog/sample-post.md`: Sample blog post with code snippets and images
    - `content/til/sample-learning.md`: Sample TIL entry
    - `content/til/another-learning.md`: Additional TIL entry for feed testing
  - **Step Dependencies**: Step 6
  - **Agent Instructions**: Create sample content using archetypes (e.g., `hugo new blog/sample-post.md`), add markdown with code, images, tables. Run `hugo server` and verify styling, feed, and responsiveness.

## Documentation and Workflow
- [ ] Step 10: Create Author Guidelines
  - **Task**: Document the content creation workflow and best practices
  - **Description**: Create documentation that explains how to add new blog posts and TIL entries, use shortcodes, and follow content conventions
  - **Files**:
    - `AUTHORING.md`: Guide for creating content, using archetypes, and following conventions
  - **Step Dependencies**: Step 9
  - **Agent Instructions**: Create `AUTHORING.md` with sections on: Installing Hugo, Creating content (`hugo new blog/post.md`), Using shortcodes, Best practices for Webtui styling, Deployment notes.