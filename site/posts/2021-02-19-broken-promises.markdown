---
layout: post
title: I Broke My New Years Resolution
date: 2021-02-19 07:37
comments: true
tags: shame, sorrow
confidence: 1
---

I broke one of my New Years Resolutions yesterday. And as an accountability
mechanism, I promised that I'd publicly post the details of what happened. I'm
embarrassed to share this, but it's a small price to pay in service of
convincing myself that I will do what I say I will.

But in an attempt to salvage some amount of dignity, the button below won't work
until you've read the post detailing my goals for the year, and pressed the new
button on that page.

If I break the rules again, I'll update this post. Consider myself warned.


<script>
function rot13(str) {
  var input     = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  var output    = 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm';
  var index     = x => input.indexOf(x);
  var translate = x => index(x) > -1 ? output[index(x)] : x;
  return str.split('').map(translate).join('');
}

function see_violations() {
  if (!document.cookie.split('; ').find(row => row.startsWith('show_violations'))) {
    document.location = "uggcf://jungnyrtraqtnzr.pbz/"
  } else {
    alert("You didn't read the post!")
  }
}
</script>


<button onclick="see_violations()">View Website (2021-02-18)</button>

