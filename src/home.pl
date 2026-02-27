:- module(home,[
	      home_page/1
	      ]).

:- use_module(src/base_elements).

home_page(_Request) :-
    reply_html_page(
	[title('Home')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static('themes.css')),
	    \nav_bar,
	    div(id(content),
		[
		    div(id('home-navigator'),
			[
			    div([
				       a([href('#life-section'),class(['home-nav-a'])],
					 div([
						    id('life-nav'),
						    class(['home-nav'])],
					     life
					    )
					)
				   ]),
			    div([
				       a([href('#passions-section'),class(['home-nav-a'])],
					 div([
						    id('passions-nav'),
						    class(['home-nav'])],
					     passions
					    )
					)
				   ]),
			    div([
				       a([href('#work-section'),class(['home-nav-a'])],
					 div([
						    id('work-nav'),
						    class(['home-nav'])],
					     work
					    )
					)
				   ]),
			    div([
				       a([href('#skills-section'),class(['home-nav-a'])],
					 div([
						    id('skills-nav'),
						    class(['home-nav'])],
					     skills
					    )
					)
			    %% 	   ]),
			    %% div([
			    %% 	       a([href('#contact-section'),class(['home-nav-a'])],
			    %% 		 div([
			    %% 			    id('contact-nav'),
			    %% 			    class(['home-nav'])],
			    %% 		     contact
			    %% 		    )
			    %% 		)
				   ])
				
			]),
		    div(id(main),
			[
			    section([id('life-section'),
				     class(['home-section'])],
				    [
					\life_blurb_header,
					\life_blurb
				    ]),
			    section([id('passions-section'),
				     class(['home-section'])],[
					\passions_header,
					\passions
				    ]),
			    section([id('work-section'),
				     class(['home-section'])],[
					\work_header,
					\work
				    ]),
			    section([id('skills-section'),
				     class(['skills-section'])],
				    [\languages,
				     \language_header_blurb
				     %% \skills
			    %% 	    ]),
			    %% section([class(['home-section'])],[
			    %% 		\contact_me
				    ])			    
			])
		]),
	    \footer
	]).

life_blurb_header --> html(
			  div([
				     id('life-header'),
				     class(['home-section-header'])
				 ],
			      p( "Hello, my name is Alek."  ) )
		      ).

life_blurb --> html(
		   div([id(life),
			class(['home-section-body'])],
		       p( "I am a developer currently based in Quebec as of current. I've studied computer science at Concordia University in Montreal where I had a lot of molding experiences for myself as a developer, including the one that caused this site to be written in Prolog. I believe that technology should be accessible and not be there to worsen the life of those of us who truly exist. That said this website is organically grown. We as humans have intent when we make an action, this intent can make something meaningful or meaningless, and this ability is something priceless."  ) )
		   ).
passions_header --> html( div([id('passions-header'),class(['home-section-header'])], p( "Some things I'm interested in."  ) ) ).

passions --> html( div([id(passions),
			class(['home-section-body'])],
		       p( "I've got the inability to not pick up new hobbies, though at least they stick... some that never falter are coffee, programming, cooking, and tcgs. I've got a Pre-millenium La Pavoni Europiccola which I love dearly, plus a collection of several other coffee brew methods. I'm always looking for something to learn or work on when it comes to programming, right now I'm on a kick of learning more about architecture and the basics for REST api development in as many languages as I can. I have been looking into more health based meals and meal planning lately too, though I'll be adding any sort of recipe to this site slowly. I even love taking care of plants, though its usually just a tomato plant and basil which I keep on the porch in the summer."  ) ) ).

work_header --> html( div([id('work-header'),class(['home-section-header'])], p( "What I've done.") ) ).

work --> html(div([id(work),
		   class(['home-section-body'])],
		  p( "In my professional career I've worked as a Full Stack Developer so far at Oriso Solutions for 3 years. There I helped build a few products, the main one was IC3, a hypervisor infrastructure management platform. It had capabilities to manage Proxmox or Scale HC3 Hypervisors, create virtual machines, interact with the console through NoVNC, or easily allow you to have customers buy virtual machines from you. The project was very interesting, I got to learn a lot about virtualization, about application architecture, APIs, interface design, and building accessible dynamica applications. I've also worked on Talishar, an open source application used by thousands per day worldwide for playing the card game Flesh and Blood." ) ) ).

language_header_blurb -->
    html([
	 	p([id(language_header_blurb)],[
			'These are a few of the things I know or have worked with.'
		    ])]).
languages -->
    html([
	 	div([class([row])],[
			h3([class(lang_header)],'Languages'),
			div([id(rotator)],
			    div([class([row])],[
				    div([id(prolog),class(lang_div)],[img([class(lang_img),src('/s/logos/Prolog.png')])]),
				    div([id(java),class(lang_div)],[img([class(lang_img),src('/s/logos/Java.svg')])]),
				    div([id(js),class(lang_div)],[img([class(lang_img),src('/s/logos/JS.svg')])]),
				    div([id(ts),class(lang_div)],[img([class(lang_img),src('/s/logos/TypeScript.png')])]),
				    div([id(python),class(lang_div)],[img([class(lang_img),src('/s/logos/Python.svg')])]),
				    div([id(cplusplus),class(lang_div)],[img([class(lang_img),src('/s/logos/CPlusPlus.svg')])]),
				    div([id(lisp),class(lang_div)],[img([class(lang_img),src('/s/logos/lisp.png')])]),
				    div([id(bash),class(lang_div)],[img([class(lang_img),src('/s/logos/bash.png')])]),
				    div([id(powershell),class(lang_div)],[img([class(lang_img),src('/s/logos/powershell.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/angular.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/nodejs.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/RxJS.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/flask.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/sklearn.svg')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/Java.svg')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/OpenCV.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/nltk.webp')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/opengl_logo.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/html.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/css.svg')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/bootstrap.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/markdown.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/latex.png')])]),
				    div([class(lang_div)],[img([class(lang_img),src('/s/logos/org-mode.png')])])		  
				])
			   )
		    ])
	    ]).

% Not used for now but we'll see
skills -->
    html([
		div([class([row,home_section])],[

			h3([class(lang_header)],'Skills'),
			div([class(row)],[
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/linux.png')]),'Linux']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/windows.png')]),'Windows']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/terminal.webp')]),'CLI']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/git.png')]),'Git']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/emacs.png')]),'Emacs'])
			      ])
		    ])
	    ]).
% Not used but will add eventually
contact_me -->
    html([
		div(['You can contact me at X'])
	    ]).
