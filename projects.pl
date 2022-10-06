

:- module(projects,
	  [
	      projects/1
	  ]).


colors(red,'PowerUp.css').
colors(art,'ArtsAndCrafts.css').
colors(icecream,'MeltedIceCream.css').
colors(sunkissed,'SunKissedRock.css').
colors(midnight,'MidnightSwim.css').
colors(street,'twilightStreet.css').
colors(_,'base_colors.css').


projects(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('Projects')],
	[\html_requires(static('styles.css')),
	 \html_requires(static(ColorScheme)),
	 \nav_bar,
	 div(id(main),
	     [\placeholder]
	    ),
	 \footer
	]).
	


placeholder -->
    html(
	p("This text will eventually change and there will be a display of my projects in progress and completed with links eventually.")
	).
