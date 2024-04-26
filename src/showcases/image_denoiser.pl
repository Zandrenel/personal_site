:- module(image_denoiser,[nlmeans/1]).

:- use_module(src/base_elements).
:- use_module(src/color).


nlmeans(_Request) :-
    colors(street,ColorScheme),
    reply_html_page(
	[title('NL-Means for Image denoising')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static(ColorScheme)),
	    \nav_bar,
	    div(id(main),
		[
		    \in_construction,
		    \description
		]),
	    \footer   
	]).




description -->
    html(
	ul([
		  li('Follows algorithm first introduced in 2006')
	])
    ).
