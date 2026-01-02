:- module(auth,[
              login/1,
	      logout/1,
	      login_dialog/2
	  ]).

% user(username, password).
user('alek','pass').

login(Request) :-
    http_session_data(session_user(Username,_Password)), 
    format('Content-type: application/json~n~n{"message":"Already Logged in as ~w."}', [Username]).
login(Request) :-
    memberchk(method(post), Request),
    % Get required Request body data
    http_read_data(Request, Data, []),
    atom_json_dict(Data,Dict, [as(atom)]),
    atom_string(Username,Dict.username),
    atom_string(Password,Dict.password),
    user(Username,Password),
    % Assert the session data
    http_session_assert(session_user(Username,Password)),
    http_session_data(session_user(Username,Password)),
    http_session_id(Session),
    format('Content-type: application/json~n~n{"username":"~w","password":"~w","message":"Loggin Successfully", "session":"~w"}', [Username, Password, Session]).
login(_Request) :-
    format('Status: 400~n'),
    reply_json('{ "data":{"error": "Failed Login"}}').

logout(Request) :-
    memberchk(method(get), Request),
    http_session_id(Session),
    http_close_session(Session),
    reply_json('{"message": "Logout Successful"}').
logout(_) :-
    reply_json('{ "data":{"error": "Failed Logout"}}').

login_dialog -->
    {
	http_session_data(session_user(User,_Pass)) -> U = User; U = '' 
    },
    html([
		div([id('login-div')],[
			button([id('login-button'),onclick('openDialog()')],'Login'),
			button([id('login-button'),onclick('logout()')],'Logout')
		    ]),
				
      \js_script({|javascript(_)||
		  async function login(){

		    const reqHeaders = new Headers();

		    // A cached response is okay unless it's more than a week old
		    reqHeaders.set("Cache-Control", "max-age=604800");

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
			       if(response.code === 200){
		    	         console.log(response);
			    	 closeLoginDialog();
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
		    	       console.log(text);
			})
			
		  }
		  
		  function closeLoginDialog() {
		  	const dialogContainer = document.getElementById('dialog-container');
		  	dialogContainer.remove();
		  }
		  
		  function openDialog() { 
		    console.log('Starting dialog open');

		    // Initialize dialog parts
		    const dialogContainer = document.createElement('div');
		    const dialog = document.createElement('div');
		    const content = `
		    	      <button onclick='closeLoginDialog()'>X</button>
                              <form id='login-form' action='javascript:;' onsubmit='login()'>
                                <input id='username' class='login-input' type='text'>
                                <input id='password' class='login-input' type='text'>
                                <button type='submit'>Login Test</button>
                              </form>
                              `;
		    const main = document.getElementById("content");

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
