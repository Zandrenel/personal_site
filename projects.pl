

:- module(projects,
	  [
	      projects/1
	  ]).



projects(_Request) :-
    reply_html_page(
	[title('Projects')],
	[\html_requires(static('styles.css')),
	 \nav_bar,
	 div(id(main),
	     [\placeholder]
	    ),
	 \footer
	]).
	


placeholder -->
    html(
	p("This text will eventually change and there will be a wonderful display of projects I have accomplished, but in this stage of the site this is what will be there.")
	).
