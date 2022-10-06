:- module(home,[
	      home_page/1
	      ]).

:- use_module(base_elements).

colors(red,'PowerUp.css').
colors(art,'ArtsAndCrafts.css').
colors(icecream,'MeltedIceCream.css').
colors(sunkissed,'SunKissedRock.css').
colors(midnight,'MidnightSwim.css').
colors(street,'twilightStreet.css').
colors(_,'base_colors.css').


home_page(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('Home')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
	    \nav_bar,
	    div(id(content),
		[
		    div(id(main),
			[
			    \life_blurb,
			    \passions,
			    %\accomplishments,
			    \languages,
			    \frameworks,
			    \markup,
			    \skills
			    
			])
		]),
	    \footer
	]).


life_blurb -->
    html(
	div(id(life),
	    p(
		"Hello, My name is Alek and I am a recent graduate of Computer Science at Concordia University in Montreal. "
	    )
	   )
    ).
passions -->
    html(
	div(id(passions),
	    p(
		"I am interested in most technology to do with AI, NLP, and more logical ways to program these days. I believe that everyone should have access to information, and that if the rate at which technology is used keeps increasing, that it might as well be used to improve peoples lives. Accessibility is important, and one space that could always use more of it is technology and its use cases so I hope to help further the accessibility to and brought by it."
	    )
	   )
    ).
accomplishments -->
    html(
	div(id(accomplishments),
	    p(
		"I have experience with "
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
frameworks -->
    html([
	h3('Frameworks/Libraries'),
	ul([
		  li('Flask'),
		  li('Sklearn'),
		  li('JavaServlett'),
		  li('OpenCV'),
		  li('NLTK'),
		  li('OpenGL')
	      ])
	]).

markup -->
    html([
	h3('Markup'),
	ul([
		  li('HTML'),
		  li('CSS'),
		  li('Bootstrap'),
		  li('Markdown'),
		  li('Latex')
	      ])
	]).

skills -->
    html([
	h3('Skills'),
	ul([
		  li('Linux'),
		  li('CLI'),
		  li('Git'),
		  li('Emacs')
	      ])
	]).
	

