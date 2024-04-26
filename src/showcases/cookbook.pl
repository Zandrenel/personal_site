:- module(cookbook,[
	      cookbook/1
	      ]).

:- use_module(src/base_elements).
:- use_module(src/color).


cookbook(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('Cookbook')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
	    \nav_bar,
	    div(id(main),
		[
		    \in_construction
		]),
	    \footer
	]).



