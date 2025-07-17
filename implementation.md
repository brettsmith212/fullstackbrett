# Implementation Plan

## Prerequisites and Installation
- [x] Step 0: Install Dependencies and Set Up Environment
  - **Task**: Install Hugo and prepare the development environment
  - **Description**: Ensure Hugo is installed (extended version recommended for asset processing). Webtui requires no installation as it's a CSS library linked via CDN. Verify setup before proceeding.
  - **Files**: None
  - **Step Dependencies**: None
  - **Agent Instructions**: 
    - For Arch Linux (Hyprland): Run `sudo pacman -Syu hugo` to install the latest Hugo (v0.148.1 as of July 2025). Verify with `hugo version`.
    - For other systems: Follow https://gohugo.io/installation/ (e.g., `brew install hugo` on macOS).
    - Download a monospace font like JetBrains Mono if needed for terminal styling.
    - No install for Webtui; use CDN: https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css.

## Foundation Setup
- [ ] Step 1: Initialize Repository and Basic Structure
  - **Task**: Set up Git repository, create Hugo site structure, and configure basic settings
  - **Description**: Establish the foundation for the terminal blog by initializing version control and creating the basic Hugo site structure with Webtui integration
  - **Files**: 
    - `.gitignore`: Add Hugo build directories (e.g., `/public`, `/resources`)
    - `config.toml`: Update with menu structure including TIL section
    - `content/blog/`: Create blog content directory
    - `content/til/`: Create Today I Learned content directory
    - `layouts/partials/head.html`: Include Webtui CSS
    - `layouts/_default/baseof.html`: Base template skeleton
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
    - Create `layouts/partials/head.html` for Webtui:
      ```html
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{{ .Title }} | {{ .Site.Title }}</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css">
        <style>
          :root {
            --font-family: "JetBrainsMono", monospace;
            --background0: #000;
            --foreground0: #00ff00;
          }
        </style>
      </head>
      ```
    - Create `layouts/_default/baseof.html`:
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
    - Create directories: `mkdir -p content/blog content/til`

- [ ] Step 2: Create Content Archetypes
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
- [ ] Step 3: Implement Markdown Render Hooks
  - **Task**: Create custom render hooks for code blocks and images to automatically apply Webtui styling
  - **Description**: Replace default Hugo markdown rendering with custom templates that automatically wrap code blocks and images in Webtui components, ensuring consistent terminal styling without manual HTML in markdown
  - **Files**:
    - `layouts/_default/_markup/render-codeblock.html`: Style code blocks with Webtui pre component and square borders
    - `layouts/_default/_markup/render-image.html`: Wrap images in rounded boxes with optional captions
  - **Step Dependencies**: Step 1
  - **Agent Instructions**: Create render hooks.
    - `render-codeblock.html`:
      ```html
      <pre size-="large" box-="square" style="--pre-background: var(--background1);">
        <code class="language-{{ .Type }}">{{ trim .Text "\n" }}</code>
      </pre>
      ```
    - `render-image.html`:
      ```html
      <div box-="round">
        <img src="{{ .Destination }}" alt="{{ .Text }}" />
        {{ if .Title }}<p>{{ .Title }}</p>{{ end }}
      </div>
      ```

## Section-Specific Templates
- [ ] Step 4: Create TIL Section Templates
  - **Task**: Implement specialized templates for Today I Learned content display
  - **Description**: Create list and single page templates specifically for TIL entries that present them in a concise, scannable format appropriate for short learning items
  - **Files**:
    - `layouts/til/list.html`: List view for TIL entries with compact tile layout
    - `layouts/til/single.html`: Single TIL entry view with smaller heading and concise layout
    - `layouts/partials/header.html`: Header with navigation
    - `layouts/partials/footer.html`: Footer with badge
  - **Step Dependencies**: Step 1, Step 2
  - **Agent Instructions**: Create TIL templates and partials.
    - `layouts/til/list.html`:
      ```html
      {{ define "main" }}
        <div box-="round">
          <h2>Today I Learned</h2>
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
    - `layouts/til/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double">
          <h3>{{ .Title }}</h3>  <!-- Smaller heading for TIL -->
          <p><span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span></p>
          {{ .Content }}
        </article>
      {{ end }}
      ```
    - Add `header.html` and `footer.html` as per foundational guide examples.

- [ ] Step 5: Enhance Blog Templates
  - **Task**: Refine existing blog templates based on foundation
  - **Description**: Update and enhance the blog list and single page templates to ensure they properly integrate with the unified feed system and maintain consistent Webtui styling
  - **Files**:
    - `layouts/blog/list.html`: Enhanced blog post listing with improved styling
    - `layouts/blog/single.html`: Refined single blog post template
  - **Step Dependencies**: Step 3
  - **Agent Instructions**: Create or enhance blog templates.
    - `layouts/blog/list.html`:
      ```html
      {{ define "main" }}
        <div box-="round">
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
    - `layouts/blog/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double">
          <h1>{{ .Title }}</h1>
          <p><span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span></p>
          {{ .Content }}
        </article>
      {{ end }}
      ```

