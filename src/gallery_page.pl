:- module(gallery_page,[gallery/1, gallery/2]).

:- use_module(src/color).

:- dynamic
       image/3.

gallery(_Request) :-
    colors_css(ColorScheme),
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \html_requires(static(ColorScheme)),
	 \nav_bar,
	 h1([style='text-align:center;'],['Gallery of Tiddles']),
	 \display_gallery,
	\footer]
    ).
    

gallery(IMG,_Request) :-
    colors_css(ColorScheme),
    image(IMG,Link,Next,Previous),
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \html_requires(static(ColorScheme)),
	 \nav_bar,
	 h1([style='text-align:center;'],['Gallery of Tiddles']),
	 div(id(main),[
		 a([href='/gallery'],button('< Back')),
		 div([id(enlarged_picture_layout),class(container)],[
			 div([id(img_button_container),class([row])],\previous_next_buttons(Previous,Next)),
			 div(class([row]),img([class([enlarged_image]),src(Link),alt=IMG])),
			 div([id(full_img_btn),class([row])],a([href=Link],button('Full Image')))

		 ])
	     ]),
	 \footer]).
gallery(_IMG,Request) :-
    http_redirect(moved, root(gallery),Request).



image(Img,Link,Previous,Next):-
    image(Previous,_Plink,Img),
    image(Img,Link,Next),
    image(Next,_Nlink,_Nnext).
image(Img,Link,none,Next):-
    image(Img,Link,Next),
    image(Next,_Nlink,_Nnext).
image(Img,Link,Previous,none):-
    image(Previous,_Plink,Img),
    image(Img,Link,_Next).
image(Img,Link,none,none):-
    image(Img,Link,_Next).
        
    


% Helper methods for the gallery

format_imgs([],[]).
format_imgs([H1|T1],[H2|T2]):- 
    http_absolute_location(gallery_images(H1), P, []),
    format(atom(A), '/gallery/~s', [H1]),    
    H2 = div(a([href=A],img([class(gallery_image),src(P),alt=H1]))),
    ([Next|_T] = T1 -> 
	 assertz(image(H1,P,Next));
     assertz(image(H1,P,none))),
    format_imgs(T1,T2).

    

    
previous_next_buttons(Previous, Next) -->
    {
	\+ Previous = none,
	\+ Next = none
    },
    html([    
		a([href=Previous],button(class([gallery_next_previous]),'Previous')),
		a([href=Next],button(class([gallery_next_previous]),'Next'))
 	    ]).
previous_next_buttons(_Previous, Next) -->
    {
	\+ Next = none
    },
    html([    
		a([href=Next],button(class([gallery_next_previous]),'Next'))
	    ]).
previous_next_buttons(Previous,_Next) -->
    {
	\+ Previous = none
    },
    html([    
		a([href=Previous],button(class([gallery_next_previous]),'Previous'))
	    ]).

reverse_list([]) --> [].
reverse_list([H|T]) --> reverse_list(T), [H].

display_gallery -->
    {
	directory_files('./static/gallery',F01),
	delete(F01,'.',F02),
	delete(F02,'..',F0),
	format_imgs(F0,F1),
	phrase(reverse_list(F1), F)
    },
    html(
	div(id(display),F)
    ).
