:- module(hobbies,[
	      hobbies/1
	      ]).

:- use_module(src/base_elements).


hobbies(_Request) :-
    reply_html_page(
	[title('hobbies')],
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



