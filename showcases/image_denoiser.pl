:- module(image_denoiser,[nlmeans/1]).

:- use_module(base_elements).


:- http_handler(root('projects/nlmeans'), nlmeans, [prefix]).

nlmeans(_Request) :-
    reply_html_page(
	[title('NL-Means for Image denoising')],
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
		  li('Follows algorithm first introduced in 2006')
	])
    ).
