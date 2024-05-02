:- module(gallery_page,[gallery/1]).


colors(red,'PowerUp.css').
colors(art,'ArtsAndCrafts.css').
colors(icecream,'MeltedIceCream.css').
colors(sunkissed,'SunKissedRock.css').
colors(midnight,'MidnightSwim.css').
colors(street,'twilightStreet.css').
colors(_,'base_colors.css').


gallery(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \html_requires(static(ColorScheme)),
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
