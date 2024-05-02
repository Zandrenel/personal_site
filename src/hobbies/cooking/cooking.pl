:- module(cooking,[
	      cooking/1
	      ]).

:- use_module(src/base_elements).


cooking(_Request) :-
    reply_html_page(
	[title('Cooking')],
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