## Unified Feed Implementation
- [ ] Step 6: Create Unified Running Feed
  - **Task**: Implement homepage template that combines blog posts and TIL entries in chronological order
  - **Description**: Create a unified feed that aggregates content from both blog and TIL sections, displaying them in reverse chronological order with clear visual distinction between content types
  - **Files**:
    - `layouts/index.html`: Homepage template that queries both blog and TIL sections and displays unified feed
  - **Step Dependencies**: Step 4, Step 5
  - **Agent Instructions**: Create `index.html`:
    ```html
    {{ define "main" }}
      <div box-="round">
        <h2>Recent Updates</h2>
        {{ $pages := union .Site.RegularPages.ByDate.Reverse (where .Site.Pages "Section" "blog") (where .Site.Pages "Section" "til") }}
        {{ $pages = $pages.ByDate.Reverse }}
        <ul>
          {{ range first 10 $pages }}
            <li>
              <a href="{{ .Permalink }}">{{ .Title }}</a>
              {{ if eq .Section "til" }}
                <span is-="badge" variant-="warning">TIL</span>
              {{ else }}
                <span is-="badge" variant-="primary">Blog</span>
              {{ end }}
              <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
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
  - **Description**: Create Hugo shortcodes that make it easy to add terminal-styled elements like boxes, badges, and other Webtui components directly in markdown content
  - **Files**:
    - `layouts/shortcodes/divbox.html`: Shortcode for wrapping content in Webtui boxes
    - `layouts/shortcodes/terminal-badge.html`: Shortcode for adding styled badges
  - **Step Dependencies**: Step 6
  - **Agent Instructions**: Create shortcodes.
    - `divbox.html`:
      ```html
      <div box-="{{ .Get "type" | default "square" }}">
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


  # Implementation Plan

## Prerequisites and Installation
- [ ] Step 0: Install Dependencies and Set Up Environment
  - **Task**: Install Hugo and prepare the development environment
  - **Description**: Ensure Hugo is installed (extended version recommended for asset processing). Webtui requires no installation as it's a CSS library linked via CDN. Verify setup before proceeding.
  - **Files**: None
  - **Step Dependencies**: None
  - **Agent Instructions**: 
    - For Arch Linux (Hyprland): Run `sudo pacman -Syu hugo` to install the latest Hugo (v0.148.1 as of July 2025). Verify with `hugo version`.
    - For other systems: Follow https://gohugo.io/installation/ (e.g., `brew install hugo` on macOS).
    - Download a monospace font like JetBrains Mono if needed for terminal styling.
    - No install for Webtui; use CDN: https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css.

## Foundation Setup
- [ ] Step 1: Initialize Repository and Basic Structure
  - **Task**: Set up Git repository, create Hugo site structure, and configure basic settings
  - **Description**: Establish the foundation for the terminal blog by initializing version control and creating the basic Hugo site structure with Webtui integration
  - **Files**: 
    - `.gitignore`: Add Hugo build directories (e.g., `/public`, `/resources`)
    - `config.toml`: Update with menu structure including TIL section
    - `content/blog/`: Create blog content directory
    - `content/til/`: Create Today I Learned content directory
    - `layouts/partials/head.html`: Include Webtui CSS
    - `layouts/_default/baseof.html`: Base template skeleton
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
    - Create `layouts/partials/head.html` for Webtui:
      ```html
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{{ .Title }} | {{ .Site.Title }}</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@webtui/css@0.1.3/dist/full.css">
        <style>
          :root {
            --font-family: "JetBrainsMono", monospace;
            --background0: #000;
            --foreground0: #00ff00;
          }
        </style>
      </head>
      ```
    - Create `layouts/_default/baseof.html`:
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
    - Create directories: `mkdir -p content/blog content/til`

