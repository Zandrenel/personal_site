:- module(base_elements,[
	      nav_bar/2,
	      footer/2]).

% ---------Navigation Bar---------

nav_bar -->
    {
	findall(Name, nav(Name, _), ButtonNames),
	maplist(as_top_nav, ButtonNames, TopButtons)
    },
    html([div(
	      id(top_nav_bar),
	      ul(id="navigationbar",TopButtons)
	  )]).


as_top_nav(Name, li(class(navitem),a([href=HREF, class=topnav], Name))) :-
	nav(Name, HREF).

% nav(Name, Path).
nav('Home', '/').
nav('Gallery', '/gallery').
nav('Projects', '/projects').
nav('Files', '/f').


% -- Footer -- %

footer_link(Name, a([class(footlink),href(HREF)],Name)) :-
		link(_,Name,HREF).

footer -->
    {
	findall(Name,link(_,Name,_),LinkNames),
	maplist(footer_link, LinkNames, FooterLinks)
    },
    html([div(id(footer),
	      div(id(footerlinks),
		  FooterLinks)
	     )
	    ]).

    
    

%link(social, name, ref).
link(github, 'This Site','https://github.com/Zandrenel/pesonal_site').
link(github, 'Github','https://github.com/Zandrenel').
link(linkedin, 'Linkedin','https://www.linkedin.com/in/alexander-de-laurentiis-a4b826162/').
