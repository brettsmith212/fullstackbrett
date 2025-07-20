# Terminal Blog

A terminal-style blog built with Hugo, Webtui CSS, and Catppuccin theme.

## Quick Start

### Start the development server
```bash
hugo server
```
Visit http://localhost:1313 to view your blog.

### Create new content

**Blog post (organized by date):**
```bash
hugo new blog/2025/07/my-post-title/index.md
```

**TIL entry:**
```bash
hugo new til/2025/07/what-i-learned.md
```

### Content workflow
1. Create new content using commands above
2. Edit the markdown file in `content/blog/` or `content/til/`
3. Set `draft: false` when ready to publish
4. Or use `hugo server --buildDrafts` to preview drafts

### Build for production
```bash
hugo --minify
```
Output will be in the `public/` directory.

## Development Workflow

### 1. Initial Setup
```bash
# Clone the repository
git clone <repository-url>
cd terminal-blog

# Verify Hugo installation
hugo version
```

### 2. Start Development Server
```bash
# Start server with live reload
hugo server --bind 0.0.0.0 --port 1313

# Include draft content during development
hugo server --buildDrafts
```

### 3. Content Creation Process
```bash
# Create new blog post (organized by date folders)
hugo new blog/2025/07/post-name/index.md

# Create new TIL entry
hugo new til/2025/07/til-name.md
```

### 4. Content Development Cycle
1. **Write** - Edit your markdown files in `content/blog/` or `content/til/`
2. **Preview** - Check changes at http://localhost:1313 (auto-refreshes)
3. **Publish** - Set `draft: false` in frontmatter when ready
4. **Build** - Run `hugo --cleanDestinationDir` if content doesn't appear

### 5. Testing Your Changes
```bash
# Clean rebuild (fixes missing content issues)
hugo --cleanDestinationDir

# Build without starting server
hugo

# Build with minification for production
hugo --minify
```

### 6. Production Deployment
```bash
# Final build
hugo --cleanDestinationDir --minify

# Deploy contents of public/ directory
```

### 7. Key Commands Reference
- `hugo server` - Start development server
- `hugo new blog/YYYY/MM/post-name/index.md` - Create new blog post
- `hugo new til/YYYY/MM/til-name.md` - Create new TIL entry
- `hugo --cleanDestinationDir` - Clean rebuild
- `hugo --buildDrafts` - Include draft content
- `hugo --minify` - Minified production build

## Working with Images

### Adding Images to Blog Posts

For blog posts using the `index.md` structure, place images in the same folder:

```
content/blog/2025/07/my-post/
├── index.md
└── my-image.jpg
```

**In your markdown, use absolute paths:**
```markdown
<img src="/blog/2025/07/my-post/my-image.jpg" alt="Description" style="width: 300px; height: auto;">
```

**Why absolute paths?** This ensures images display correctly in:
- Individual post pages
- Homepage preview cards
- Blog listing pages

## Features
- Terminal-style UI with ASCII box borders
- Unified homepage feed combining blog posts and TIL entries
- Automatic code block and image styling
- Responsive design with Catppuccin color scheme
