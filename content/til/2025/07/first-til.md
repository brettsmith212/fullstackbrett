---
title: "First Til"
date: 2025-07-18T14:58:05-07:00
til: true
tags: ["python", "debugging"]
---

## Python's `breakpoint()` Function

Instead of using `import pdb; pdb.set_trace()`, Python 3.7+ includes a built-in `breakpoint()` function that drops you into the debugger.

```python
def calculate_average(numbers):
    total = sum(numbers)
    breakpoint()  # Debugger will pause here
    return total / len(numbers)

result = calculate_average([1, 2, 3, 4, 5])
```

**Pro tip**: Set `PYTHONBREAKPOINT=0` environment variable to disable all breakpoints without removing them from code.
