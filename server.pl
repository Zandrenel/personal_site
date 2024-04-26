%:- use_module(library(http/http_unix_daemon)).

:- use_module(library(http/http_error)).
:- use_module(library(http/http_files)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_path)).
:- use_module(library(settings)).

:- use_module(library(http/http_ssl_plugin)).


:- use_module(src/base_elements).
:- use_module(src/gallery_page).
:- use_module(src/home).
:- use_module(src/blog).
:- use_module(src/projects).
:- use_module(src/showcases/search_engine).
:- use_module(src/showcases/image_denoiser).
:- use_module(src/showcases/cookbook).
:- use_module(src/hobbies/hobbies).
:- use_module(src/hobbies/fab/fab).
:- use_module(src/hobbies/mtg/mtg).
:- use_module(src/hobbies/cooking/cooking).
:- use_module(src/hobbies/plants/plants).





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
:- http_handler(root(gallery/IMG), gallery(IMG), []).
:- http_handler(root(blog), blog, []).
:- http_handler(root(projects), projects, []).
:- http_handler(root(projects/engine), engine, [prefix]).
:- http_handler(root(projects/engine/results), results, [prefix]).
:- http_handler(root(projects/imagedenoiser), nlmeans, [prefix]).
:- http_handler(root(projects/cookbook), cookbook, [prefix]).
:- http_handler(root(hobbies), hobbies, []).
:- http_handler(root(hobbies/fab), fab, [prefix]).
:- http_handler(root(hobbies/mtg), mtg, [prefix]).
:- http_handler(root(hobbies/cooking), cooking, [prefix]).
:- http_handler(root(hobbies/plants), plants, [prefix]).
:- http_handler(files(.), serve_files, [prefix]).
:- http_handler(static(.), get_static, [prefix]).




environment(dev).

server(Port) :-
    environment(dev),
    http_server(http_dispatch,
		[port(Port)]).

server(Port) :-
    environment(prod),
    http_server(http_dispatch,
		[port(Port),
		 ssl([
			    certificate_file('/var/www/alexanderdelaurentiis.com/fullchain.pem'),
			    key_file('/var/www/alexanderdelaurentiis.com/privkey.pem')

			])
		 %min_protocol_version(tlsv1_3),
		 %cipher_list('EECDH+AESGCM:EDH+AESGCM:EECDH+AES256:EDH+AES256:EECDH+CHACHA20:EDH+CHACHA20')
		]).



