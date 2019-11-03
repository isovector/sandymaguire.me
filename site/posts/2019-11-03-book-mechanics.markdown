---
layout: post
title: The Mechanics of Writing a Book
date: 2019-11-03 12:56
comments: true
tags: book, writing, strategy
confidence: 2
---

One of my core tenets is that processes are much more important than results. A
well-executed result is good for me, but a good, reified process is good for the
world. Far too much human ingenuity is spent figuring out how someone else made
something cool, and we'd all be better off if we could just communicate those
things openly.

If you haven't heard the good word, I'm actively writing a book called [Design
and Interpretation of Haskell Programs][patreon]. It's about writing good and
robust software in Haskell, something that is regrettably not yet very well
known. But don't worry, I'm not going to talk about Haskell today. I want to
talk about how I go about writing a book.

[patreon]: https://www.patreon.com/designandinterpretation


## Where Does a Book Come From?

I write practical nonfiction. My impetus to write nonfiction comes from spending
a lot of time thinking about just how frustrating life today is, and how it
doesn't need to be that way. Paul Graham has a quote on this that I really like
and identify with:

> Live in the future, then build what's missing.
>
> -Paul Graham

For me, writing books isn't about *building,* but about *bridging.* In
technology, most of our problems were solved 30 years ago, but nobody knows
about it because minds are slow to change and academics are particularly bad at
communicating. As such, my work doesn't contribute anything new, it just
synthesizes other people's work into one place.

This is great news, because it means that I can just spend lots of time reading
weird, obscure things, and keep track of which ones feel like they're onto
something. I'm very familiar with the day-to-day workings of my field, and by
paying attention to research that tackles the everyday problems, that's most of
the work right there.

At the end of the day, a book comes from wanting the world to be different, and,
in particular, knowing in what way you'd like it to be different. If your
personality is like mine, this is sufficient motivation. Knowing the right
answer and feeling like society is to sluggish to get there on its own makes it
feel like writing this book is a *responsibility* that you have to the world.

If you are going into this project to get rich, *stop right now.* It's a) the
wrong motivation, because you probably won't, and b) going to be very obvious to
all of your readers. Audiences can smell a cash grab a mile away, and aren't
likely to reward you with their hard-earned cash.


## Getting Started

I begin by identifying a theme for the book. Roughly, what is it going to be
about? This thing should be the length of a subtitle, for example "type level
programming in Haskell" or "a guide to building robust software." Having a theme
helps identify who would be interested in such a thing, and roughly what sorts
of things you should be writing about (which is less obvious that it sounds!)

This gets me thinking about the people that I know personally. Are any of them
the target audience? I'll make a list of people I know who might be interested,
and then roughly estimate how much they know about the topic at hand. I am
always looking for someone I know personally who is a) smart, b) interested, and
c) average in their knowledge on the subject.

After identifying one to three of these people, I'll go and explicitly say to
them "hey, I'm thinking about writing a book on topic X --- how likely would you
be to buy such a book?" I will iterate on the theme, and the people until I find
a combination that evokes enthusiasm.

Enthusiasm is the key. I am looking for sentiments along the lines of "thank
god, I've been waiting for someone to write that," or "I didn't know I wanted
that, but now I can't wait," or, "shut up and take my money!" If you can evoke
that sort of response, and have no reason to believe that your friend is alone
in that opinion, then congratulations. You've found a market for your book.

It's important to target a friend who is in the average understanding. If you
find someone who is far below average, your book is going to need to spend a lot
of time covering first principles. If they're far above average, the pool of
people who will buy your book is going to be unreasonably small.


## The Target Audience

This enthusiastic friend of yours is your greatest asset in writing a book. You
are writing this book *for them,* and for no one else. The goal is to take your
friend, at their current level of understanding, and gently lead them to your
point of view. Doing so requires a deep understanding of what you want to teach,
but it requires a *deeper* understanding of the way that they see the world.
It's okay --- and natural --- to be a little fuzzy on what you're going to write
about. That part comes from actually writing it. But you need to understand your
friend well enough that you can frame the problem and motivate the solution in
language that they can understand.


## Promise Yourself to Get It Done

I always make a promise to myself that if I'm going to do this work, I'm not
going to waste my time by *not finishing it.* That's not to say I should sink my
costs if the book truly isn't very good, but it's a good defense against
akrasia.

