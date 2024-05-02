:- module(mtg,[
	      mtg/1
	      ]).

:- use_module(src/base_elements).



mtg(_Request) :-
    reply_html_page(
	[title('MTG')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static('themes.css')),
	    \nav_bar,
	    div(id(content),
		[
		    div(id(main),
			[
			 \in_construction
			])
		]),
	    \footer
	]).
