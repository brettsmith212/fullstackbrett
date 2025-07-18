# Terminal Blog

A terminal-style blog built with Hugo, Webtui CSS, and Catppuccin theme.

## Quick Start

### Start the development server
```bash
hugo server
```
Visit http://localhost:1313 to view your blog.

### Create new content

**Blog post:**
```bash
hugo new blog/my-post-title.md
```

**TIL (Today I Learned) entry:**
```bash
hugo new til/what-i-learned.md
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

## Features
- Terminal-style UI with ASCII box borders
- Unified homepage feed combining blog posts and TIL entries
- Automatic code block and image styling
- Responsive design with Catppuccin color scheme
