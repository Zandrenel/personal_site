:- module(fab,[
	      fab/1
	      ]).

:- use_module(src/base_elements).

fab(_Request) :-
    reply_html_page(
	[title('fab')],
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


main_text --> html( p('test')).
