start:-								%begin of the program
	write('Enter Name'),
	nl,
	read(Name),
	nl,
	
	
	write('Enter ID'),
	nl,
	read(ID),
	nl,

	abolish(course/2),
	userInput([],[],Name,ID).


firstLetter([H|T]):-						%run first char name
			put(H).
		
	
position(_,0,_).


position(ListName,Length,Current):-				% print next char name
			member(Y,ListName,Current),
			NewCurrent is Current+1,
			NewLength is Length-1,
			findSpace(Y,NewCurrent,ListName),
			position(ListName,NewLength,NewCurrent).


findSpace(32,NewCurrent,ListName):-				%check for the space
			member(X,ListName,NewCurrent),
			put(X).

findSpace(_,_,_).

/*2222222222222222222222222222222222222222222222222222*/

date(ListID):-
	member(E1,ListID,1),
	member(E2,ListID,2),
	member(E3,ListID,3),
	member(E4,ListID,4),
	member(E5,ListID,5),
	member(E6,ListID,6),
	put(E5),
	put(E6),
	month(E3,E4),
	put(E1),
	put(E2).


month(48,49):- write(' January ').
month(48,50):- write(' February ').
month(48,51):- write(' March ').
month(48,52):- write(' April ').
month(48,53):- write(' May ').
month(48,54):- write(' June ').
month(48,55):- write(' July ').
month(48,56):- write(' August ').
month(48,57):- write(' September ').
month(49,48):- write(' October ').
month(49,49):- write(' November ').
month(49,50):- write(' December ').

state(ListID):-
	member(E7,ListID,7),
	member(E8,ListID,8),
	StateList = [E7,E8],
	name(StateNum,StateList),
	stateName(StateNum).

stateName(StateNum):-
			StateNum = 1,write('Johor');
			between(20,25,StateNum),write('Johor').

stateName(StateNum):-
			StateNum = 2,write('Kedah');
			between(24,28,StateNum),write('Kedah').

stateName(StateNum):-	
			StateNum = 3,write('Kelantan');
			between(27,30,StateNum),write('Kelantan').

stateName(StateNum):-	
			StateNum = 4,write('Melaka');
			StateNum = 30,write('Melaka').

stateName(StateNum):-	
			StateNum = 5,write('Negeri Sembilan');
			StateNum = 31,write('Negeri Sembilan');
			StateNum = 59,write('Negeri Sembilan').

stateName(StateNum):-	
			StateNum = 6,write('Pahang');
			between(31,34,StateNum),write('Pahang').

stateName(StateNum):-	
			StateNum = 7,write('Pulau Pinang');
			between(33,36,StateNum),write('Pulau Pinang').

stateName(StateNum):-
			StateNum = 8,write('Perak');
			between(35,40,StateNum),write('Perak').

stateName(StateNum):-	
			StateNum = 9,write('Perlis');
			StateNum = 40,write('Perlis').

stateName(StateNum):-
			StateNum = 10,write('Selangor');
			between(40,45,StateNum),write('Selangor').

stateName(StateNum):-
			StateNum = 11,write('Terengganu');
			between(44,47,StateNum),write('Terengganu').

stateName(StateNum):-
			StateNum = 12,write('Sabah');
			between(46,50,StateNum),write('Sabah').

stateName(StateNum):-
			StateNum = 13,write('Sarawak');
			between(49,54,StateNum),write('Sarawak').

stateName(StateNum):-
			StateNum = 14,write('Wilayah Persekutuan Kuala Lumpur');
			between(53,58,StateNum),write('Wilayah Persekutuan Kuala Lumpur').

stateName(StateNum):-
			StateNum = 15,write('Wilayah Persekutuan Labuan');
			StateNum = 58,write('Wilayah Persekutuan Labuan').

stateName(StateNum):-
			StateNum = 16,write('Wilayah Persekutuan Putrajaya').


between(X,Y,StateNum):-
			X<StateNum,
			Y>StateNum.

gender(ListID):-
		member(E12,ListID,12),
		GenderList = [E12],
		name(GenderNum,GenderList),
		genderType(GenderNum).


genderType(GenderNum):-				
			0 is mod(GenderNum,2),
			write('Female');
			1 is mod(GenderNum,2),
			write('Male').


/*333333333333333333333333333333333333333333333333*/

grade('A',4).
grade('A-',3.67).
grade('B+',3.33).
grade('B',3).
grade('B-',2.67).
grade('C+',2.33).
grade('C',2).
grade('D',1).
grade('F',0).

userInput(CAccumulator,GAccumulator,Name,ID):-				%insert course code and grade into lists respectively
	write('Course Code or x to stop'),
	read(CourseCode),
	( CourseCode=x
	-> cal(CAccumulator,GAccumulator,Name,ID);
	name(CourseCode, FirstList),
	length(FirstList,Length),
	member(LastChar, FirstList, Length),
	nl,

	write('Grade'),
	read(Grade),
	nl,
	assert(course(CourseCode, Grade)),
	grade(Grade,CreditList),
	userInput([LastChar|CAccumulator], [CreditList|GAccumulator],Name,ID)  ).	%save course and grade to list


cal(CourseList,GradeList,Name,ID):- 
	findall(1,course(_,_), List),
	length(List,Length),
	nl,

	loop(Length,CourseList,GradeList,1,0,0,Name,ID,Length).


loop(Length,CourseList,GradeList,Position,InitialCredit,InitialGPE,Name,ID,Control):-	%calculate total credit and point
	member(CreditHour,CourseList,Position),
	name(NewCreditHour,[CreditHour]),
	TotalCredit is InitialCredit + NewCreditHour ,

	member(GPE,GradeList,Position),
	TotalPoint is InitialGPE + NewCreditHour * GPE ,

	NewLength is Length-1,
	NewPosition is Position+1,

	loop(NewLength,CourseList,GradeList,NewPosition,TotalCredit,TotalPoint,Name,ID,Control).
	

loop(0,_,_,_,TotalCredit,TotalPoint,Name,ID,Control):- 		%all output run at here
	GPA is TotalPoint / TotalCredit,
	
	nl,
	write('Name               : '),
	write(Name),
	nl,
	write('Name Code          : '),
	name(Name,ListName),
	length(ListName,Length),
	firstLetter(ListName),
	position(ListName,Length,1),
	
	nl,
	write('Malaysian ID number: '),
	write(ID),
	nl,
	write('Date Of Birth      : '),
	name(ID,ListID),
	date(ListID),
	nl,
	write('State              : '),
	state(ListID),
	nl,
	write('Gender             : '),
	gender(ListID),
	nl,
	write('GPA                : '),
	write(GPA),nl,
	write('Course and Grades  :'), 
	nl,
	showCourse(Control).

showCourse(Control):-
	course(CourseCode,Grade),
	write(CourseCode), write('	'), write(Grade),
	nl,
	retract(course(X,Y)),
	NewControl is Control - 1,
	showCourse(NewControl).

showCourse(0).