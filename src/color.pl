:- module(color, [
	      colors/2,
	      colors_css/1
	      ]).

colors_css(CSS):-
    active(Color),
    colors(Color,CSS).

active(street).

colors(red,'PowerUp.css').
colors(art,'ArtsAndCrafts.css').
colors(icecream,'MeltedIceCream.css').
colors(sunkissed,'SunKissedRock.css').
colors(midnight,'MidnightSwim.css').
colors(street,'twilightStreet.css').
colors(_,'base_colors.css').


