---
title: "Repomix"
date: 2025-07-20T16:37:26-07:00
til: true
tags: []
---

I have been using RepoMix on and off for projects on Github, but I never knew they had a [CLI](https://repomix.com/#using-the-cli-tool) for it. It's extremely useful and easy to setup. I was using a custom python script but the repomix cli is much easier to work with.

There are a bunch of useful commands. Here is a quick overview:

```bash
# Install using npm
npm install -g repomix

# Then run in any project directory
repomix
```

Pack specific files or directories
```bash
repomix --include "src/**/*.ts,**/*.md"
```

Exclude specific files or directories
```bash
repomix --ignore "**/*.log,tmp/"
```

Pack remote repositories
```bash
npx repomix --remote https://github.com/yamadashy/repomix
```

Initialize new config file
```bash
repomix --init
```

Choose your output style
```bash
# XML format (default)
repomix --style xml

# Markdown format
repomix --style markdown

# Plain text format
repomix --style plain
```