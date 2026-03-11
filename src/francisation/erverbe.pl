
:- module(erverbe,
	  [
	      erverbe/1
	  ]).


erverbe(_Request) :-
    reply_html_page(
	[title('Défi 30 Questions - Francisation Niveau 2')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 div(id(main),
	     [
		 \htmlBlock,
		 \javascriptBlock
	     ]
	    ),
	 \footer
	]).



javascriptBlock -->
    html([
		\js_script({|javascript(_)||
			     
			     const questions = [
				 { id: 1, text: "Le matin, je (manger) ___ un croissant (à/au) ___ café.", answer: "mange", extra: "au" },
				 { id: 2, text: "Tu (marcher) ___ (dans/au) ___ parc tous les lundis.", answer: "marches", extra: "dans le" },
				 { id: 3, text: "Nous (déjeuner) ___ (à/chez) ___ 7h00 du matin.", answer: "déjeunons", extra: "à" },
				 { id: 4, text: "Elle (dîner) ___ (à/en) ___ cafétéria avec ses collègues.", answer: "dîne", extra: "à la" },
				 { id: 5, text: "Vous (souper) ___ (à/chez) ___ restaurant le samedi soir.", answer: "soupez", extra: "au" },
				 { id: 6, text: "Ils (regarder) ___ la télévision (dans/sur) ___ salon.", answer: "regardent", extra: "dans le" },
				 { id: 7, text: "J' (écouter) ___ la radio (pendant/à) ___ le trajet.", answer: "écoute", extra: "pendant" },
				 { id: 8, text: "Mon mari (cuisiner) ___ un bon plat (dans/à) ___ cuisine.", answer: "cuisine", extra: "dans la" },
				 { id: 9, text: "Vous (travailler) ___ (à/au) ___ centre-ville de Montréal.", answer: "travaillez", extra: "au" },
				 { id: 10, text: "Elle (téléphoner) ___ (à/avec) ___ sa mère le dimanche.", answer: "téléphone", extra: "à" },
				 { id: 11, text: "Nous (étudier) ___ le français (à/en) ___ bibliothèque.", answer: "étudions", extra: "à la" },
				 { id: 12, text: "Les enfants (jouer) ___ (au/à) ___ soccer après l'école.", answer: "jouent", extra: "au" },
				 { id: 13, text: "Tu (parler) ___ (à/avec) ___ ton voisin ce matin.", answer: "parles", extra: "à" },
				 { id: 14, text: "Je (lire) ___ un journal (à/sur) ___ le balcon.", answer: "lis", extra: "sur" },
				 { id: 15, text: "Vous (aller) ___ (à/au) ___ épicerie le vendredi.", answer: "allez", extra: "à l'" },
				 { id: 16, text: "Il (faire) ___ du sport (à/au) ___ gymnase.", answer: "fait", extra: "au" },
				 { id: 17, text: "Nous (avoir) ___ rendez-vous (à/chez) ___ médecin à 10h.", answer: "avons", extra: "chez le" },
				 { id: 18, text: "Elles (être) ___ (en/à) ___ retard pour le cours.", answer: "sont", extra: "en" },
				 { id: 19, text: "Je (dormir) ___ (jusqu'à/à) ___ 8h00 le week-end.", answer: "dors", extra: "jusqu'à" },
				 { id: 20, text: "Tu (prendre) ___ le bus (à/au) ___ coin de la rue.", answer: "prends", extra: "au" },
				 { id: 21, text: "Nous (marcher) ___ (sur/dans) ___ le trottoir.", answer: "marchons", extra: "sur" },
				 { id: 22, text: "Vous (regarder) ___ les oiseaux (par/dans) ___ la fenêtre.", answer: "regardez", extra: "par" },
				 { id: 23, text: "Il (écouter) ___ son professeur (en/à) ___ classe.", answer: "écoute", extra: "en" },
				 { id: 24, text: "Je (cuisiner) ___ pour mes amis (à/chez) ___ moi.", answer: "cuisine", extra: "chez" },
				 { id: 25, text: "Elles (étudier) ___ (pendant/à) ___ deux heures.", answer: "étudient", extra: "pendant" },
				 { id: 26, text: "Tu (parler) ___ français (à/au) ___ Québec.", answer: "parles", extra: "au" },
				 { id: 27, text: "Nous (aller) ___ (à/en) ___ France cet été.", answer: "allons", extra: "en" },
				 { id: 28, text: "Il (faire) ___ la vaisselle (après/avant) ___ le souper.", answer: "fait", extra: "après" },
				 { id: 29, text: "Vous (avoir) ___ faim (à/vers) ___ midi.", answer: "avez", extra: "vers" },
				 { id: 30, text: "Ils (être) ___ fatigués (le/à) ___ soir.", answer: "sont", extra: "le" }
			     ];
			     
			     function initQuiz() {
				 const container = document.getElementById('quiz-container');
							    container.innerHTML = questions.map((q, index) => `
												<div class="p-4 bg-gray-50 rounded-lg border border-gray-200">
												<p class="text-lg text-gray-800 mb-2">
												<span class="font-bold text-blue-600">${index + 1}.</span> ${q.text}
																			   </p>
												<div class="flex flex-wrap gap-2">
												<input type="text" id="q-${q.id}" placeholder="Verbe" class="p-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
												<input type="text" id="e-${q.id}" placeholder="Préposition/Lien" class="p-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
												</div>
												<p id="f-${q.id}" class="feedback text-green-600 font-medium italic">Réponse: ${q.answer} / ${q.extra}</p>
												</div>
												`).join('');
			     }
			     
			     function checkAnswers() {
				 let score = 0;
				 questions.forEach(q => {
						       const inputVerbe = document.getElementById(`q-${q.id}`);
										   const inputExtra = document.getElementById(`e-${q.id}`);
													       const feedback = document.getElementById(`f-${q.id}`);
																	 
																	 const isVerbeCorrect = inputVerbe.value.trim().toLowerCase() === q.answer.toLowerCase();
																										   const isExtraCorrect = inputExtra.value.trim().toLowerCase() === q.extra.toLowerCase();
																																			    
																																			    if (isVerbeCorrect) inputVerbe.classList.add('correct');
																																								     else inputVerbe.classList.add('incorrect');
																																											       
																																											       if (isExtraCorrect) inputExtra.classList.add('correct');
																																																	else inputExtra.classList.add('incorrect');
																																																				  
																																																				  if (isVerbeCorrect && isExtraCorrect) score++;
																																																				  feedback.style.display = 'block';
						   });
					   
					   const finalScore = document.getElementById('final-score');
								       finalScore.classList.remove('hidden');
											    finalScore.textContent = `Votre score : ${score} / ${questions.length}`;
												       finalScore.className = score > 20 ? 'mt-6 p-4 text-center rounded-lg font-bold text-xl bg-green-100 text-green-700' : 'mt-6 p-4 text-center rounded-lg font-bold text-xl bg-orange-100 text-orange-700';
														  
														  window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
			     }
			     
			     function resetQuiz() {
				 initQuiz();
				 document.getElementById('final-score').classList.add('hidden');
										  window.scrollTo({ top: 0, behavior: 'smooth' });
			     }
			     
			     window.onload = initQuiz; 
			    |})
	    ]).

