---
layout: post
title: "Month to Mastery: One Wheel Skateboard"
date: 2020-11-01 12:11
comments: true
tags: mastery, engineering, skateboard
confidence: 2
---

## The Project

Now that Algebra-Driven Design is done, I've been looking to branch out of my
traditional skill-set. With the exception of a little break at the end of last
year, I've been programming continuously since 2003, and have gotten pretty good
in that space. For the last five years, learning Haskell has been my primary
intellectual endeavor, but these days I feel like I've learned about as much as
it has to teach me. It's time to tackle something new.

Looking for inspiration, I came across the wonderful [Max Deutsch][max], whose
[Month to Master][m2m] project had him pick up and conquer one ridiculously difficult
project per month. These weren't things like "learn to play Wonderwall," but
were "learn to draw photo-realistic self-portraits" and "build a self-driving
car." At the beginning of each month he'd introduce the project, and then write
daily microblogs describing the day's progress. I love this idea, and have
decided I'm going to follow in Max's footsteps and aggressively tackle my own
exciting projects.

[max]: https://medium.com/@maxdeutsch
[m2m]: https://medium.com/@maxdeutsch/m2m-day-1-completing-12-ridiculously-hard-challenges-in-12-months-9843700c741f

Today, November 1, 2020, is the first day of the project. My intention for
November is to *build a self-balancing, one-wheel skateboard.* I used to have a
[OneWheel](https://www.youtube.com/watch?v=XNqOU4jx62I), which was the most fun
sport I've ever engaged in. When I [ran away from Ottawa][breakdown], I left it
behind, and have regretted it ever since. But these bastards are expensive, and,
having fixed it myself a few times, not overwhelmingly complicated.

[breakdown]: /blog/burnout/

I have no idea how to build such a thing, but I'm confident I can figure it out
in a month. I built some lego robots in university, and once soldered together a
clock, but that's the extent of my hardware knowledge.

My plan is to build a model-scale skateboard, in order to test my engineering
prowess, and ensure I have sufficient understanding of the control systems.
Doing it with full-sized hardware is a stretch-goal, though the parts are quite
expensive, so I'd like some assurance that I'm on the right path before
investing in them. If the month ends with only a robust, working scale
prototype, I'll consider it a success if the only hurdle towards productionizing
is one of economics.

I'm off to get started. Will report back, editing this post, with my progress
each day.


### 2020-11-01

Today was less productive than I was expecting. I found a tutorial on [making a
self-balancing robot][tutorial], and started working on it. I've got the
electronics prototyped out, but when 3D printing the chassis, my printer started
running into extruder problems. (I think) I've got that sorted out now, and
tried to print the chassis again; this time somehow my bed had gotten out level,
making the print extremely stuck to the print bed. When wrestling it off, the
PLA snapped. I'm trying again with a re-calibrated, hopefully better-extruding
system, but the chassis is a four hour print. If I don't have a sturdy piece by
lunch tomorrow, I'm going to macguyver something together out of cardboard and
hot glue.

[tutorial]: https://circuitdigest.com/microcontroller-projects/arduino-based-self-balancing-robot


### 2020-11-02

My recalibrated 3D prints went well; I seem to have solved the brittleness and
adhesion problems. But I didn't realize the pieces needed to be bolted together.
Three trips to different hardware stores and two hours later, I hadn't managed
to find the right bolts. I knew I needed 3mm diameter bolts, but they don't sell
them by diameter. Instead they have meaningless designations like #7, #6 and
especially confusingly, #6-32. The #6-32s were the smallest I could find, so I
picked those up. But they're actually 4.5mm, which is TOO BIG. Covid has the
industrial supply store closed, so if I want to find these pieces locally, it's
going to take a minimum of two days. Instead I bought a big collection of random
bolts on Amazon and paid the express delivery fee to have them before end of
tomorrow.

I was vaguely aware of this eventuality; that building things in meat-space
require parts that I can't just magic up by downloading a library. I *knew* this,
but I didn't *feel* it until now.

Feeling underwhelmed by my progress, I familiarized myself with the PID
controller libraries, and how my accelerometer works at a high level. I think I
have a good understanding of these thins, and verified it by seeing that the PID
equations can be implemented in 6 lines of Haskell. I also confirmed that my
Arduino environment and build-chain is working, so that I'm ready to go as soon
as tomorrow's chassis is built. Disappointing day, though.

