:- module(home,[
	      home_page/1
	      ]).

:- use_module(base_elements).




home_page(_Request) :-
    reply_html_page(
	[title('Home')],
	[
	    \html_requires(static('styles.css')),
	    \nav_bar,
	    div(id(content),
		[
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
		"Hello, My name is Alek, a current student of Computer Science at Concordia University of Montreal. Growing up with "
	    )
	   )
    ).
passions -->
    html(
	div(id(passions),
	    p(
		"I have passions in artificial intellogence, more specifically natural language processing and logic that can go into it, how its applied, and how to use it to increase its value in our life. I believe in accessibility above all else and access to learning to be important in life and society."
	    )
	   )
    ).
accomplishments -->
    html(
	div(id(accomplishments),
	    p(
		"I have in my time done "
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
	