htmlBlock --> 
    html({|html(_)||
	       <script src="https://cdn.tailwindcss.com"></script>
	       <style>
               body {
		   background-color: #f8fafc;
		   font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
               }
              .correct { border-color: #10b981; background-color: #ecfdf5; }
              .incorrect { border-color: #ef4444; background-color: #fef2f2; }
              .feedback { display: none; margin-top: 0.5rem; font-size: 0.875rem; }
	       </style>

	       <body class="">
	       <div class="max-w-4xl mx-auto bg-white shadow-lg rounded-xl overflow-hidden">
               <header class="bg-blue-600 p-6 text-white text-center">
               <h1 class="text-2xl font-bold uppercase tracking-wide">Ma routine au présent</h1>
               <p class="mt-2 text-blue-100">Complétez les phrases avec le bon verbe et les prépositions appropriées.</p>
               </header>
	       
               <div class="p-6">
               <div id="quiz-container" class="space-y-6">
               <!-- Les questions seront injectées ici par JS -->
		   </div>
		   
		   <div class="mt-8 flex flex-col sm:flex-row gap-4 justify-center border-t pt-8">
                   <button onclick="checkAnswers()" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-lg transition duration-200">
                   Vérifier mes réponses
                   </button>
                   <button onclick="resetQuiz()" class="bg-gray-200 hover:bg-gray-300 text-gray-700 font-bold py-3 px-8 rounded-lg transition duration-200">
                   Recommencer
                   </button>
		   </div>
		   
		   <div id="final-score" class="hidden mt-6 p-4 text-center rounded-lg font-bold text-xl"></div>
		   </div>
		   </div>
		   |}).
