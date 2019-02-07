---
layout: post
title: Finding the Best Place to Live in Canada
date: 2018-05-29 19:31
comments: true
tags: guide, math, analysis, fun
confidence: 4
---

Maybe you've heard that [Ottawa is the best place to live in Canada][best]? As
best I can tell, this prestigious designation comes from
MoneySense's [Canada's Best Places to Live 2018][moneysense] interactive
document, which allows you to "remix your own ranking" by moving some sliders
around. Ottawa usually stays on top regardless of what you do.

[best]: https://www.narcity.com/ca/on/ottawa/news/ottawa-has-been-named-the-best-place-to-live-in-canada
[moneysense]: http://www.moneysense.ca/canadas-best-places-to-live-create-your-own-ranking

As I learned when I moved to Denver -- based mainly on the fact that I had heard
it was the best place to live in the USA -- other people are just as good at
using the internet as I am. I arrived about two years after everyone else who
had heard it was a great place, turning me into just one more well-off
transplant, loathed by the locals for driving up their rent costs. Or as I
learned when I moved to San Francisco somewhere between five and ten years too
late.

Look at Vancouver. In the mid-naughties it was widely renowned as "the world's
most livable city," until people found out about it, started moving there in
droves, and pushed out all of the cool people. I would have considered living
there even as late as 2013 (and I did!), but the people and things I loved about
Vancouver are no longer there.

I suspect this is true of anywhere that gains notoriety as being a good place to
live. Everyone thinking about moving does a quick google search for "best place
to live", packs up and heads out. Such a rapid influx of migrants is enough to
topple any existing sense of culture, and everyone is worse off for it.

Ottawa might be a little more resilient to this effect than other cities, due
mainly to the fact that it's winters are pretty fucking miserably. But then
again, the winters in *most* of Canada are pretty fucking miserable, so who can
say.

So this leaves us with an intriguing question; if you're planning to move, where
should you go? If the above observations are anything to go off of, the goal
seems like we should look for a cool place that flies under the radar, and one
that intends to continue doing so. Unfortunately, places like these are, almost
by definition, tricky to find via search engine keywords.

One possibility is to just drive around from city to city, staying for a while
in each and seeing if it speaks to you. This seems like a pretty solid approach,
but as someone who has driven halfway across Canada, it's a rather large
country. Playing games of geospatial guess-and-check would probably give you an
optimal solution, but by the time you found it you'd probably be worried more
about broken hips and recording memories on your calendar than about where
you're living.

