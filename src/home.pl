:- module(home,[
	      home_page/1
	      ]).

:- use_module(src/base_elements).
:- use_module(src/color).
   
home_page(_Request) :-
    colors_css(ColorScheme),
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
			    \accomplishments,
			    \languages,
			    \frameworks,
			    \markup,
			    \skills
			    
			])
		]),
	    \footer
	]).


life_blurb --> html(
		   div(id(life), p( "Hello, My name is Alek."  ) )
		   ).

passions --> html( div(id(passions), p( "I am interested in
    most technology to do with AI, NLP, and more logical ways to
    program these days. I believe that everyone should have access to
    information, and that if the rate at which technology is used
    keeps increasing, that it might as well be used to improve peoples
    lives. Accessibility is important, and one space that Could always
    use more of it is technology and its use cases so I hope to help
    further the accessibility to and brought by it."  ) ) ).
    accomplishments --> html( div(id(accomplishments), p( "I have
    experience with linux, cloud computing as well as windows
    servers. Also plenty with logic based languages and my knowlege is
    hopefully only growing."  ) ) ).

languages -->
    html([
	h3('Languages'),
	ul([
		  li('Prolog'),
		  li('Java'),
		  li('JS'),
		  li('Python'),
		  li('C++'),
		  li('Lisp'),
		  li('Bash'),
		  li('Powershell')
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
		  li('OpenGL'),
		  li('Angular'),
		  li('Node'),
		  li('RX-JS')
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
		  li('Windows'),
		  li('CLI'),
		  li('Git'),
		  li('Emacs')
	      ])
	]).
	

