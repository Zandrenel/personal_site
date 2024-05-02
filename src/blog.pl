:- module(blog,[blog/1]).

%:- use_module(src/base_elements).

blog(_Request) :-
    reply_html_page(
	[title('Blog')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 div(id(main),[\in_construction]),
	\footer]
    ).
