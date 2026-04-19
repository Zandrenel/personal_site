

:- module(projects,
	  [
	      projects/1
	  ]).

:- use_module(color).


projects(_Request) :-
    reply_html_page(
	[title('Projects')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 div(id("projects-main"),
	     [\placeholder]
	    ),
	 \footer
	]).
	


placeholder -->
    html(
	ul([
		  li(a([href='/projects/engine'],[engine]))
	      ])
    ).
