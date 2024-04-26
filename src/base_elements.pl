:- module(base_elements,[
	      nav_bar/2,
	      footer/2,
	      in_construction/2]).

% ---------Navigation Bar---------

nav_bar -->
    {
	findall(Name, nav(Name, _), ButtonNames),
	maplist(as_top_nav, ButtonNames, TopButtons)
    },
    html([div(
	      id(top_nav_bar),
	      div(id="navigationbar",TopButtons)
	  )]).




format_sub_nav([],[]).
format_sub_nav([H1|T1],[H2|T2]):-
    H1 = sub_nav(_Parent,Name,Path),
    H2 = a([href=Path, class=subnav], Name),
    format_sub_nav(T1,T2).

as_top_nav(Parent, div(class(navitem),
		      [div(class(dropdown),
			   [a([href=HREF,class(topnav)],Parent),
			    div(class('dropdown-content'),Submenu)])
		      ])):-
    sub_nav(Parent,_,_),
    findall(sub_nav(Parent,Name,Path), sub_nav(Parent,Name,Path),Sublinks),
    format_sub_nav(Sublinks, Submenu),
    nav(Parent,HREF).
as_top_nav(Name, div(class(navitem),a([href=HREF, class=topnav], Name))) :-
    nav(Name, HREF).


% nav(Name, Path).
nav('Home', '/').
nav('Gallery', '/gallery').
nav('Projects', '/projects').
nav('Blog', '/blog').
nav('Hobbies', '/hobbies').
nav('Files', '/f').

% sub_nav(Parent, Name, Path).
sub_nav('Projects','Search Engine','/projects/engine').
sub_nav('Projects','Image Denoiser','/projects/imagedenoiser').
sub_nav('Projects','CookBook','/projects/cookbook').
sub_nav('Hobbies','FaB','/hobbies/fab').
sub_nav('Hobbies','MTG','/hobbies/mtg').
sub_nav('Hobbies','Plants','/hobbies/plants').
sub_nav('Hobbies','Cooking','/hobbies/cooking').



% -- Footer -- %

footer_link(Name, a([class(footlink),href(HREF)],Name)) :-
		link(_,Name,HREF).

footer -->
    {
	findall(Name,link(_,Name,_),LinkNames),
	maplist(footer_link, LinkNames, FooterLinks)
    },
    html([div(id(footer),
	      [
		  div(id(footerlinks),
		      FooterLinks)
	     ])
	 ]).

    
    

in_construction -->
    html([
		h1('Page unnavailable'),
		p('I Sincerely apologize but this page is currently in construction')
	    ]).


%link(social, name, ref).
link(github, 'This Site','https://github.com/Zandrenel/pesonal_site').
link(github, 'Github','https://github.com/Zandrenel').
link(linkedin, 'Linkedin','https://www.linkedin.com/in/alexander-de-laurentiis-a4b826162/').


