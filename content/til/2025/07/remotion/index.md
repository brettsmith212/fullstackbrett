---
title: "Vibe Coding Videos w/ Remotion"
date: 2025-07-22T21:08:38-07:00
til: true
tags: []
---

My first ever attempt at vibe coding a video. Had to start off with some Tron Lightcycles.

<video src="/til/2025/07/remotion/tron-lightcycles.mp4" controls style="width: 500px; height: auto; display: block; margin: 1.5rem auto;">
  Your browser does not support the video tag.
</video>

I saw a [post](https://x.com/trq212/status/1947706205172068624) from [@trq212](https://x.com/trq212) about how you can vibe code videos using {{<color "peach">}}remotion{{</color>}}. I immediately had to give this a try for myself.

## My Workflow

First, I went straight to the [docs](https://www.remotion.dev/docs/) and had Grok 4 give me a detailed document on how to use remotion. This was critical to getting my ai agent, Amp, to know what it was dealing with here.

<img src="/til/2025/07/remotion/grok.png" alt="grok" style="width: 500px; height: auto; display: block; margin: 1.5rem auto;">

Next, I have this to document to amp, and had {{<color "teal">}}the oracle{{</color>}} review it and give me an implementation plan for the following idea:

<img src="/til/2025/07/remotion/amp.png" alt="amp" style="width: 500px; height: auto; display: block; margin: 1.5rem auto;">

**Amp** actually gave me some pretty good follow up questions to learn exactly what I wanted from the video. It asked things like:

```markdown
Clarifying Questions:

1.Bike Behavior: Should the light cycles:

Move in perfect loops/rectangles like classic Tron?
Cross paths and create interesting intersections?
Move at the same speed or have some variation?
Color Scheme: For the 80's aesthetic, do you prefer:

2. Classic cyan/orange Tron colors?
Neon pink/purple/yellow combinations?
Multiple bike colors or stick to 2-3?
Grid Style: Should the grid be:

3. Static with subtle flicker?
Pulsing/breathing effect?
React to the bikes passing over it?
Audio: Would you like me to include:

4. A simple 8-bit background track?
Sound effects for bike movement?
Pure visual experience?
Resolution: The Oracle suggests a 240×135 virtual canvas scaled up 8x. Is this pixelated enough, or would you prefer even chunkier pixels?
```

## The final result: Not great, but still cool

This was just a first try, but it gave me a pretty bad video. The grid was there and the colors were right, but the racing around motorcycles were far from my Tron dream. It reminds me of when I first started learning to use LLM's to help me code. I could tell I needed to do a much better job of [context engineering](https://x.com/tobi/status/1935533422589399127) than I had been doing. But that's the great part is I'm not done yet, I plan to keep trying to learn how to use these image and video generating tools to make some awesome content. I will do a post later on some cool things I have been able to make with [whisk](https://labs.google/fx/tools/whisk).