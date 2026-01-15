:- module(cooking,[
	      cooking/1
	      ]).

:- use_module(src/base_elements).


cooking(_Request) :-
    findall(recipe(N,A,T,P,I,D),recipe(N,A,T,P,I,D),Recipes),
    format_recipes(Recipes,FormattedRecipes),
    reply_html_page(
	[title('Cooking')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static('themes.css')),
	    \nav_bar,
	    div(id(content),
		[
		    div([id(main),class(recipe_main)],			
			 FormattedRecipes
			)
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





format_recipes([],[]).
format_recipes([H1|T1],[H2|T2]):-
    format_recipe(H1,H2),
    format_recipes(T1,T2).

format_recipe(recipe(Name, Author, Tags, Servings, Ingredients, Directions), RecipeCard) :-
    format_tags(Tags, TagList),
    format_ingredients(Ingredients, IngredientList),
    format_directions(Directions, DirectionList),
    RecipeCard = div([class(recipe_card)],[
			  div([class(['recipe_card_header'])],[
				  b(Name),
				  ': ',
				  Author,
				  ' - Serves ',
				  Servings
			      ]),
			  div([class(['recipe_card_tag_container'])],
				  TagList
			      ),
			  div([class(['recipe_card_ingredients'])],
				  ul(IngredientList)
			      ),
			  div([class(['recipe_card_directions'])],
				  ol(DirectionList)
			      )
		     ]).

format_tags([],[]).
format_tags([H|T1],[span([class([tag])],[H])|T2]):-
    format_tags(T1,T2).

format_ingredients([],[]).
format_ingredients([ingredient(Name,cups(Quantity))|T1],[li([class([ingredient])],[Quantity,' cups of ',Name])|T2]):-
    format_ingredients(T1,T2).
format_ingredients([ingredient(Name,pounds(Quantity))|T1],[li([class([ingredient])],[Quantity,' lbs of ',Name])|T2]):-
    format_ingredients(T1,T2).
format_ingredients([ingredient(Name,Quantity)|T1],[li([class([ingredient])],[Quantity,' ',Name])|T2]):-
    format_ingredients(T1,T2).

format_directions([],[]).
format_directions([H|T1],[li([class([direction])],[H])|T2]):-
    format_directions(T1,T2).

test :-
    findall(recipe(N,A,T,P,I,D),recipe(N,A,T,P,I,D),Recipes),
    format_recipes(Recipes,FormattedRecipes),
    write(FormattedRecipes).
	      
	      
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

recipe('Breaded Veal',
       'Italia Rossi',
       [meat, italian, oven, family],
       2,
       [ingredient('thinly cut veal slices' ,4),ingredient(flour,cups(1)), ingredient(eggs,1), ingredient('olive oil',drizzle),ingredient(breadcrumbs,cups(1))],
       [
	   'Preheat the oven to 400 degrees farenheit.',
	   'Pour into 3 separate bowls/plates flour, the egg (mixed), and breadcrumbs.',
	   'Take a slice of veal then first pat it into the flour, then drench it into the egg, then cover it in the breadcrumbs, put it on a parchment paper covered baking sheet, repeat for every slice of veal.',
	   'Drizzle the veal slices with olive oil.',
	   'Bake until crispy, flip at some point.',
	   'Either add tomato sauce and cheese for veal parmesean or add to pasta or serve however else preferred.'
       ]).

recipe('Meatloaf',
       'Italia Rossi',
       [meat, italian, oven, family],
       2,
       [ingredient('Big 3 meat mixture(Veal, Beef, Pork)' ,pounds(1)),ingredient('Blended Vegtables (any)',cups(1)), ingredient('eggs',2), ingredient('hardboiled eggs',3), ingredient('Bread in milk or breadcrumbs depending on dryness',1),ingredient(caicotta,cup(1))],
       [
	   'Preheat the oven to 400 degrees farenheit.',
	   'Choose your vegtables, some good choices are onions, garlic, celery, tomatoes, then blend them up.',
	   'Add your meat mixture + any spices + your vegtables, the 2 eggs, mix',
	   'Add in the cheese to your mixture, then depending on moisture add in bread soaked in milk or breadcrumbs until its stiffer',
	   'Add to your loafpan, you may put 3 hardboiled eggs in the middle of your meat in the loafpan.',
	   'Add to the oven then bake until brown and crispy, likely 20-ish minutes or so, maybe more.'
       ]).

recipe('Beef and Spinach',
       'Lydia Saad',
       ['family', meat, rice],
       2,
       [ingredient('beef' ,pounds('1/2')),
	ingredient('spinach','2 bags'),
	ingredient('onion',1),
	ingredient('allspice','little'),
	ingredient('tomato paste','a bit'),
	ingredient('lime',1),
	ingredient('pine nuts',cups('1/2'))],
       [
	   'Cut tails from each spinach then in half.',
	   'Dice the onion.',
	   'Cook the onion and beef together.',
	   'Add pine nuts',
	   'Add in tomato paste to sautee it a little',
	   'Add in the allspice.',
	   'Add in the spinach, cook until wilted.',
	   'Serve over white rice.'
       ]).


