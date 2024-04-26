

:- module(projects,
	  [
	      projects/1
	  ]).

:- use_module(src/color).


projects(_Request) :-
    colors_css(ColorScheme),
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
