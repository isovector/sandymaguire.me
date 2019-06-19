---
layout: post
title: doing-hard-things
date: TO_BE_DETERMINED
comments: true
tags: foo, bar
confidence: 4
---

For the last seven weeks, I've been working really hard. Like, six hours of
focused work per day with no weekends off. My waking life was spent thinking
about the problem, making very slow and lurching progress. My relationships were
strained.

But I'm standing on the other side of that gap today. Things have calmed down
now, and it was a rewarding process.

---

On February 13, I published [an article][free-monads] on [my other
blog][reasonablypoly] describing a technique that I like for writing computer
programs.

[free-monads]:
[reasonablypoly]:

The exact details aren't particularly relevant, but if you're curious: most
computer programs are written with implicit meaning. You tell the computer what
steps it needs to perform in order to accomplish a goal, but you never describe
the goal itself. Instead of saying things like "get me a drink from the fridge"
you say "put one foot in front of another by moving these leg muscles, making
sure to not step on anything. Move in the direction you think is most likely to
get to the big white rectangular box, but if you hit a wall, turn right and try
again. When you eventually get there, pick up the red container that weighs
355ml, again by actuating these particular arm muscles."

There are historical reasons for describing problems like this, but at the end
of the day, this way of thinking is not natural to many humans. And judging by
how weird computer programmers are in real life, the process of learning to
think like this seems to have a toll on people.

So instead the approach is to introduce high-level concepts that roughly map to
what an everyday human would consider to be the important parts of the problem.
"Locate the fridge, open it, pick up the thing I want, bring it back to me." But
these concepts are just meaningless symbols to the computer. In addition, you
also provide an interpretation of these symbols into something
slightly-less-high-level. "Analyze the room and find a path to the fridge. Pull
on the handle of the fridge."

>  "Being abstract is something profoundly different from being vague … The
>  purpose of abstraction is not to be vague, but to create a new semantic level
>  in which one can be absolutely precise."
>
> -Edsger W. Dijkstra

At the end of the day, you have to do just as much work to write all of the code
to solve the problem, but in the process, you've built reusable pieces. By
modeling the problem before providing the solution, you can subsequently reuse
the solution whenever the problem reappears.

So anyway, this approach is called *free monads,* and they've been well known in
my circles for years. Historically free monads haven't been without their
problems, but in my opinion, the pros drastically outweigh the cons.

My blog post back on February 13 caused a bit of a stir in the community. As one
[direct response][tweag] wrote "the subject of free monads is resurfacing of
late, as it does from time to time." To my immense delight, some people
contacted me, telling me they were trying the technique and finding lots of use
in it. To my complete lack of surprise, many others piled on to tell me how
wrong I was --- clearly free monads couldn't work because of X, Y, and Z.

[tweag]: https://www.tweag.io/posts/2019-03-20-capability-free-monad.html

My gut reaction was to bristle at this latter group of people. Obviously they
just didn't *get* it. And maybe they didn't, but regardless, I realized that the
fact that people weren't latching on to the idea wasn't their problem --- it was
mine.

A few years ago, I had made a failed attempt to introduce this idea to a company
I was working at. A senior consultant (nicely) called me in, and said obviously
free monads couldn't work because "getting them to be fast would require
super-compilation. Which doesn't exist. And our product is already too slow."

I didn't know what "super-compilation" meant, and out of fear of looking stupid,
I didn't call him on it. In retrospect, I suspect he didn't know what he was
talking about either, but it sure sounded smart. None of this is to say I blame
him. As they say, nobody ever got fired for making the "safe" choice; even if,
in my opinion, that choice is a bad one.

The point is, that I backed down in the face of authority telling me that this
thing couldn't be done.

But I was left with a niggling doubt. At the end of the day, the computer is
doing exactly the same thing with the free monad approach as it would be with a
more traditional approach. The only difference is in how the ideas are
structured, but if they ultimately mean the same thing, where does this
"fundamental" problem lie?

---

None of this is to say that I'm the world's only proponent of free monads.
Judging from the landscape, lots of people are working on the problem --- but
nobody had solutions that struck me as elegantly solving the problem. Roughly
speaking, there are four concerns --- conceptual simplicity, power, ease-of-use,
and speed --- and none of the existing solutions managed to tick more than two
of the four boxes.

In particular, most of them threw out conceptual simplicity and ease-of-use for
speed. While speed is a nice consideration for the *computer,* it comes at the
cost of making the experience much worse for the *humans* involved. That sucks.
Even though computer programmers are well-accustomed to making sacrifices for
the sake of the computer, it doesn't mean we should double-down on it if we
don't have to.


---

My point is that you, gentle reader, yes *you*, are no different from me in this
regard. If you're still struggling to find your footing, just find something
that seems promising and learn as much as you can about that thing. Dig into it
and figure out where the boundaries are. Determine why those boundaries are
where they are, and start thinking about to get around them.

But I think most importantly is to not be afraid to be wrong. You're going to
make mistakes --- it's the nature of the beast --- but if you're afraid of
making mistakes you'll never get started in the first place.

When I read back through some of my oldest technical blog posts I'm *mortified*
by them. They're just so stupidly wrong. I wouldn't build anything like that in
a million years now. But at the time I was convinced it was hot shit. It's
pretty funny in retrospect just how dumb I was. But I'm only smarter now because
I put in the effort.

To quote Gwern:










> "You see things; and you say 'Why?' But I dream things that never were; and I
> say 'Why not?'"
>
> -George Bernard Shaw

> "I notice that I am confused." Your strength as a rationalist is your ability
> to be more confused by fiction than by reality. Draco was confused. Therefore,
> something he believed was fiction.
>
> Eliezer Yudkowsky, [Harry Potter and the Methods of Rationality][hpmor]

[hpmor]:
