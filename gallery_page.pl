:- module(gallery_page,[gallery/1]).

gallery(_Request) :-
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \nav_bar,
	 h1([style='text-align:center;'],['Gallery of Tiddles']),
	 \display_gallery,
	\footer]
    ).



% Helper methods for the gallery

format_imgs([],[]).
format_imgs([H1|T1],[H2|T2]):-
    http_absolute_location(gallery_images(H1), P, []),
    H2 = div(img([class(gallery_image),src(P),alt=H1])),
    format_imgs(T1,T2).

display_gallery -->
    {
	directory_files('./static/gallery',F01),
	delete(F01,'.',F02),
	delete(F02,'..',F0),
	format_imgs(F0,F)
    },
    html(
	div(id(display),F)
    ).
