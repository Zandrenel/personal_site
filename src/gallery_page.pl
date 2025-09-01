:- module(gallery_page,[gallery/1, gallery/2]).

:- dynamic
       image/3.

gallery(_Request) :-
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 h1([style='text-align:center;'],['Gallery of Tiddles']),
	 \display_gallery,
	\footer]
    ).
    

gallery(IMG,_Request) :-
    image(IMG,Link,Next,Previous),
    reply_html_page(
	[title('Gallery')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
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
    format(atom(A), '~s.jpg', [H1]),
    format(atom(AL), '/gallery/~s.jpg', [H1]),
    format(atom(AF), 'fullsize/~s.jpg', [H1]),    
    format(atom(AT), 'thumbnail/~s-thumbnail.jpg', [H1]),
    http_absolute_location(gallery_images(AT), P, []),
    http_absolute_location(gallery_images(AF), P1, []),
    H2 = div(a([href=AL],img([class(gallery_image),src(P),alt=AL]))),
    ([Next|_T] = T1 ->
	 (
	     format(atom(N), '~s.jpg', [Next]),
	     assertz(image(A,P1,N)));           
     assertz(image(A,P1,none))),
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

img_diff([],_,[]).
img_diff([H|T],S1,Diff):-
    member(H,S1),
    img_diff(T,S1,Diff).
img_diff([H|T],S1,[H|T2]):-
    img_diff(T,S1,T2).

display_gallery -->
    {
	directory_files('./static/gallery/fullsize',F01),
	delete(F01,'.',F02),
	delete(F02,'..',F0),
	maplist(strip_suffix(".jpg"),F0,Stri0),
	directory_files('./static/gallery/thumbnail',T01),
	delete(T01,'.',T02),
	delete(T02,'..',T0),
	maplist(strip_suffix("-thumbnail.jpg"),T0,Stri1),
	img_diff(Stri0,Stri1,Diff),
	maplist(convert_to_thumbnail,Diff),
	format_imgs(Stri0,F1),
	phrase(reverse_list(F1), F)
    },
    html(
	div(id(display),F)
    ).

convert_to_thumbnail(Img):-
    format(atom(Thumbnail), './static/gallery/thumbnail/~s-thumbnail.jpg', [Img]),
    format(atom(Fullsize), './static/gallery/fullsize/~s.jpg', [Img]),
    process_create(path(ffmpeg),
		   [
		       '-i',
		       Fullsize,
		       '-vf',
		       'scale=200:266',
		       Thumbnail
		   ],
		   []).


strip_suffix(Suff0,Word0,Rem0):-
    atom_chars(Word0,Word),
    atom_chars(Suff0,Suff),
    append(Rem,Suff,Word),
    atom_chars(Rem0,Rem).

