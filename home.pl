:- module(home,[
	      home_page/1
	      ]).

:- use_module(base_elements).




home_page(_Request) :-
    reply_html_page(
	[title('Hello_World!')],
	[
	    \html_requires(static('styles.css')),
	    \nav_bar,
	    div(id(content),
		[
		    h1('Hello!!'),
		    div(id(main),
			[
			    \life_blurb,
			    \passions,
			    \accomplishments,
			    \languages
			])
		]),
	    \footer
	]).


life_blurb -->
    html(
	div(id(life),
	    p(
		"Hello, My name is Alek ... "
	    )
	   )
    ).

passions -->
    html(
	div(id(passions),
	    p(
		"I have passions in AI, NLP, ... "
	    )
	   )
    ).

accomplishments -->
    html(
	div(id(accomplishments),
	    p(
		"I have in my time done x, y, and z ..."
	    )
	   )
    ).

languages -->
    html([
	h3('Languages'),
	ul([
		  li('Prolog'),
		  li('Java'),
		  li('Python'),
		  li('C++'),
		  li('Lisp'),
		  li('Bash')
	      ])
	]).
	
