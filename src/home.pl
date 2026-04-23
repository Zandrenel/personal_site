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
		       ])		  
		]),
	    div(id(main),
		[
		  section([id('elevator-section')],
			  [				
			    \life_blurb
			  ]),
		  \life,
		  \passions,
		  \work,
		  \skills,
		  \back_to_top
		])
	  ]),
      \footer
    ]).

life_blurb --> html([
		       div([],[
			     p([class(["sub-title-life"])],["generalist cause I have too many interests..."]),
			     h1(id(intro_prolog_query),"?- my_name(Alek)."),
			     p(id(intro_prolog_answer),"true."),
			     p([class(["intro"])],["Hello, my name is Alek and I'm a full stack developer. I've studied computer science at Concordia University in Montreal where I had a lot of molding experiences for myself as a developer, including the one that caused this site to be written in Prolog. I believe that technology should be accessible and not be there to worsen the life of those of us who truly exist. That said this website is organically grown. We as humans have intent when we make an action, this intent can make something meaningful or meaningless, and this ability is something priceless."])
			   ])		      
		     ]).

life --> html([
		 section([id('life-section'),
			  class(["home-section"])],[
			   div([class("section-inner")],[
				 div([
					id('life-header'),
					class(['home-section-header'])
				      ],[
				       p([class(["section-label"])],["01 / life"]),
				       h2("Some personal tenants.")
				     ]),
				 div([
					id("life"),
					class(["home-section-body"])
				      ],
				     [
				       div([class(["grid"])],[
					     article([class(["card"])],[h3([span([class(["spark"])],[]),"Strive to learn"]),p(["There is always something that you don't know, and truly the most unfair thing around is not being able to learn everything."])]),
					     article([class(["card"])],[h3([span([class(["spark"])],[]),"Community"]),p(["We're all better when we are there to help each other when we need the help."])]),
					     article([class(["card"])],[h3([span([class(["spark"])],[]),"Accessiblity"]),p(["Conscious design that considers everyone only makes the internet a better place to be."])]),
					     article([class(["card"])],[h3([span([class(["spark"])],[]),"Efficiency and Simplicity"]),p(["Don't overcomplicate things, and find efficient solutions when able."])])
					   ])
				     ])
			       ])
			 ])
	       ]).

passions --> html([
		     section([id('passions-section'),
			      class(["home-section"])],[
			       div([class("section-inner")],[
				     div([
					    id('passions-header'),
					    class(['home-section-header'])
					  ],[
					   p([class(["section-label"])],["02 / passions"]),
					   h2("Some things I'm interested in.")
					 ]),
				     div([
					    id("passions"),
					    class(["home-section-body"])
					  ],
					 [
					   div([class(["grid"])],[
						 article([class(["card"])],[h3([span([class(["spark"])],[]),"Technology"]),p(["I've loved technology since I was young. Always facinated with not only using it but how it worked, so once able I started to try to demystify it in its entirety leading to a Bachelors in Computer Science."])]),
						 article([class(["card"])],[h3([span([class(["spark"])],[]),"Cooking"]),p(["Whether its italian family recipes, sourdough, or a batch of midnight pizzelles. I enjoy the process, the learning, and the creation of delicious meals that can be shared with others."])]),
						 article([class(["card"])],[h3([span([class(["spark"])],[]),"TCGs"]),p(["14+ years of playing MTG, 5 of playing FaB, a hobby I've truly cherished not only for the entertainment but for the community. No matter where in the world you may move, its one hobby that can likely help you meet a few people."])]),
						 article([class(["card"])],[h3([span([class(["spark"])],[]),"Coffee"]),p(["A multifaceted hobby, the coffee itself? A full on reason to enjoy it of course, but the mechanical intertwining when it comes to espresso machine assembly is a strong point. There's also the cultural aspect, every brew method has its history, fond memories and ways its most commonly enjoyed within its originating culture. The community part of it of course too, where coffee has been almost unamiously associated with hospitality between cultures across the globe."])])
					       ])
					 ])
				   ])
			     ])
		   ]).

