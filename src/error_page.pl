:- module(error_page,[
	      error_page/1
	      ]).

:- use_module(src/base_elements).

error_page(_Request) :-
  reply_html_page(
    [title('Error')],
    [
      \html_requires(static('styles.css')),
      \html_requires(static('themes.css')),
      \nav_bar,
      div(id(content),[
	    div(id("error-main"),
		[
		  div(id("error-container"),[
			p("404 Error, Page not Found")
		      ])
		])
	  ]),
      \footer
    ]).
