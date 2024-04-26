:- module(search_engine,[engine/1]).


:- use_module(src/base_elements).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(src/color).


% Note to self, this is prolog
% pages are predicates, treating a
% page unlike a predicate would be incorrect
% if a page would fail make the case where it doesn't


engine(Request) :-
    colors(street,ColorScheme),
    member(method(post), Request),!,
    http_read_data(Request, [query=Q|_], []),
    process_query(Q,R0),
    R0 = [Total|R1],
    format_results(R1,R2),
    delete(R2,'',R),
    reply_html_page(
	[title('search engine')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
	    \nav_bar,
	    div(id(main),
		[
		    \description,
		    \query_form,
		    div(['Total Results: ',Total]),
		    div(R)
		]),
	    \footer   
	]).

engine(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('search engine')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
	    \nav_bar,
	    div(id(main),
		[
		    \description,
		    \query_form
		]),
	    \footer   
	]).



description -->
    html([
		h3('Search Engine'),
		p('This project was done as a project for an information and data retrieval course at Concordia University. Here are some qualities and specifications it has.'),
		ul([
			  li('Crawler and Query processor engine built in Python'),
			  li('Index is of first 10,000 pages from https://concordia.ca'),
			  li('Returns first 15 most relevant results after scoring'),
			  li('Uses the BM25 ranking algorithm'),
			  li('Crawler uses SPIMI to construct the inverted index'),
			  li('Records frequency of word per doc along with doc ID in the index'),
			  li('Crawler built from scratch using requests and urlparse libraries'),
			  li(a([href="https://github.com/Zandrenel/Comp_479_crawler_queryProcessor"],"The Code"))
		      ])
	    ]).

query_form --> 
    html(
	div(
	    form([action('engine'),
		  method('POST')],
		 [label('Query:'),
		  input([name(query),value('')]),
		  p(button(type(submit),'Submit'))]
		)
	)
    ).

process_query(Query,Results) :-
    setup_call_cleanup(
	setup_q(Query,Out),
	read_lines(Out,Results),
	cleanup_q(Out)
    ).

setup_q(Query,Out) :-

    process_create(path(python3),
	   [
		       'project_driver.py',
		       'engine',
		       './src/showcases/engineP/static', 
		       Query
		   ],
		   [stdout(pipe(Out))]).

cleanup_q(Out) :-
    close(Out).


read_lines(Out, Lines) :-
    read_string(Out,_,Str_input),
    split_string(Str_input, "\n", "\r", Lines).


format_results([],[]).
format_results([H1|T1],[H2|T2]):-
    H2 = div(a([class(result),href=H1],H1)),
    format_results(T1,T2).

