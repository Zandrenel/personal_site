:- module(cooking,[
	      cooking/1
	      ]).

:- use_module(src/base_elements).
:- use_module(src/color).


cooking(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('Cooking')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
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



