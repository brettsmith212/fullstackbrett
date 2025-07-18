---
title: "Git Interactive Rebase for Clean History"
date: 2025-07-18T15:28:47-07:00
til: true
tags: ["git", "version-control", "workflow"]
---

## Interactive Rebase: `git rebase -i`

Instead of having messy commit histories with "fix typo" and "oops forgot file" commits, you can use interactive rebase to clean up your commit history before pushing.

```bash
# Rebase the last 3 commits interactively
git rebase -i HEAD~3

# This opens an editor showing:
# pick abc1234 Add user authentication
# pick def5678 fix typo in auth
# pick ghi9012 Add password validation
```

You can then:
- **squash** - Combine commits together
- **reword** - Change commit messages  
- **drop** - Remove commits entirely
- **reorder** - Change commit order

```bash
# Example: squash the typo fix into the main commit
pick abc1234 Add user authentication
squash def5678 fix typo in auth
pick ghi9012 Add password validation
```

**Pro tip**: Only rebase commits that haven't been pushed to shared branches. Use `git rebase -i origin/main` to rebase everything since your branch point.
