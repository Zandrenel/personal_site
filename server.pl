:- use_module(library(http/http_unix_daemon)).

:- use_module(library(http/http_error)).
:- use_module(library(http/http_files)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_path)).
:- use_module(library(settings)).


:- use_module(base_elements).
:- use_module(gallery_page).
:- use_module(home).
:- use_module(projects).
:- use_module(showcases/search_engine).
:- use_module(showcases/image_denoiser).



:- multifile user:file_search_path/2.
:- multifile http:location/3.

:- dynamic user:file_search_path/2.
:- dynamic http:location/3.


% FILE SEARCH PATHS
 
:- prolog_load_context(directory, Dir),
   (   user:file_search_path(swi_site, Dir)
   ->  true
   ;   asserta(user:file_search_path(swi_site, Dir))
   ).

user:file_search_path(gallery_images, swi_site(gallery_images)).



http:location(static, '/s', []).
http:location(files, '/f', []).
http:location(gallery_images, static('gallery'), []).
http:location(images, static('imgs'), []).




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



:- setting(http:served_file_extensions,
	   list(atom),
	   [ html, gif, png, jpeg, jpg, css, js, tgz, exe, c, zip ],
	   'List of extensions that are served as plain files').

% Resource Files
:- html_resource(static('styles.css'), []).

:- html_resource(swi_site,
		 [ virtual(true)]).

  % URL handlers
:- http_handler(root(.), home_page, []).
:- http_handler(root(gallery), gallery, []).
:- http_handler(root(projects), projects, []).
:- http_handler(files(.), serve_files, [prefix]).
:- http_handler(static(.), get_static, [prefix]).




%server(Port) :-
%    http_server(http_dispatch, [port(Port)]).



:- initialization(server(3030)).


