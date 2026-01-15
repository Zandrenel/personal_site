:- module(auth,[
              login/1,
	      logout/1,
	      login_dialog/2
	  ]).

% user(username, password).
user('alek','pass').

process_login(Username, Password) :-
    % do whatever calls are needed to process the login, for now its basic,
    % though it can be a call to other services or other predicates later
    user(Username, Password),
    http_session_assert(session_user(Username,Password)).

login(_Request) :-
    http_session_data(session_user(Username,_Password)), 
    format('Content-type: application/json~n~n{"code":200, "message":"Already Logged in as ~w."}', [Username]).
login(Request) :-
    memberchk(method(post), Request),
    % Get required Request body data
    http_read_data(Request, Data, []),
    atom_json_dict(Data,Dict, [as(atom)]),
    atom_string(Username,Dict.username),
    atom_string(Password,Dict.password),
    % Process the login, assert the session
    process_login(Username,Password),
    http_session_data(session_user(Username,Password)),
    http_session_id(Session),
    format('Content-type: application/json~n~n{"code":200, "username":"~w","password":"~w","message":"Loggin Successfully", "session":"~w"}', [Username, Password, Session]).
login(_Request) :-
    format('Status: 400~n'),
    reply_json('{"code":400, "data":{"error": "Failed Login"}}').

logout(Request) :-
    memberchk(method(get), Request),
    http_session_id(Session),
    http_close_session(Session),
    reply_json('{"message": "Logout Successful"}').
logout(_) :-
    reply_json('{ "data":{"error": "Failed Logout"}}').

login_dialog -->
    {
	http_session_data(session_user(_User,_Pass)) -> U = button([id('login-button'),onclick('logout()')],'Logout');U = button([id('login-button'),onclick('openDialog()')],'Login')
    },
    html([
		div([id('login-div')],[
			U
		    ]),
				
      \js_script({|javascript(_)||
		  async function login(){

		    const reqHeaders = new Headers();

		    const username = document.getElementById('username').value
		    const password = document.getElementById('password').value

		    const options = {
		      headers: reqHeaders,
		      method: "POST",
                      body: JSON.stringify({ username: username, password: password })	
		    };
		    
		    // Pass init as an "options" object with our headers.
		    const req = new Request("/login", options);

		    try {
		      const response = await fetch(req);
		      if (!response.ok) {
		        throw new Error(`Response status: ${response.status}`);
		      }
		    response.json().then(
					(response) => {
					    console.log(response);

			       if(response.code === 200){
		    	         console.log(response);
				 toggleLoginState();
			    	 closeLoginDialog();
				 openSnackbar(`Logged in as ${response.username}.`);
			       } else if( response.code === 400) {
			         console.log('error',response);
			       }
			})
			} catch (error) {
			  console.log('error',error);
			}
			
		  }

		  async function logout(){

		    const reqHeaders = new Headers();

		    // A cached response is okay unless it's more than a week old
		    reqHeaders.set("Cache-Control", "max-age=604800");

		    const options = {
		      headers: reqHeaders,
		      method: "GET"
		    };
		    
		    // Pass init as an "options" object with our headers.
		    const req = new Request("/logout", options);

		    const response = await fetch(req);
		    response.json().then(
			(text) => {
			       toggleLoginState();
			       openSnackbar('Logged out successfully.');
			})
			
		  }
		  function toggleLoginState() {
		   	const loginButton = document.getElementById('login-button');
			console.log(loginButton);
			if(loginButton.innerHTML === 'Login'){
			  loginButton.innerHTML = 'Logout';
			  loginButton.onclick = function() { logout(); }
			} else {
			  loginButton.innerHTML = 'Login';
			  loginButton.onclick = function() { openDialog(); }
			}			  
		  }

		  function closeLoginDialog() {
		  	const dialogContainer = document.getElementById('dialog-container');
			document.body.style.overflow = '';
		  	dialogContainer.remove();
		  }

		  function togglePasswordVisibility() {
		  	const password = document.getElementById('password');
		  	const vis = document.getElementById('password-visibility-button');	
		  	if( password.type === 'password'){
			  password.type = 'text';
			  vis.innerHTML = 'I';
			} else {
			  password.type = 'password';
			  vis.innerHTML = 'O';
			}
		  }

		  function openSnackbar(text) {
		  
		    const snackbar = document.createElement('div');		  
		    const content = text;
		    
		    snackbar.classList.add('snackbar-alert');
		    snackbar.innerHTML = content;
		    const main = document.getElementById("content");
		    		    

		    // create the actual div in the DOM
		    document.body.insertBefore(snackbar, main);

		    setTimeout(
		    () => {
		       snackbar.remove()
		       },
		       5000)
		  
		  }
		  
		  function openDialog() { 	    

		    // Initialize dialog parts
		    const dialogContainer = document.createElement('div');
		    const dialog = document.createElement('div');
		    const content = `
		    	      <div id='dialog-header'>
			      	<h2 id='dialog-header-text' >Login</h2>
				<div id='dialog-close-button-container'>
		    	          <button id='dialog-close-button' onclick='closeLoginDialog()'>X</button>
				</div>
			      </div>
			      <div id='dialog-body-content'>
                              <form id='login-form' action='javascript:;' onsubmit='login()'>
			        <div id='username-container' class='formfield-container'>
                                  <input placeholder='username' id='username' class='login-input' type='text'>
				</div>
				<div id='password-container' class='formfield-container'>
                                  <input placeholder='password' type='password' id='password' class='login-input' type='text'><button id='password-visibility-button' type='button' onclick="togglePasswordVisibility()">I</button>
				</div>
				<div class='formfield-container'>
                                 <button type='submit'>Login Test</button>
				</div>
                              </form>
			      </div>
                              `;
		    const main = document.getElementById("content");
		    document.body.style.overflow = 'hidden';		    

		    // Setup the IDs
		    dialogContainer.id = 'dialog-container';
		    dialog.id = 'dialog-body';

		    // set other properties
		    dialog.tabIndex = 0
		    dialog.innerHTML = content;
		    
		    // Attatch containersd
		    //dialog.appendChild(content);
		    dialogContainer.appendChild(dialog);
		    
		    // set event listeners
		    dialogContainer.addEventListener("blur", function (e) {												        console.log(this.className); // logs the className of myElement
																						console.log(e.currentTarget === this); // logs `true`
																				//		dialogContainer.remove();
		});
		    dialog.addEventListener("focus", function (e) {												                console.log('dialog focused');
																						console.log(e.currentTarget === this); // logs `true`
																						
								  });
		    // create the actual div in the DOM
		    document.body.insertBefore(dialogContainer, main);
		    dialog.focus()
		    
		  }|})
	    ]).
