:- use_module(library(http/http_error)).
:- use_module(library(http/http_files)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_path)).


:- multifile http:location/3.
:- dynamic   http:location/3.



user:file_search_path(images, root(static)).
file_search_path('*', '/home/alek/Code/swi-site/static/gallery').

http:location(static, '/s', []).
http:location(files, '/f', []).
http:location(gallery, '/g', []).
http:location(images, root('static/gallery'), []).
%user:file_search_path(gallery, '/home/alek/Code/Prolog/swi-site/static/gallery').

%:- http_handler(images(.), serve_files_in_directory(gallery), [prefix]).


serve_files(Request) :-
    http_reply_from_files('files', [], Request).
serve_files(Request) :-
    http_reply_from_files('/f', [], Request).
serve_files(Request) :-
	  http_404([], Request).

get_static(Request) :-
    http_reply_from_files('static', [], Request).
get_static(Request) :-
    http_reply_from_files('/s', [], Request).
get_static(Request) :-
	  http_404([], Request).


serve_gallery(Request) :-
    http_reply_from_files('static/gallery', [], Request).
serve_gallery(Request) :-
    http_reply_from_files('/g', [], Request).
serve_gallery(Request) :-
	  http_404([], Request).



% Resource Files
:- html_resource(static('styles.css'), []).


% URL handlers
:- http_handler(root(.), home_page, []).
:- http_handler(root(gallery), gallery, []).
:- http_handler(root(test), page_test, []).
:- http_handler(files(.), serve_files, [prefix]).
:- http_handler(static(.), get_static, [prefix]).
:- http_handler(gallery(.), serve_gallery, [prefix]).
:- http_handler(root(about), about_me, [prefix]).



home_page(_Request) :-
    reply_html_page(
	[title('Hello_World!')],
	[
	    \html_requires(static('styles.css')),
	    div(id(header),_),
	    \nav_bar,
	    h1('Hello!!'),
	    div([
		       div([li('Tiddles'),
			    li('Fluff'),
			    li('Rumple')]),
		       div([li('Tiddles'),
			    li('Fluff'),
			    li('Rumple')])]
	       )]
    ).

gallery(_Request) :-
    directory_files('/home/alek/Pictures/Tiddles/',F01),
    delete(F01,'.',F02),
    delete(F02,'..',F0),
    format_imgs(F0,F),
    directory_files('./',Current),
    http_absolute_location(images('playfish.jpg'),Img,[]),
    reply_html_page(
	[title('Gallery')],
	[div(id(header),h1('===--Tiddles--===')),
	 \html_requires(static('styles.css')),
	 \nav_bar,
	 p(Current)
	 div(F),
	 img(src(Img)),
	 img(src('/home/alek/Code/Prolog/swi-site/static/gallery/playfish.jpg')),
	 img(src='/home/alek/Code/Prolog/swi-site/static/gallery/playfish.jpg'),
	 img(src('/home/alek/Code/Prolog/swi-site/static/playfish.jpg')),
	 img(src('/home/alek/Code/Prolog/swi-site/playfish.jpg')),
	 img(src('playfish.jpg')),
    	 img(src='images/playfish.jpg'),
	 img([src='static/gallery/playfish.jpg']),
	 img([src='images/playfish.png']),
	 div(id('imagetest'),_)]
    ).


page_test(_Request) :-
    reply_html_page([title(test)],
		    [
			div(id(header),h1('Test 123')),
			\html_requires(static('styles.css')),
			\nav_bar,
			p('this is a little test')
		    ]).

about_me(_Request) :-
    reply_html_page([title(test)],
		    [
			div(id(header),h1('Alexander De Laurentiis')),
			\html_requires(static('styles.css')),
			\nav_bar,
			p('Hello! Welcome to my about me section, I hope there is something interesting and useful for people to learn! May ye enjoy!'),
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


% Helper methods for the gallery

format_imgs([],[]).
format_imgs([H1|T1],[H2|T2]):-
    atomic_list_concat(['static/gallery/',H1],P),
    H2 = div(class(gallery_image),img([src(P),alt=H1])),
    format_imgs(T1,T2).

% --------- To list function ---------

% ---------Navigation Bar---------

nav_bar -->
    {
	findall(Name, nav(Name, _), ButtonNames),
	maplist(as_top_nav, ButtonNames, TopButtons)
    },
    html([div(
	      id(top_nav_bar),
	      ul(id="navigationbar",TopButtons)
	  )]).


as_top_nav(Name, li(class(navitem),a([href=HREF, class=topnav], Name))) :-
	nav(Name, HREF).


nav(home, '/').
nav(gallery, '/gallery').
nav(test, '/test').
nav(files, '/f').
nav(about, '/about').


server(Port) :-
    http_server(http_dispatch, [port(Port)]).



:- initialization(server(3030)).


