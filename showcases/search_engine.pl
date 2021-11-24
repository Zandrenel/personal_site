:- module(search_engine,[engine/1]).

:- use_module(base_elements).


:- http_handler(root('projects/engine'), engine, [prefix]).

engine(_Request) :-
    reply_html_page(
	[title('search engine')],
	[
	    \html_requires(static('styles.css')),
	    \nav_bar,
	    div(id(main),
		[
		    \description
		]),
	    \footer   
	]).


description -->
    html(
	ul([
		  li('BM25 ranking algo'),
		  li('Built an index of 10,000 pages'),
		  li('Queryable with relevant results')
	])
    ).
