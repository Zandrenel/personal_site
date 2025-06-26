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
		    div(id(main),
			[
			    \life_blurb,
			    \passions,
			    \accomplishments,
			    \languages,
			    \frameworks,
			    \markup,
			    \skills
			    
			])
		]),
	    \footer
	]).


life_blurb --> html(
		   div(id(life), p( "Hello, My name is Alek."  ) )
		   ).

passions --> html( div(id(passions), p( "I am a full stack developer based in Canada with experience with cloud as IAAS and SAAS. I've always been one to tinker with various technologies and learn a bit of everything, which led quite honestly to this site being written in prolog or several other interests in networking, protocols, and the likes being explored. Lately in the realm of cloud I've been learning Terraform, and Proxmox. I'm hoping to use what I've learned and transform this site to use much more of a microservice model with each project being an easily spinnable microservice on a vm. I also have a passion in NLP and logic languages, building code to scale and not fail is something I enjoy a lot. Along with not failing code should be written to improve the life of the users in some aspect, which is why I believe strongly in accessibility features being readily available and that projects should have some purpose, even if educational. This site is still a work in progress but I hope as you browse it that you enjoy it!"  ) ) ).

accomplishments --> html( div(id(accomplishments), p( "Professionally I've experience developing infrastructure management tools for cloud service providers. The primary one I currently have experience with is the Scale Computing HC3 servers, though i have worked with powershell and active directory briefly. In this time I've closely maintained and expanded REST APIs and the user interfaces related, worked on security features, setup servers, implemented billing cycles, and polished a lot of UI flow loadtimes in an asyncronous one page application. I've learned a lot in my career and I'm always ambitious looking for new skills to gain."  ) ) ).

languages -->
    html([
		div([class([row,home_section])],[
			h3([class(lang_header)],'Languages'),
			div([class(row)],[
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/Prolog.png')]),'Prolog']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/Java.svg')]),'Java']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/JS.svg')]),'JS']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/TypeScript.png')]),'TS']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/Python.svg')]),'Python']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/CPlusPlus.svg')]),'C++']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/lisp.png')]),'Lisp']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/bash.png')]),'Bash']),
				div([class(lang_div)],[img([class(lang_img),src('/s/logos/powershell.png')]),'Powershell'])
			    ])
		    ])
	]).

frameworks -->
    html([
		div([class([row,home_section])],[
			h3([class(lang_header)],'Frameworks/Libraries'),
			div([class(row)],[
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/angular.png')]),'Angular']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/nodejs.png')]),'NodeJS']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/RxJS.png')]),'RxJS']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/flask.png')]),'Flask']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/sklearn.svg')]),'Sklearn']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/Java.svg')]),'JavaServlett']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/OpenCV.png')]),'OpenCV']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/nltk.webp')]),'NLTK']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/opengl_logo.png')]),'OpenGL'])
			      ])
		    ])
	    ]).

markup -->
    html([
		div([class([row,home_section])],[
			h3([class(lang_header)],'Markup'),
			div([class(row)],[
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/html.png')]),'HTML']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/css.svg')]),'CSS']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/bootstrap.png')]),'Bootstrap']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/markdown.png')]),'Markdown']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/latex.png')]),'Latex']),
				  div([class(lang_div)],[img([class(lang_img),src('/s/logos/org-mode.png')]),'Org'])		  
			      ])
		    ])
	    ]).

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


