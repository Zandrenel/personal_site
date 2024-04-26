:- module(blog,[blog/1]).

:- use_module(src/color).
%:- use_module(src/base_elements).

blog(_Request) :-
    colors_css(ColorScheme),
    reply_html_page(
	[title('Blog')],
	[\html_requires(static('styles.css')),
	 \html_requires(static(ColorScheme)),
	 \nav_bar,
	 div(id(main),[\in_construction]),
	\footer]
    ).