This comes in two flavors. The first is that while I'm committed to finishing
the project, I need to work on it *every single day.* "Working" here is
intentionally defined very loosely. Fixing a typo counts as doing work. Writing
a single sentence, or editing a paragraph for flow counts as doing work.
Obviously, writing significant amounts of prose also counts as doing work. So
long as my document isn't in exactly the same state as it was 24 hours ago, it
counts.

The psychology here is that projects that are always being worked on are
eventually finished. But, it's an acknowledgment that life can often get in the
way of the best laid plans. And so, we define progress by input, not by output.
So long as you do *something, anything,* you haven't broken the streak.

Having a low barrier on this front is amazingly powerful. Often I'll find myself
in bed getting ready to sleep, and realize "oh shit, I didn't work on the book
yet today!" My initial reaction will be "eh... fuck it." But having such a low
barrier to progress means I'll feel like a piece of shit if I'm *so lazy* that I
can't manage to pull open my laptop, write a single sentence, and then put it
away again. It's the inertia the counts, not the speed.

Working on it every day is a good way to prevent the accidental death of your
project. But it's not a good strategy if this thing you're creating *truly isn't
worth finishing.* For that, I also write a quick document describing under which
circumstances I'm allowed to quit, and when. For example, on my last book, I
wrote this:

> When To Quit
>
> There will be no quitting, unless another book comes out before this, also
> targeted explicitly at type-level programming in Haskell, which is judged by
> me to be superior.

Notice how clear that is. It gives an explicit stop condition --- someone
writing a better book, *as judged by me.* In fact, while writing my book,
someone else did publish first, but after skimming a few chapters, it was
clearly an inferior product. Rather than let it get me down, I realized that
neither my mission nor the world had changed in light of this other book, and so
I should keep my head down.

And the market agreed with me. To date I've sold at least 20x more copies! The
power of strategic perseverance is a powerful one,


## Work on Philosophy First

Spend a lot of time writing the philosophy of the way you see the world.
Describe the problems you see with great anguish. Really sell just how painful
this experience is, and try to motivate a world in which we haven't already
internalized this pain. How if your solution were already the status quo, we'd
never think about trying the things we're doing now. Rhetoric is a powerful tool
here.

Your argument doesn't need to be technical. Not yet. All it needs to do is be
strongly motivating. You need to convince your reader that this problem is worth
solving, and, by extension, that your book is worth reading.

Throughout the writing process, I will often finish five or six chapters along
these lines. Few if any of them end up in the final print. But the exercise is
not for naught; by expounding on these issues you will clarify exactly what
problems you see, you will discover a natural structure for the book, and you
will come up with good material for copy.

The philosophy is much easier for people to understand than the technical
solutions. The latter require significantly more attention, and so by making the
philosophy as persuasive as possible, you are readying your reader for the
difficult tasks ahead. In my experience, very few nonfiction books take the
motivation aspect seriously enough. With so many excellent books out there, it
takes quite a lot to convince me that *this one in particular* is worth reading.

Nailing the motivation is by far the hardest part of the process. So spend lots
of time waxing poetically on the way the world should look. Tackle it from as
many different angles as possible. If possible, show that several real problems
all share the same structure, and thus that your one solution would solve all of
them simultaneously.


## Test Your Assumptions

Take two of your best motivating pieces, and start rolling with them. Find a
relatable example, show how it's a problem with traditional methods, and do a
case study of applying your technique to it. You don't need to spend a lot of
time on this, just enough to convince yourself --- and an audience --- that
everything works as you say it does.

Write prose around the example, explaining every piece in great detail. Assume
the reader knows exactly what your target audience friend does, and explain the
bits that you would explain to your friend. Walk them through your thought
process, about when this technique can be expected to work, and good heuristics
for how to use it.

Tackle two of these case studies, ideally two that are in very different
domains, which can showcase different aspects of the solution.

Compile the two case studies and two best pieces of philosophy into a single
document, and spend an hour or two polishing it. When you're done, here comes
the scary part: sharing it. You need to distribute this document of yours
widely. Make it freely available in the circles that your ideal readership hangs
out in. See how people respond to it. Make the necessary changes in order to
convince them that your nascent book is worthwhile.

If you've done your homework and made a compelling case, I suspect the audience
will be supportive. But there's always the chance they aren't, and this too is
valuable. Honestly consider their concerns. If you can't convince your core
audience to get excited about this thing, you're probably not going to convince
a wider audience either. If it seems like the problems are solvable, go back to
the drawing board and try again. Otherwise, now might be a good time to cut your
losses.

---

This is about as far as I've gotten in my new book, so it's as much as I've been
reminded about. More to come as I get further in.

