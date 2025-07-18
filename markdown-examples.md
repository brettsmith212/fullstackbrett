# Headers

Headers are created using hash symbols (#). The number of hashes determines the level.

# H1: Largest header
## H2: Second largest
### H3
#### H4
##### H5
###### H6: Smallest header

How they look: Headers render as bold, larger text, decreasing in size from H1 to H6.

---

## Emphasis (Bold, Italics, Strikethrough)

Use asterisks or underscores for emphasis.

- **Bold text** (using **double asterisks** or __double underscores__)
- *Italic text* (using *single asterisks* or _single underscores_)
- ***Bold and italic*** (using ***triple asterisks***)
- ~~Strikethrough~~ (using ~~double tildes~~, supported in many Markdown flavors like GitHub)

How they look: Bold appears thicker, italics slanted, strikethrough with a line through the text.

---

## Lists

### Unordered Lists
Use -, *, or + for bullets.

- Item 1
- Item 2
  - Subitem (indented with spaces)
- Item 3

How it looks: Bulleted points, with sublists indented.

### Ordered Lists
Use numbers followed by a period.

1. First item
2. Second item
   1. Subitem (indented)
3. Third item

How it looks: Numbered points, automatically sequential, sublists restart numbering.

### Task Lists (Checklists)
Use - [ ] for unchecked and - [x] for checked (extended Markdown).

- [ ] Task not done
- [x] Task done

How it looks: Checkbox-style list, with boxes that can be checked.

---

## Links

[Link text](https://example.com) or [Link text](https://example.com "Optional title")

How it looks: Clickable blue underlined text that navigates to the URL.

Autolinks: <https://example.com> renders as a plain clickable URL.

---

## Images

![Alt text](https://example.com/image.jpg "Optional title")

How it looks: Embeds the image inline with alt text for accessibility.

---

## Code

### Inline Code
Use single backticks: `code snippet`

How it looks: Monospaced font, often with a gray background.

### Code Blocks
Use triple backticks or indent with 4 spaces. Language can be specified for syntax highlighting.


```python
# Syntax-highlighted code
def hello():
    print("Hello, world!")
```

Python supports various data types. Here's a comparison:

| Data Type | Example | Use Case |
|-----------|---------|----------|
| `str` | `"Hello"` | Text data |
| `int` | `42` | Whole numbers |
| `float` | `3.14` | Decimal numbers |
| `bool` | `True` | True/False values |
| `list` | `[1, 2, 3]` | Ordered collections |
| `dict` | `{"key": "value"}` | Key-value pairs |