create_analyzer :- 
   _S1 = [dlg_ownedbyprolog,ws_sysmenu,ws_caption],
   _S2 = [ws_child,ws_visible,ss_left],
   _S3 = [ws_child,ws_visible,ws_tabstop,bs_pushbutton],
   _S4 = [ws_child,ws_visible,ss_right],
   _S5 = [ws_child,ws_visible,ws_tabstop,ws_border,es_left,es_multiline,ws_vscroll,es_autohscroll,es_autovscroll],
   wdcreate(  analyzer,        `TEXT ANALYZER`,                 235,  43, 392, 348, _S1 ),
   wccreate( (analyzer,10000), static, `Enter a paragraph:`,     20,  10, 280,  20, _S2 ),
   wccreate( (analyzer,10001), static, `Summary:`,               20, 170,  70,  20, _S2 ),
   wccreate( (analyzer,1001),  button, `CLEAR`,                 300, 240,  70,  30, _S3 ),
   wccreate( (analyzer,10009), static, `words`,                 200, 270,  50,  20, _S2 ),
   wccreate( (analyzer,10007), static, `characters`,            200, 220,  60,  20, _S2 ),
   wccreate( (analyzer,10010), static, `sentences`,             200, 290,  60,  20, _S2 ),
   wccreate( (analyzer,10006), static, `char`,                  150, 220,  40,  20, _S4 ),
   wccreate( (analyzer,10005), static, `Number of sentences:`,   30, 290, 120,  20, _S2 ),
   wccreate( (analyzer,10004), static, `Number of words:`,       30, 270, 120,  20, _S2 ),
   wccreate( (analyzer,10003), static, `Number of characters:`,  30, 200, 120,  20, _S2 ),
   wccreate( (analyzer,10008), static, `word`,                  150, 270,  40,  20, _S4 ),
   wccreate( (analyzer,10011), static, `sen`,                   150, 290,  40,  20, _S4 ),
   wccreate( (analyzer,1002),  button, `CLOSE`,                 300, 280,  70,  30, _S3 ),
   wccreate( (analyzer,10002), static, `with spaces`,            60, 220,  80,  20, _S2 ),
   wccreate( (analyzer,10014), static, `char`,                  150, 240,  40,  20, _S4 ),
   wccreate( (analyzer,10015), static, `characters`,            200, 240,  60,  20, _S2 ),
   wccreate( (analyzer,10013), static, `without spaces`,         60, 240,  80,  20, _S2 ),
   wccreate( (analyzer,8000),  edit,   ``,                       20,  40, 350, 120, _S5 ).

start:-
	create_analyzer,
	window_handler(analyzer, exp_handler),
	show_dialog(analyzer).

exp_handler((analyzer,1002),msg_button,_,close).

exp_handler((analyzer,1001),msg_button,_,Clearscreen):-
	wtext((analyzer,8000), ``).

exp_handler(analyzer,msg_close,_,close).

exp_handler((analyzer,8000),msg_change,_,Edit):-
	wtext((analyzer,8000),C),
	name(C,List),
	length(List,Length),

	number_string(Length,S1),		%number of char with spaces
	wtext((analyzer,10006),S1),
	
	countCharNoSpace(32, List, Space),	%number of char without spaces
	NewSpace is Length - Space,
	number_string(NewSpace,S2),
	wtext((analyzer,10014),S2),

	NewY is Space,				%number of words
	number_string(NewY,S3),
	wtext((analyzer,10008),S3),

	countSentence(46, List, Z),		%number of sentences
	number_string(Z,S4),
	wtext((analyzer,10011),S4).
	

% char with no space

countCharNoSpace(_, [], 0).			%basic clause

countCharNoSpace(X, [X | T], N) :-		%recursive clause
  !, countCharNoSpace(X, T, N1),
  N is N1 + 1.

countCharNoSpace(X, [_ | T], N) :-		%starting rule
  countCharNoSpace(X, T, N).


% sentence

countSentence(_, [], 0).			%basic clause

countSentence(X, [X | T], N) :-		%recursive clause
  !, countSentence(X, T, N1),
  N is N1 + 1.

countSentence(X, [_ | T], N) :-		%starting rule
  countSentence(X, T, N).