- [ ] Step 2: Create Content Archetypes
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
- [ ] Step 3: Implement Markdown Render Hooks
  - **Task**: Create custom render hooks for code blocks and images to automatically apply Webtui styling
  - **Description**: Replace default Hugo markdown rendering with custom templates that automatically wrap code blocks and images in Webtui components, ensuring consistent terminal styling without manual HTML in markdown
  - **Files**:
    - `layouts/_default/_markup/render-codeblock.html`: Style code blocks with Webtui pre component and square borders
    - `layouts/_default/_markup/render-image.html`: Wrap images in rounded boxes with optional captions
  - **Step Dependencies**: Step 1
  - **Agent Instructions**: Create render hooks.
    - `render-codeblock.html`:
      ```html
      <pre size-="large" box-="square" style="--pre-background: var(--background1);">
        <code class="language-{{ .Type }}">{{ trim .Text "\n" }}</code>
      </pre>
      ```
    - `render-image.html`:
      ```html
      <div box-="round">
        <img src="{{ .Destination }}" alt="{{ .Text }}" />
        {{ if .Title }}<p>{{ .Title }}</p>{{ end }}
      </div>
      ```

## Section-Specific Templates
- [ ] Step 4: Create TIL Section Templates
  - **Task**: Implement specialized templates for Today I Learned content display
  - **Description**: Create list and single page templates specifically for TIL entries that present them in a concise, scannable format appropriate for short learning items
  - **Files**:
    - `layouts/til/list.html`: List view for TIL entries with compact tile layout
    - `layouts/til/single.html`: Single TIL entry view with smaller heading and concise layout
    - `layouts/partials/header.html`: Header with navigation
    - `layouts/partials/footer.html`: Footer with badge
  - **Step Dependencies**: Step 1, Step 2
  - **Agent Instructions**: Create TIL templates and partials.
    - `layouts/til/list.html`:
      ```html
      {{ define "main" }}
        <div box-="round">
          <h2>Today I Learned</h2>
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
    - `layouts/til/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double">
          <h3>{{ .Title }}</h3>  <!-- Smaller heading for TIL -->
          <p><span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span></p>
          {{ .Content }}
        </article>
      {{ end }}
      ```
    - Add `header.html` and `footer.html` as per foundational guide examples.

- [ ] Step 5: Enhance Blog Templates
  - **Task**: Refine existing blog templates based on foundation
  - **Description**: Update and enhance the blog list and single page templates to ensure they properly integrate with the unified feed system and maintain consistent Webtui styling
  - **Files**:
    - `layouts/blog/list.html`: Enhanced blog post listing with improved styling
    - `layouts/blog/single.html`: Refined single blog post template
  - **Step Dependencies**: Step 3
  - **Agent Instructions**: Create or enhance blog templates.
    - `layouts/blog/list.html`:
      ```html
      {{ define "main" }}
        <div box-="round">
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
    - `layouts/blog/single.html`:
      ```html
      {{ define "main" }}
        <article box-="double">
          <h1>{{ .Title }}</h1>
          <p><span is-="badge" variant-="secondary">{{ .Date.Format "2006-01-02" }}</span></p>
          {{ .Content }}
        </article>
      {{ end }}
      ```

## Unified Feed Implementation
- [ ] Step 6: Create Unified Running Feed
  - **Task**: Implement homepage template that combines blog posts and TIL entries in chronological order
  - **Description**: Create a unified feed that aggregates content from both blog and TIL sections, displaying them in reverse chronological order with clear visual distinction between content types
  - **Files**:
    - `layouts/index.html`: Homepage template that queries both blog and TIL sections and displays unified feed
  - **Step Dependencies**: Step 4, Step 5
  - **Agent Instructions**: Create `index.html`:
    ```html
    {{ define "main" }}
      <div box-="round">
        <h2>Recent Updates</h2>
        {{ $pages := union .Site.RegularPages.ByDate.Reverse (where .Site.Pages "Section" "blog") (where .Site.Pages "Section" "til") }}
        {{ $pages = $pages.ByDate.Reverse }}
        <ul>
          {{ range first 10 $pages }}
            <li>
              <a href="{{ .Permalink }}">{{ .Title }}</a>
              {{ if eq .Section "til" }}
                <span is-="badge" variant-="warning">TIL</span>
              {{ else }}
                <span is-="badge" variant-="primary">Blog</span>
              {{ end }}
              <span is-="badge" variant-="info">{{ .Date.Format "2006-01-02" }}</span>
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
  - **Description**: Create Hugo shortcodes that make it easy to add terminal-styled elements like boxes, badges, and other Webtui components directly in markdown content
  - **Files**:
    - `layouts/shortcodes/divbox.html`: Shortcode for wrapping content in Webtui boxes
    - `layouts/shortcodes/terminal-badge.html`: Shortcode for adding styled badges
  - **Step Dependencies**: Step 6
  - **Agent Instructions**: Create shortcodes.
    - `divbox.html`:
      ```html
      <div box-="{{ .Get "type" | default "square" }}">
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