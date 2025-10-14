:- module(cooking,[
	      cooking/1
	      ]).

:- use_module(src/base_elements).


cooking(_Request) :-
    reply_html_page(
	[title('Cooking')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static('themes.css')),
	    \nav_bar,
	    div(id(content),
		[
		    div(id(main),
			[
			 \in_construction
			])
		]),
	    \footer
	]).



/**
 * So the goal here is to declare recipes as atoms, then have the page generate lists
 * of recipes, each may have its own dynamically generated page as well
 * each recipe will have a preview which will include the name, author, tags
 * 
 */

% recipe(Name, Author, Tags<string>[], portions, ingredients<ingredient/2>[], directions<string>[])
% ingredient(name, quantity)

recipe('Gnocci',
       'Italia Rossi',
       [pasta, italian, potato, family],
       2,
       [ingredient(potato,2),ingredient(flour,cups(2)), ingredient(eggs,2)],
       ['Peel then boil one potato per person',
	'Mash the potato then let them cool in the fridge overnight',
	'Combine the cooled potato with flour and 2 eggs, keep doing so until its a slightly rough texture, there should be more potato than flour',
	'Roll kneaded dough into a ball, cover in plastic wrap to rest for half an hour',
	'Divide the dough into sections',
	'Roll section into a long snake shape, cut into smaller pieces, then roll each piece with your thumb into a curled shape, repeat for every section',
	'Keep coated with some flour to stop sticking, either boil immediately until they\'re floating and you can eat them or freeze them in a ziplock with some extra flour']).

