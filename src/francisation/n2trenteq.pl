
:- module(n2trenteq,
	  [
	      n2trenteq/1
	  ]).


n2trenteq(_Request) :-
    reply_html_page(
	[title('Défi 30 Questions - Francisation Niveau 2')],
	[\html_requires(static('styles.css')),
	 \html_requires(static('themes.css')),
	 \nav_bar,
	 div(id(main),
	     [\htmlBlock,
	     \javascriptBlock]
	    ),
	 \footer
	]).



javascriptBlock -->
    html([
		
		\js_script({|javascript(_)||
			     // Configuration des questions
			     // Note: Pour les adjectifs, on accepte souvent l'index 0 (Il fait) et 1 (C'est)
			   const questions = [
			       { q: "Dehors, _______ beau aujourd'hui.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "_______ du soleil à Montréal.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [2] },
			       { q: "Regarde ! _______ beaucoup maintenant.", options: ["Il fait", "Il y a", "Il pleut", "C'est"], correct: [2] },
			       { q: "En ce moment, _______ l'hiver au Québec.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [2] },
			       { q: "_______ froid ce matin : il fait -20°C.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Dans le ciel, _______ des nuages gris.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [2] },
			       { q: "En janvier, _______ souvent (verbe).", options: ["Il fait", "Il neige", "Il y a", "C'est"], correct: [1] },
			       { q: "L'air est lourd, _______ humide.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Sur le fleuve, _______ du vent.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [2] },
			       { q: "Regarde le ciel bleu ! _______ une belle journée.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [2] },
			       { q: "Le matin, _______ du brouillard.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Ferme les fenêtres ! _______ un orage.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [2] },
			       { q: "Près du radiateur, _______ chaud.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Attention ! _______ glissant sur la rue.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [2] },
			       { q: "Écoute ! _______ du tonnerre.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Au printemps, _______ frais.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Pendant l'orage, _______ de la grêle.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Aujourd'hui, le ciel _______ gris.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [0, 2] },
			       { q: "Quand il y a du verglas, _______ dangereux.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [2] },
			       { q: "Sur le lac, _______ de la glace.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Ce matin, _______ du verglas.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Aujourd'hui, _______ doux dehors.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Préparez les pelles ! _______ une tempête.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Le temps est couvert, _______ nuageux.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "_______ l'automne : les feuilles sont rouges.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [2] },
			       { q: "_______ de l'humidité dans la cave.", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "_______ du soleil, on va au parc ?", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] },
			       { q: "Sur la côte, _______ souvent venteux.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "En décembre, _______ sombre très tôt.", options: ["Il fait", "C'est", "Il y a", "Il"], correct: [0, 1] },
			       { q: "Oh ! _______ un bel arc-en-ciel !", options: ["Il fait", "Il y a", "C'est", "Il"], correct: [1] }
			   ];
			   
			   let currentQuestion = 0;
			   let score = 0;
			   
			   function loadQuestion() {
			       const q = questions[currentQuestion];
			       document.getElementById('question-text').innerText = q.q;
										      const container = document.getElementById('options-container');
														 container.innerHTML = '';
															   document.getElementById('feedback-area').classList.add('hidden');
																					      
																					      document.getElementById('question-counter').innerText = `Question ${currentQuestion + 1} / 30`;
																											  document.getElementById('progress').style.width = `${((currentQuestion + 1) / 30) * 100}%`;
																																    
																																	    q.options.forEach((opt, index) => {
																																				  const btn = document.createElement('button');
																																						       btn.className = "option-btn w-full p-4 text-left border-2 border-gray-200 rounded-xl hover:border-blue-400 hover:bg-blue-50 transition-all font-medium text-gray-700";
																																							   btn.innerText = opt;
																																							       btn.onclick = () => checkAnswer(index);
																																								   container.appendChild(btn);
																																			      });
			   }
			   
			   function checkAnswer(choice) {
			       const q = questions[currentQuestion];
			       const correctIndices = q.correct;
							const btns = document.querySelectorAll('.option-btn');
									      const msg = document.getElementById('feedback-message');
												   
												   btns.forEach(btn => btn.disabled = true);
													
													if (correctIndices.includes(choice)) {
													    btns[choice].classList.add('bg-green-100', 'border-green-500', 'text-green-800');
																   
																   // Si les deux étaient possibles, on le mentionne
																				     if (correctIndices.includes(0) && correctIndices.includes(1)) {
																					 msg.innerHTML = "<span class='text-green-600'>Excellent ! ✅ (Note : 'Il fait' et 'C'est' sont tous les deux corrects ici)</span>";
																				     } else {
																					 msg.innerHTML = "<span class='text-green-600'>Excellent ! ✅</span>";
																				     }
																   
																				     score++;
																   document.getElementById('score-display').innerText = `Score : ${score}`;
													} else {
													    btns[choice].classList.add('bg-red-100', 'border-red-500', 'text-red-800');
																   
																   // Highlight all correct answers
																      correctIndices.forEach(idx => {
																				 btns[idx].classList.add('bg-green-50', 'border-green-500');
																			     });
																		     
																		     const answers = correctIndices.map(idx => q.options[idx]).join(' ou ');
																									       msg.innerHTML = `<span class='text-red-600'>Désolé. La réponse attendue était : ${answers}</span>`;
													}
													
													document.getElementById('feedback-area').classList.remove('hidden');
			   }

			   
			   document.getElementById('next-btn').onclick = () => {
									     currentQuestion++;
									     if (currentQuestion < questions.length) {
										 loadQuestion();
									     } else {
										 showResults();
									     }
									     
									 };
							       
							       function showResults() {
								   document.getElementById('quiz-content').classList.add('hidden');
														     document.getElementById('feedback-area').classList.add('hidden');
																					document.getElementById('result-area').classList.remove('hidden');
																											 document.getElementById('final-score').innerText = `Vous avez obtenu ${score} sur 30 !`;
																																
																																let evaluation = "";
																																if (score === 30) evaluation = "Parfait ! Vous maîtrisez les structures météo à 100% !";
																																else if (score >= 24) evaluation = "Très bien ! Vous avez une excellente compréhension.";
																																else if (score >= 15) evaluation = "Bon travail, continuez à pratiquer ces expressions.";
																																else evaluation = "C'est un bon début. Révisez 'Il fait', 'C'est' et 'Il y a' pour progresser.";
																																
																																document.getElementById('evaluation').innerText = evaluation;
							       }
							       
							       window.onload = loadQuestion;
								      |})
	]).


htmlBlock --> 
	html({|html(_)||
		  <script src="https://cdn.tailwindcss.com"></script>

		  <body class="min-h-screen flex flex-col items-center font-sans">
		  
		  <div class="max-w-2xl w-full bg-white rounded-3xl shadow-2xl overflow-hidden border-b-8 border-blue-600">
		  <!-- Header / Progrès -->
		      <div class="bg-blue-600 p-6 text-white text-center">
		      <h1 class="text-2xl font-bold mb-2">Maîtriser les structures 🌦️</h1>
		      <div class="flex justify-between items-center text-sm mb-1">
                      <span id="question-counter">Question 1 / 30</span>
                      <span id="score-display">Score : 0</span>
		      </div>
		      <div class="w-full bg-blue-800 rounded-full h-2.5">
                      <div id="progress" class="progress-bar bg-yellow-400 h-2.5 rounded-full" style="width: 3.33%"></div>
		      </div>
		      </div>
		      
		      <!-- Zone de Question -->
			  <div id="quiz-content" class="p-8">
			  <div id="question-text" class="text-xl text-gray-800 font-medium mb-8 text-center">
			  <!-- La question s'affiche ici -->
            </div>
 
            <div id="options-container" class="grid grid-cols-1 gap-4">
                <!-- Les options s'affichent ici -->
			      </div>
			      </div>
			      
			      <!-- Zone de Rétroaction -->
				  <div id="feedback-area" class="hidden p-6 text-center border-t border-gray-100">
				  <div id="feedback-message" class="text-lg font-bold mb-4"></div>
				  <button id="next-btn" class="bg-blue-600 text-white px-8 py-3 rounded-full font-bold hover:bg-blue-700 transition">
				  Question suivante
				  </button>
				  </div>
				  
				  <!-- Zone de Résultat -->
				      <div id="result-area" class="hidden p-10 text-center">
				      <h2 class="text-3xl font-bold text-gray-800 mb-4">Terminé ! 🎉</h2>
				      <p id="final-score" class="text-xl mb-6 font-semibold"></p>
				      <p id="evaluation" class="text-gray-600 mb-8 italic"></p>
				      <button onclick="location.reload()" class="bg-blue-600 text-white px-8 py-3 rounded-full font-bold hover:bg-blue-700 transition">
				      Recommencer le défi
				      </button>
				      </div>
				      </div>
		 |}).
