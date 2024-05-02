:- module(color, [
	      colors/2,
	      colors/3,
	      selector/2
	      ]).

colors(Color,Theme):-
    colors(Color,Theme,_).

active(street).
colors(red,'PowerUp','PowerUp').
colors(art,'ArtsAndCrafts','ArtsAndCrafts').
colors(icecream,'MeltedIceCream','MeltedIceCream').
colors(sunkissed,'SunKissedRock','SunKissedRock').
colors(midnight,'MidnightSwim','MidnightSwim').
colors(street,'twilightStreet','twilightStreet').
colors(_,'base_colors','base_colors').



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

as_selector_inputs(Color, option([ value(Theme)],[Name])):-
    colors(Color,Theme,Name).
    
