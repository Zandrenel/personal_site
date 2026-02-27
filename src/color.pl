:- module(color, [
	      colors/2,
	      selector/2
	      ]).

colors('','Default').
colors('noName','No Name').
colors('ArtsAndCrafts','Arts and Crafts').
colors('MeltedIceCream','Melted Ice Cream').
colors('MidnightSwim','Midnight Swim').
colors('PowerUp','Power Up').
colors('SunKissedRock','Sunkissed Rock').
colors('twilightStreet','Twilight Street').





selector -->
    {
	findall(Color, colors(Color, _), ThemeNames),
	maplist(as_selector_inputs, ThemeNames, Options)
    },
    html([
		div(select([onchange="changeTheme(this.value)",name('theme'),id('theme')],Options)),
		\theme_script
	    ]).


theme_script -->
    html(script(type('text/javascript'),
		[
		    {|javascript(_)||
		      (function(){
			   const oldTheme = localStorage.getItem('theme');
			   document.documentElement.setAttribute('data-theme',oldTheme );
			   document.getElementById('theme').value = oldTheme;
						    
})();
		      function changeTheme(theme){
		 	console.log(theme);
		        document.documentElement.setAttribute('data-theme', theme);
			localStorage.setItem('theme', theme);	
		     }|}
		])).

as_selector_inputs(Theme, option([ value(Theme)],[Name])):-
    colors(Theme,Name).
    
