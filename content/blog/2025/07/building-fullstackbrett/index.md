---
title: "Building FullStackBrett"
date: 2025-07-20T16:37:50-07:00
draft: false
tags: []
---

Hey there! I've been meaning to do this for a while. Create a personal site for a blog, that is. I have had multiple false starts over the years. Hopefully this isn't a continuation of the pattern. What has motivated me is a desire to have better notes about the things I am learning. It is a crazy time in the life of software engineers with AI sweeping across the industry. I want to have a low stakes place to record my thoughts, and in the process maybe provide someone else with a few useful ideas too.

I stumbled across [ironclad](https://x.com/IroncladDev) post about a new CSS library called [webtui](https://webtui.ironclad.sh/). It is a really incredible library that makes your site look like a TUI. As you can obviously tell, I used it on my site. Seeing that library inspired me to make a TUI themed blog site.

<img src="/blog/2025/07/building-fullstackbrett/webtui.png" alt="WebTui" style="width: 2000px; height: auto;">


## The Vision: A Simple, Nostalgic Blog with TIL Goodness
I've always loved the simplicity of terminal interfaces. Clean lines, monospace fonts, and a focus on content over clutter. My goal was to create a blog that feels like hacking away in a shell, complete with ASCII box borders and a responsive design that works on any device.

For now I want to have it divided into two main sections:

- **Blog**: For longer-form posts like this one, organized by date.
- **Today I Learned (TIL)**: Quick notes on cool tricks, code snippets, or concepts I pick up regularly. This is my personal knowledge base, making it easy to revisit things I've learned without digging through notebooks or scattered files.

I took inspiration from [Simon Willison's Blog](https://simonwillison.net/) by having a *Recently Updated* feed section. I think that is a nice touch to scroll posts and ideas easily, like a social media feed.

## Tools of the Trade: Hugo and WebTui
At the core, the site is built with [Hugo](https://gohugo.io/), a fast static site generator that converts Markdown files into HTML. It's perfect for blogs because it's lightweight, themeable, and blazingly quick—no databases or server-side rendering needed.

Like I said earlier, for the visual flair I integrated [WebTui CSS](https://webtui.ironclad.sh/).

## The AI-Powered Build Process: Grok and Amp to the Rescue
Here's where things got really exciting: I didn't do most of the heavy lifting myself. I used AI agents to accelerate the development.

I started with **Grok 4** (from xAI), which I used to get a deeper understanding of how to use Hugo with a custom CSS styling framework like WebTui. These aren't the most mainstream tools, so finding comprehensive guides can be hit-or-miss. I asked Grok for detailed documentation—step-by-step setup, best practices for content organization, and tips on integrating CSS libraries like WebTui. It generated a solid reference doc that covered everything from installing Hugo to customizing themes. This was crucial because it gave me (and the next agent) enough context to hit the ground running.

<img src="/blog/2025/07/building-fullstackbrett/grok_1.png" alt="Grok Prompt" style="width: 600px; height: auto; display: block; margin: 1.5rem auto;">

Then, I handed things over to **Amp**, which built the bulk of the site. Amp as usual did a great job generating code, tweaking configs, and using the Playwright MCP to preview the site in real-time. I'd describe what I wanted, like "Add a TIL section with date-based folders and merge it into the homepage feed," and Amp would iterate on it. I found many times needing to use *"the oracle"*, which is Amp's subagent that utilizes the OpenAI o3 model, rather than the default Claude 4 model. The oracle was very good at finding issues and uncomplicating code that Claude wrote.

The process was iterative. I'd review Amp's changes, provide feedback, and let it refine. Grok's docs ensured Amp understood the nuances of Hugo's frontmatter, shortcodes, and WebTui's classes. In the end, this combo saved me tons of time and made learning these techs feel effortless.


## Getting Hands-On: Quick Guide to using Hugo

### Initial Setup
```bash
brew install hugo
hugo version  # Ensure Hugo is installed
```

### Dev Server for Live Previews
```bash
hugo server --buildDrafts
```
Head to http://localhost:1313 to see changes auto-reload.

### Adding Content
For a blog post:
```bash
hugo new blog/2025/07/my-post-title/index.md
```

For a TIL:
```bash
hugo new til/2025/07/what-i-learned.md
```

Edit the files in `content/`, set `draft: false` when ready, and build with `hugo --minify` for production.

Images? Drop them in the post's folder and reference with absolute paths for seamless display everywhere.

## The Future

I am planning to post more thoughts to this site, and especially try to share some useful nuggets I discover on the **TIL** feed. Hope you come back to visit from time to time and find something useful!