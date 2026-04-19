
:- module(francisationgg,
	  [
	      francisation/1
	  ]).


francisation(_Request) :-
    reply_html_page(
	[title('Francisation')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 div(id(content),
	     [
		 div(id("francisation-main"),[
		 \description,
		 \table_of_contents
		 ])
	     ]
	    ),
	 \footer
	]).

description -->
    html([
		p("Bonjour, si tu veux enseigner la fracais, c'est un bon place. J'ai un peu de joues en fracais, bon chance!")
	    ]).

table_of_contents --> 
    html([
		ol([
			  li(a([href='/francisation/meteo'],'Meteo')),
			  li(a([href='/francisation/erverbe'],'ER Verbe'))
		      ])
	    ]).
