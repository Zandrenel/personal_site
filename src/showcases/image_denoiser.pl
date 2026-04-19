:- module(image_denoiser,[
	      nlmeans/1,
	      processImage/1
	  ]).

:- use_module(src/base_elements).

serveradress(imageServer, 'http://localhost:5000').
serveradress(this, 'https://alexanderdelaurentiis.com').
%% serveradress(this, 'http://localhost:3030').


nlmeans(_Request) :-
    reply_html_page(
	[title('NL-Means for Image denoising')],
	[
	    \html_requires(static('styles.css')),
	    \html_requires(static('themes.css')),
	    \nav_bar,
	    div(id("image-main"),
		[
		    \js_snackbar,
		    \js_get_image,
		    \description,
		    \image_display

		]),
	    \footer   
	]).

processImage(Request) :-
    Options = [
	
    ],
    serveradress(imageServer, To),
    memberchk(method(Method), Request),
    read_data(Request, Data),
    memberchk(request_uri(URI), Request),
    atomic_list_concat([To,URI], Target),
    option(request_headers(ReqHrd0), Options, []),
    maplist(request_header, ReqHrd0, ReqHrd),
    http_open(Target, In,
   	      [ method(Method),
   		post(Data),
   		header(content_type, 'image/jpeg'),
		encoding(octet)
   		| ReqHrd
   	      ]),
    call_cleanup(
	read_stream_to_codes(In, Bytes),
	close(In)),
    option(reply_headers(HdrExtra0), Options, []),
    maplist(reply_header, HdrExtra0, HdrExtra),
    
    % To Debug
    open("img_test.jpg", write, O, [type(binary)]),
    maplist(put_byte(O), Bytes),
    close(O),
    atom_codes(BinaryAtom, Bytes),
    throw(http_reply(bytes('image/jpeg', BinaryAtom), HdrExtra)).

read_data(Request, bytes(ContentType, Bytes)) :-
    memberchk(input(In), Request),
    memberchk(content_type(ContentType), Request),
    (   memberchk(content_length(Len), Request)
    ->  read_string(In, Len, Bytes)
    ;   read_string(In, _, Bytes)
    ).

data_method(post).
data_method(put).

request_header(Name = Value, request_header(Name = Value)).

reply_header(Name = Value, Term) :-
    Term =.. [Name,Value].


js_get_image -->
  {
    serveradress(this, Server),
    ThisServer = Server
  },
    html([
		
		\js_script({|javascript(ThisServer)||
			    async function upload(){
			      
			      console.log('Starting Upload!');
			      const filterOption = document.getElementById('image_filter').value
												    console.log(filterOption)
			      const input = document.getElementById('image_input');
			      const file = input.files[0];
			      if( !file ) {
				openSnackbar(`There is no file.`);
				return
			      }
			      const formData = new FormData();
			      formData.append('image', file);

			      const reqHeaders = new Headers();
			      const options = {
				mode: 'cors',
				method: "POST",
				body: formData
			      };
			      let serverAddress = ThisServer

			      
			      if(filterOption === 'gaussian'){
				serverAddress = `${serverAddress}/gaussian`
			      } else if(filterOption === 'canny'){
				serverAddress = `${serverAddress}/cv2/canny`				
			      } 
			      
			      // Pass init as an "options" object with our headers.
			      const req = new Request(serverAddress, options);			      
			      try {
				
				const response = await fetch(req);
				
				response.blob().then(
				  (blob) => {
				    const imageUrl = URL.createObjectURL(blob);
				    const img = document.getElementById('image_display');
				    img.src = imageUrl;
				    openSnackbar(`Upload Done!`);				    
				  }
				);


				
			      } catch (error) {
				console.log('error',error);
			      }
			      
			    }
			    |})
	    ]).

image_display --> 
    html([
		div([id(image_upload_container)],[
			div([id(image_input_container)],[
				input([type="file",id(image_input)])
			    ]),
			div([id(image_button_container)],[
				select([id(image_filter)],[option([value=canny],'cv2 canny'),option([value=gaussian],gaussian)]),
				button([id(process_button),onclick="upload()"],["Process"])
			    ]),
			div([id(image_output_container)],[
				img([id(image_display)],[])
			    ])
		    ])
	    ]).


description -->
    html(
	ul([
		  li('A python image processing playground, upload a file and have the response displayed to the right'),
		  li('Prefers jpegs'),
		  li('Uses as a placeholder the cv2 builtin canny algo')
	])
    ).
