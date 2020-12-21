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


### 2020-11-03

My partner last night asked "why didn't you just 3D print some bolts?" Gotta
admit, that idea never occurred to me. Apparently I'm not yet used to having a
mini factory in my house. So I tried that this morning, but my tolerances aren't
good enough, and the resulting nuts didn't thread successfully. Thankfully my
Amazon delivery happened in the morning, so I set back to building.

My new bolts are the right diameter, but are TOO SHORT for what I need them to
do. Fuck. So I just started hot-gluing things, and that worked well enough.
A careful hour later (the PLA chassis still feels very brittle), I had
everything assembled, hot-glued, rewired, and soldered together. Time to get to
balancing.

Some combination of "bad tutorial" and "bad engineer following said tutorial"
resulted in me not calibrating the accelerometer while it's on flat ground, so
instead I just tried to balance the robot and run the calibration there. I have
no idea how important this step is, but it's something I'll do when working on
my skateboard proper.

After 30 minutes of tuning parameters, I got the robot balancing somewhat well.
I'd accidentally soldered the drive motors backwards, so the first time around
it would be actively trying to fall over. Whoops. Thankfully this was easy to
fix in software. When everything was turning in the right direction, I found
that my wheels stopped spinning when the desired delta got too big. Suspect: too
low amperage on my batteries. Something to investigate tomorrow.