But maybe we can do better? I think the aforementioned "remix your own ranking"
[Canada's Best Places to Live][moneysense] (CBPTL) is a step in the right
direction.  Describe what a "cool city" means to you, and have computers do the
majority of the legwork for you. CBPTL sorta works, but it suffers from several
fundamental flaws:

1. Most of the metrics it allows you to rank seem designed for old people. I
   don't care one bit for robust economies, home affordability, health
   accessibly or any of that other crap. I'm a millennial who doesn't work, and
   if I did, it would be online.
2. It's not clear what any of the sliders actually mean. The sliders are labeled
   with "less important" and "more important." OK, sure, but without any
   understanding of the underlying models, it seems unwise to put much faith a
   computer's recommendation that you'll like X more than Y.
3. We're unable to explicitly filter for specific criteria, like "must have an
   average age under 40" or other such things that might presumably have a large
   impact on the perceived desirability of a place.

These are pretty big reasons to not use the service, but what can we do? Neither
its source code nor its data models aren't available to the public, and so we
seem to be stuck. Or are we?

Fortunately, [Statistics Canada][statcan] publishes some surprisingly good
statistics -- much better than you'd expect from a government organization.
Particularly good is the 2016 census data, which has detailed demographic
information for every non-trivial human settlement in Canada.

[statcan]: http://www.statcan.gc.ca/eng/start

Armed with this data and an abundance of spare time, I decided to build my own
personal model of the best places to live in Canada. It turned out quite well
in that it mostly agrees with my intuitions about where I'd like to live, but
also threw some curve-balls at me that I wasn't expecting. A motivated person
looking to move somewhere could build their own model, take the top scoring
cities, and then temporarily live in each to get a feel for it before deciding
on one.

The remainder of this post exists to describe how I went about building my
model. It's not particularly technical, and might be an interesting case study if
you're curious about how we can build mathematical models for non-mathematical
things like "where should I live?" If you want to try your hand at it, all of
the code is available online [here][canadat].

[canadat]: https://github.com/isovector/canada-t

---

The first step was to figure out what data I had available to me. Luckily
StatCan has online renditions of most of its datasets, so I [pulled up the census
data for Halifax][halifax] and skimmed my way through it, making a note of
potentially useful numbers.

[halifax]: http://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/page.cfm?Lang=E&Geo1=CMACA&Code1=205&Geo2=PR&Code2=12&Data=Count&SearchText=halifax&SearchType=Begins&SearchPR=01&B1=All&TABID=1

Some of the ones I identified as being interesting included:

* Total Population + gender breakdown
* Population breakdowns near my age range + gender breakdowns
* Average/median age
* Unmarried percentage of population
* Average/median income after taxes
* Population with degrees + breakdowns by subjects I find interesting
* Number of recent migrants to the city
* Method and duration of commute

plus like fifty other metrics that seemed relevant to whether or not I'd like a
place.

Armed with interesting fields, I wrote some software that would ingest the
machine-readable data from StatsCan, and allow me to perform queries of these
metrics over cities.

From there, I started deriving more-interesting metrics out of the data I
already had. These were the metrics I intended to use to score cities on, so I
aimed to find reasonably approximate numbers for things I like about cities. I
came up with eleven components:

* **Dating Pool**: All else being equal, as a single man, I'd prefer a bigger
    dating pool over a smaller one. We can get a good approximation for this by
    taking the percentage of unmarried people and multiplying it by the number
    of women in my age range. In order to not dramatically overweigh big cities,
    we can take the logarithm of this number (a dating pool of 100,000 isn't
    significantly better than 10,000 -- I'm only one man!)
* **Gender Ratio**: Related but different to the dating pool, is the ratio of
    men to women. I've lived in places that were roughly 6:4 men to women, and
    they weren't particularly good places for dating if you were a single man. I
    decided to leave this as a linear score (eg. 80% women is twice as good as
    40% women).
* **Walkability**: It's nice to be able to get around without a car. I didn't
    have any explicit data on this (and didn't want to have to connect to other
    data sources), so I winged it by looking at the percentage of people who get
    to work by walking or biking, and the percentage who take the bus. Because
    I'd rather walk or bike than take a bus, I multiplied the first number by
    five, and then added the two together. This prefers cities where you can
    walk over cities where you can bus, but also prefers public transit to
    needing a car.
* **Technical Populace**: I added up the percentage of the population who
    studied STEM topics, giving cities 1 point for every engineer, 4 points for
    every scientist, and 10 for every mathematician. These numbers were
    completely pulled out of my ass, but "feel about right" for how much I'd
    like to hang out with a random person from each group.
* **Smart Populace**: Similar to the technical populace, except I scored the
    percentages of people with their bachelors, masters and PhDs. I picked the
    respective weights of 1, 0.5 and 3 (it might be surprising that people with
    masters degrees get scored lower than bachelors, but that is because they
    get double counted -- most people with a masters also have a bachelors, so
    in aggregate it works out to a score of 1.5 for someone with a masters).
* **Young Populace**: All else being equal, I decided a younger city is better than
    an older one, so I ranked cities linearly by an ascending median age. I
    chose median age over average age because it feels like it would perform
    better in the case of a bimodal population -- but I have absolutely no basis
    for this claim.
* **Cultural Hotspot**: Having live music around is pretty cool, but census data
    really doesn't have a lot of exploitable data for this. I decided to measure
    the percentage of the population who had studied music, and add it to the
    percentage of people who listed their professions under the heading of
    "arts, culture and entertainment." I wasn't very confident in the
    methodology here, but it strongly ranked cities like Vancouver, Victoria,
    Montreal and Stratford -- all of which are well known for their culture
    scenes. Shaky epistemology, but solid empiricism, so I kept it around.
* **Being the Right Size**: There's an interesting continuum between small
    cities and large ones. In small cities there's not much to do, but there's a
    strong sense of community, and you get to know the people around you. In a
    large city, often you can feel paradoxically invisible due to the vast
    number of people who can see you. In my experience, I like cities around
    100,000 people best, so I scored places on the negative logarithm of the
    difference between their population and 100,000. I also filtered out any
    city with fewer than 10,000 people, for reasons I'll discuss later.
* **Cheap Cities**: It's no good living somewhere that's going to burn
    through your retirement runway in six months, so I ranked places by their
    ascending median rent prices. I chose the median here thinking about cities
    like Vancouver which have a very long tail of extremely expensive housing.
* **Affordable Cities**: Similarly, I scored cities on what percentage of their
    population spent less than 30% of their income on rent. This helps weed out
    cities that are cheap but have relatively weak purchasing power.
* **Communicable Cities**: Finally, I added a factor describing how likely I was
    to be able to communicate with any given person on the street (this is a
    common problem I have in Lithuania). The census data gives *unbelievably
    detailed information about languages spoken by the population*, but I
    couldn't be fucked to deal with it, so I just penalized a city for what
    percentage of its people spoke only French.

With all of these categories defined, it was time to combine them. But it wasn't
particularly clear how to do this; most of my metrics were in terms of
completely different units, and as we all know, you can't just add distance to
mass and expect the result to make sense. Rather than trying to solve this hard
problem, I decided to just normalize each score into the range 0-10, where the
lowest scoring city on that metric got a 0, the best got a 10, and everyone else
got a linear interpolation between them. For example, if my data looked like
(300, 100, 900), it would be renormalized into (2.5, 0, 10).

This renormalization step was the reason I cut out any city below 10,000 people;
it was likely to be an outlier and, due to the law of small numbers, have some
extreme scores. By excluding these cities, I was ensuring they wouldn't wreak
havoc on the data-points corresponding to cities I might actually consider
living in.

With the components being normalized, they were now comparable (since they all
had the same "units"). But that doesn't mean that all of them are *worth* the
same; for example, I care a helluva lot more about how much I need to pay for
rent than I do for what percentage of the population is female.

But figuring out the relative weights between the components I cared about was a
little tricky, so I decided to enlist my memory to help. I made a list of all
the places in Canada I'd lived, and qualitatively ranked them based on how much
I liked living there. I then fiddled with the weighting numbers in my model
until they both "felt right" and correctly ranked the cities I'd lived in by how
much I'd liked living there. Would-be data scientists beware: this is a
*classic* example of "overfitting" -- playing with your numbers until they give
you the results you're looking for. It's a big no-no in the industry, but I'm
not in the industry, and I really didn't have much in the way of otherwise
verifying my model. So, yes, I know I've committed data science blasphemy, but,
frankly my dear, I don't give a damn.

Cool! So that's as far as I got. There's a lot of other data I'd like to work
into my model, such as proximity to the ocean, average cost of flights in and
out, and weather, but assembling (and worse, joining) that data was going to be
more work than I wanted to do.

I'm sure you're interested in what I came up with, but that would kind of defeat
the point of the exercise. Remember, the goal here is to find cool places and
then keep them under the radar so hordes of utopia-seeking migrants don't ruin
the damn place. If you're interested, [check out the software][canadat] and
build your own model. Feel free to get in touch (my email is in the sidebar) if
you need help!

But I *will* tell you this: Ottawa comes up at #9.

