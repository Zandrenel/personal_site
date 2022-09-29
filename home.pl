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
			    %\accomplishments,
			    \languages
			])
		]),
	    \footer
	]).


life_blurb -->
    html(
	div(id(life),
	    p(
		"Hello, My name is Alek and I am currently in my final year of Computer Science at Concordia University in Montreal. "
	    )
	   )
    ).
passions -->
    html(
	div(id(passions),
	    p(
		"My passions include artificial intelligence, more specifically natural language processing with the logic that goes into it, how it's applied, and how to use it to increase its value in our life. I believe that the accessibility to knowledge above all else is important in life and society."
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
	