Also! I only fastened down the accelerometer with a single bolt (the chassis
print apparently didn't have a plan for mounting any of these things?) This lead
to all sorts of instability in my measurements, so I eventually bit the bullet
and just hot-glued the fucker. I don't know if I'll regret that when I want to
reuse the accelerometer, but that's a problem for future me.

![I built something!](/images/m2m/robot.jpg)


### 2020-11-04

Major success! I got the thing balancing!

<video width="558" height="327" controls><source src="/images/m2m/balancing.webm" type="video/webm"></video>

After a bunch of troubleshooting, I realized that my power supply was completely
fine. The motors would cut out when asked to spin too fast. Since these are
boring DC motors, they operate via PWM --- essentially, sending an oscillating
square wave whose ratio of high-to-low duration allows you to effectively drive
the motor at less than full speed. The problem I thought was the Arduino's pins;
perhaps there was a hardware flaw and they were unable to emit the same signal.

I split out the circuit and ran an LED on the signal (much easier to play with
than spinning parts,) and I observed the same behavior there. Because there's no
way that a single LED is overloading my power supply, the issue must be
somewhere else. I wrote a quick Arduino program to just modulate the LED at
100%, and, to my surprise, it worked just fine. Which means it's thankfully not
a hardware issue.

Returning to the self-balancing code, I realized the original author had
multiplied an expected negative value by `-1`, rather than calling `abs`. In his
code, it worked fine, but I had originally wired the motors backwards, and had
mindlessly swapped the `DriveForward` and `DriveBackwards` calls. Works great,
except that now the values were negative when the code didn't expect them to be.
So it would negate my values in an attempt to fix them, which resulted in asking
the motors to spin at a *negative percentage!* Thus the weird behavior I was
seeing yesterday.

Fixing the logic resulted in the excellent balancing you see in the video above
--- on my first try! Apparently yesterday's careful calibration against a
completely-broken implementation was more than good enough for a working one.

So, that's the first step towards my skateboard goal. I've managed to put
together (and mostly understand) a self-balancing robot. That's the major
hurdle. All that's left is to change the form-factor into something more
amenable to humans. Which means it's time to focus on design.

After watching a few tutorials on FreeCAD, I figured I was ready to get started.
Rather than diving into a skateboard, I thought I'd start on something easier.
My alarm clock is currently some nixie tubes connected to a bare circuit board,
so I thought this would be a good opportunity to make a proper enclosure. It'd
be boxy, but have some interesting angles and holes.

Four hours later, I was yelling at FreeCAD for having the world's worst UI.
Conceptually I have a great mental model of how to build what I want, but the
tool doesn't make it easy. I think I have a working enclosure, so it's currently
printing. Tomorrow I'm going to take the Haskell-based
[ImplicitCAD](http://www.implicitcad.org/) for a spin, which seems like it will
better play to my strengths.

All in all, I'm feeling great about the project today!


### 2020-11-05

I spent today traveling, so got less done than I'd hoped. But nevertheless, got
a good two hours in looking at ImplicitCAD. As a library, I'm sure it's
excellent, but my god is it missing the everyday Haskell usability. ImplicitCAD
suffers from the usual problem of mathematics --- namely that there are no types
and all numbers, regardless of purpose, are just the reals. Positions? Reals.
Rotations? Reals. Curvatures? Reals. Worse, there is no indication of what the
axes are. It was a frustrating experience, made more frustrating by the fact
that I don't really understand the domain I'm working in. I'm going to spend
tomorrow also working with Implicit, as I think I've sussed out enough to be
able to get some real work done. But if that doesn't turn out to be the case,
I'm going to cut my losses and use some other CAD tool.


### 2020-01-06

Today I gave ImplicitCAD another go, and made some solid progress on it. I
learned that the default camera is facing the front of the object, and that the
coordinate space is `(width, depth, height)`. After thinking very hard yesterday
about how to construct the objects I wanted, I managed to put together a
parametric version of the enclosure for my alarm clock, and the result is
significantly easier to manipulate. I think I'm going to move forwards with
ImplicitCAD as my modeling software.

Tomorrow all of the traveling should have died down, and I plan to get in a good
session with my father, the king of batteries and building weird
machines. It'll be good to pick his brain on the feasibility of a full-sized
skateboard, now that I'm reasonably confident this thing is doable.


### 2020-01-07

Spent the day discussing the project with my dad, who had some great ideas about
how to go about actually manufacturing this thing. He also showed me some good
places to look for parts, and we found some promising wheel/motor hubs.
Furthermore, regenerative braking appears to be something I'll get for free.

I also started CAD modeling the board. I've got its frame all modeled
parametrically, so I can fill in real values when I get the real parts measured.
I'm still missing the electronics and battery compartments on my model, but
it'll be easy to get that figured out tomorrow.


### 2020-01-08

PANIC.

Today I spent a lot of time looking into what it would take to actually get this
thing built in full size. I started looking at specific hub motors, and what
sorts of power they'd require. After a few hours, I was panicking and physically
unable to continue thinking about it.

Some problems.

First: I have no idea what I'm doing. The difficulty curve just of the
theoretical engineering of this thing is already a significant challenge and
learning experience. Physically manufacturing it is an even steeper one that I'm
trying to tackle at the same time. The result is what feels like an impenetrable
wall of understanding and difficulty, that I'm doubting my ability to overcome.

Second: economically, this thing is starting to look very expensive. Which is
discouraging if I'm not convinced I can pull it all off. A few hundred bucks for
the hub motor, the same again for the batteries, and then probably half as much
again to have someone manufacture the chassis for me.  Which feels like
cheating, but which brings me to my next point:

Third: I don't have access to any of the tools I'd need. I could buy them, but I
don't have the physical space required to store or use any of them, and this
would dramatically increase my costs. No go. A maker space would be perfect, but
there isn't one in town.

Fourth: time pressure. I'm fully confident I could pull this all off in six
months, given time to work out solutions to the earlier problems. Right now I'm
further worried about shipping times; most of the pieces seem to be only sold
from Chinese vendors, meaning a best case delivery of 10 days, but more likely
closer to two weeks. That's skirting the line pretty close if I were to order
today, and I am in no state to be ordering today.

All in all, things are looking pretty grim. I'm not sure where to go from here,
but I'll sleep on it and hopefully things will look brighter tomorrow.


### 2020-01-09

Slightly less panic. I asked around today on some local forums, and found the
Victoria Tool Library, which rents out tools. That's a big pillar of problems
knocked down. All that's left now is to find some space, and I'll be happy
committing financially to the project. I'm not convinced it'll get done in
November, but the deadline is just all make believe anyway. Not a lot done
today, but maybe I'll work out a bill of materials tomorrow.


### 2020-01-10

I bit the bullet today, and bought a hub motor. It's happening. Assuming
shipping happens before the end of the month, I'm committed to making this thing
happen. I also invested in a car share, which will make getting tools much
easier than trying to heave a spot-welder around town on my bike. And I learned
that there is a metal supply store in town that can cut things to whatever
length I need, with no minimum order. It's feeling possible.

Furthermore, I found a [Youtube channel][fungineers] of some guys building the
same skateboard. Today I went through all of their videos, and that gave me a
much more realistic idea of what's necessary to do. I've decided to outsource
building a battery pack, because it sounds like a great way to explode my
apartment. With that and the metal cutting sorted out, I think everything should
fit in my apartment.

We gucci, baby.

Home tomorrow, and I'll start engineering exactly what the frame should look
like, so I can get the parts cut as soon as possible.

[fungineers]: https://www.youtube.com/watch?v=65Tv4kycUSg&list=PLiYCRuOFm1MNj5a5LCCYhqoHpRu8Sc1Fx


### 2020-01-11

Travel day, so not much progress. I bought a motor controller, pilfered lots of
great stuff from my dad's workshop, and realized I already have the right gauge
of wire to carry the wicked amount of current I'm going to need. Tomorrow I plan
to sort out the design of the frame, and get that sent off for fabrication.
I'm feeling good about the whole project.


### 2020-01-12

Recovery and errand day after traveling. Did some more part shopping, and
figured out the WolframAlpha keyword for figuring out if my intended aluminum
rails will bend with my bodyweight: "beam deflection." Looks like they won't, so
I'm good. Tomorrow I'm going to suss out if anyone in town builds battery banks,
and ask if any of my friends have a drill press they're not using.


### 2020-01-13/14

No progress these days, just waiting for parts to come in.


### 2020-01-18

So the wheel hasn't even shipped yet, and it's coming from China. I'm going to
put this project on hiatus until I get word it's actually on its way. Updates
when I have them!

