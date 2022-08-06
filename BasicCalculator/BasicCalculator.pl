% Source code for GUI 
cal_dialog :- 

	_Mpro = [dlg_ownedbyprolog,ws_sysmenu,ws_caption,ws_border,dlg_modalframe],   
	_Spro = [ws_child,ws_visible,ss_grayframe],   
	_S2pro = [ws_child,ws_visible,ss_center],   
	_S3pro = [ws_child,ws_visible,ss_whiterect],   
	_Bpro = [ws_child,ws_visible,ws_tabstop,bs_pushbutton],   
	_B2pro = [ws_child,ws_visible,bs_pushbutton],   
	_Epro = [ws_child,ws_visible,ws_border,es_right,es_readonly], 
 
	wdcreate(cal,`CALCULATOR`,203,28,196,266,_Mpro),    

	wccreate(  (cal,1000),static,``,5,5,180,215,_Spro),    
	wccreate(  (cal,100),button,`7`,12,48,24,24,_Bpro),    
	wccreate(  (cal,103),button,`4`,12,84,24,24,_Bpro),    
	wccreate(  (cal,106),button,`1`,12,120,24,24,_Bpro),    
	wccreate(  (cal,109),button,`0`,12,156,24,24,_Bpro),    
	wccreate(  (cal,101),button,`8`,48,48,24,24,_Bpro),    
	wccreate(  (cal,104),button,`5`,48,84,24,24,_Bpro),    
	wccreate(  (cal,107),button,`2`,48,120,24,24,_Bpro),    
	wccreate(  (cal,110),button,`.`,48,156,24,24,_Bpro),    
	wccreate(  (cal,102),button,`9`,84,48,24,24,_Bpro),    
	wccreate(  (cal,105),button,`6`,84,84,24,24,_Bpro),    
	wccreate(  (cal,108),button,`3`,84,120,24,24,_Bpro),    
	wccreate(  (cal,113),button,`/`,156,48,24,36,_Bpro),    
	wccreate(  (cal,114),button,`+`,120,96,24,36,_Bpro),    
	wccreate(  (cal,115),button,`-`,156,96,24,36,_Bpro),    
	wccreate(  (cal,112),button,`*`,120,48,24,36,_Bpro),    
	wccreate(  (cal,800),edit,``,12,12,168,24,_Epro),    
	wccreate(  (cal,116),button,`=`,120,144,60,36,_Bpro),    
	wccreate(  (cal,111),button,`%`,84,156,24,24,_Bpro),    
	wccreate(  (cal,117),button,`&CLEAR SCREEN`,13,198,161,16,_B2pro),    
	wccreate(  (cal,1001),static,``,9,196,170,20,_S3pro),    
	wccreate(  (cal,1002),static,``,9,43,104,143,_S3pro). 

run:-
	cal_dialog,
	window_handler(cal,exp_handler),
	asserta(num([])),
	show_dialog(cal).

exp_handler((cal,109),msg_button, _, Number):-	
	store(`0`).

exp_handler((cal,106),msg_button, _, Number):-
	store(`1`).	

exp_handler((cal,107),msg_button, _, Number):-
	store(`2`).	

exp_handler((cal,108),msg_button, _, Number):-
	store(`3`).

exp_handler((cal,103),msg_button, _, Number):-
	store(`4`).	
	
exp_handler((cal,104),msg_button, _, Number):-
	store(`5`).

exp_handler((cal,105),msg_button, _, Number):-
	store(`6`).

exp_handler((cal,100),msg_button, _, Number):-
	store(`7`).

exp_handler((cal,101),msg_button, _, Number):-
	store(`8`).

exp_handler((cal,102),msg_button, _, Number):-
	store(`9`).

store(X):-
	wtext((cal,800),Val),
	append([X],[Val],NewNum),
	reverse(NewNum,Num),
	cat(Num,K,_),
	wtext((cal,800),K),
	fail.

exp_handler((cal,110),msg_button, _, Decimal):-
	wtext((cal,800),Dec),	
	name(Dec,Decimal),
	not(member(46, Decimal)),
	append([`.`],[Dec],NewNum),
	reverse(NewNum,Num),
	cat(Num,K,_),
	wtext((cal,800),K),
	fail.

exp_handler((cal,117),msg_button, _, Clearscreen):-
	wtext((cal,800),``),
	abolish([num/1]),
	asserta(num([])),
	fail.

exp_handler((cal,116),msg_button,_,Equal):-
				wtext((cal,800),Val),
				num(Num),
				append(Num,[Val],X),
				abolish([num/1]),
				asserta(num(X)),
				Y =.. X,
				Y.

exp_handler((cal,114),msg_button, _, Add):-
				(count; true),
				wtext((cal,800),Val),
				append([add],[Val],X),
				abolish([num/1]),
				asserta(num(X)),
				wtext((cal,800),``),!,
				fail.
exp_handler((cal,115),msg_button, _, Minus):-
				(count; true),
				wtext((cal,800),Val),
				append([minus],[Val],X),
				abolish([num/1]),
				asserta(num(X)),
				wtext((cal,800),``),!,
				fail.

exp_handler((cal,112),msg_button, _, Multiply):-
	   			(count; true),
				wtext((cal,800),Val),
				append([multiply],[Val],X),
				abolish([num/1]),
				asserta(num(X)),
				wtext((cal,800),``),!,
				fail.

exp_handler((cal,113),msg_button, _, Division):-
				(count; true),
				wtext((cal,800),Val),
				append([division],[Val],X),
				abolish([num/1]),
				asserta(num(X)),
				wtext((cal,800),``),!,
				fail.

exp_handler(cal,msg_close, _, close).

operator(add).
operator(minus).
operator(multiply).
operator(division).

count:-
	num(X),
	member(Y,X),
	operator(Y),
	wtext((cal,800),Val),
	append(A,[Val],NewNum),
	count =.. NewNum,
	count.

add(A,B):-
	atom_string(Num1,A),
	atom_string(Num2,B),
	number_atom(N1, Num1),
	number_atom(N2, Num2),
	Ans is N1 + N2,
	number_atom(Ans,Ans1),
	atom_string(Ans1,Ans2),
	abolish([num/1]),
	asserta(num(Ans2)),
	wtext((cal,800),Ans2).

minus(A,B):-
	atom_string(Num1,A),
	atom_string(Num2,B),
	number_atom(N1, Num1),
	number_atom(N2, Num2),
	Ans is N1 - N2,
	number_atom(Ans,Ans1),
	atom_string(Ans1,Ans2),
	abolish([num/1]),
	asserta(num(Ans2)),
	wtext((cal,800),Ans2).

multiply(A,B):-
	atom_string(Num1,A),
	atom_string(Num2,B),
	number_atom(N1, Num1),
	number_atom(N2, Num2),
	Ans is N1 * N2,
	number_atom(Ans,Ans1),
	atom_string(Ans1,Ans2),
	abolish([num/1]),
	asserta(num(Ans2)),
	wtext((cal,800),Ans2).

division(A,B):-
	atom_string(Num1,A),
	atom_string(Num2,B),
	number_atom(N1, Num1),
	number_atom(N2, Num2),
	Ans is N1 / N2,
	number_atom(Ans,Ans1),
	atom_string(Ans1,Ans2),
	abolish([num/1]),
	asserta(num(Ans2)),
	wtext((cal,800),Ans2).