---
layout: page
permalink: /thoughts/
title: thoughts
page_title: thoughts
description:
nav: true
nav_order: 2
---

Here are a few things I wrote that you might relate to or not. These are not written the best, but they are accurate in feeling.

<ul class="thoughts-list">
{% assign thoughts = site.posts | where_exp: "post", "post.categories contains 'thoughts'" %}
{% for post in thoughts %}
  <li>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <span class="thought-date"> — {{ post.date | date: "%B %-d, %Y" }}</span>
  </li>
{% endfor %}
</ul>