work --> html([
		 section([id('work-section'),
			  class(["home-section"])],[
			   div([class("section-inner")],[
				 div([
					id('work-header'),
					class(['home-section-header'])
				      ],[
				       p([class(["section-label"])],["03 / work"]),
				       h2("Some things I've done.")
				     ]),
				 div([
					id("work"),
					class(["home-section-body"])
				      ],
				     [
				       div([class(["grid"])],[
					     article([class(["card"])],[h3([span([class("spark")],[]),"Oriso Solutions"]),p(["3+ years working as a full stack developer creating cloud solutions. I've worked in a small team, delivering features through agile methods, interacting with clients, and contributing with client features."])]),
					     article([class(["card"])],[h3([span([class("spark")],[]),"Oriso - IC3"]),p(["A hypervisor management and providing system. It allowed the parallel provisioning of Proxmox and Scale HC3 clusters, management, reporting, and multi-tenant providing. I implemented Stripe powered billing features, customer onboarding, and multi level user and organization access."])]),
					     article([class(["card"])],[h3([span([class("spark")],[]),"Talishar.net"]),p(["Open source FaB TCG game engine. Used by thousands of unique users daily and a cornerstone of the community in its niche corner."])]),
					     article([class(["card"])],[h3([span([class("spark")],[]),"Personal Projects"]),p(["I've always got something going on. Between personal projects its between a grocery store price comparator, prolog LLM agent, book rater, self provisioning lambda function system, and more... "])])
					   ])
				     ])
			       ])
			 ])
	       ]).

skills --> html([
		   section([id('skills-section'),
			    class(["home-section"])],[
			     div([class("section-inner")],[
				   div([
					  id('skills-header'),
					  class(['home-section-header'])
					],[
					 p([class(["section-label"])],["04 / skills"]),
					 h2("Some tools I know.")
				       ]),
				   div([
					  id("skills"),
					  class(["home-section-body"])
					],
				       [
					 div([class(["toolbox"])],[
					       span([class(["tool"])],[img([src('/s/logos/Prolog.png')]),"Prolog"]),
					       span([class(["tool"])],[img([src('/s/logos/Java.svg')]),"Java"]),
					       span([class(["tool"])],[img([src('/s/logos/JS.svg')]),"JS"]),
					       span([class(["tool"])],[img([src('/s/logos/TypeScript.png')]),"TypeScript"]),
					       span([class(["tool"])],[img([src('/s/logos/Python.svg')]),"Python"]),
					       span([class(["tool"])],[img([src('/s/logos/CPlusPlus.svg')]),"CPlusPlus"]),
					       span([class(["tool"])],[img([src('/s/logos/lisp.png')]),"lisp"]),
					       span([class(["tool"])],[img([src('/s/logos/bash.png')]),"bash"]),
					       span([class(["tool"])],[img([src('/s/logos/powershell.png')]),"powershell"]),
					       span([class(["tool"])],[img([src('/s/logos/angular.png')]),"angular"]),
					       span([class(["tool"])],[img([src('/s/logos/nodejs.png')]),"nodejs"]),
					       span([class(["tool"])],[img([src('/s/logos/RxJS.png')]),"RxJS"]),
					       span([class(["tool"])],[img([src('/s/logos/flask.png')]),"flask"]),
					       span([class(["tool"])],[img([src('/s/logos/sklearn.svg')]),"sklearn"]),
					       span([class(["tool"])],[img([src('/s/logos/Java.svg')]),"Java"]),
					       span([class(["tool"])],[img([src('/s/logos/OpenCV.png')]),"OpenCV"]),
					       span([class(["tool"])],[img([src('/s/logos/nltk.webp')]),"nltk"]),
					       span([class(["tool"])],[img([src('/s/logos/opengl_logo.png')]),"opengl"]),
					       span([class(["tool"])],[img([src('/s/logos/html.png')]),"html"]),
					       span([class(["tool"])],[img([src('/s/logos/css.svg')]),"css"]),
					       span([class(["tool"])],[img([src('/s/logos/bootstrap.png')]),"bootstrap"]),
					       span([class(["tool"])],[img([src('/s/logos/markdown.png')]),"markdown"]),
					       span([class(["tool"])],[img([src('/s/logos/latex.png')]),"latex"]),
					       span([class(["tool"])],[img([src('/s/logos/org-mode.png')]),"org-mode"])
					     ])
				       ])
				 ])
			   ])
		 ]).

back_to_top --> 
    html([
		a([href('#'),id('back-to-top')],
		  div([id('back-to-top-style')],
		      "Top"
		     )
		 )
	    ]).   
