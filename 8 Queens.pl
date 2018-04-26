:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to obtain all the possible solutions for 8 queens problem
getSolutions([],L,L).

getSolutions([H|T],L,SOLUTIONS) :-
	checkList(H),
	addToList(H,L,TEMP),
	getSolutions(T,TEMP,SOLUTIONS).

getSolutions([H|T],L,SOLUTIONS):- getSolutions(T,L,SOLUTIONS).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to check if a list is a potential solution
checkList([H|T]) :- checkValidSolution(H,1,T,2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to check if a particular solution is valid
checkValidSolution(_,_,[],_).

checkValidSolution(X,Y,[H|T],Y1) :-
	Y2 is Y1+1,
	checkValidSolution(H,Y1,T,Y2),
	Y1 - Y =\= H - X,
	Y1 - Y =\= X - H,
	checkValidSolution(X,Y,T,Y2).

checkValidSolution(_,_,_,_) :- false.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to add an element to the list
addToList(X,[],[X]).

addToList(X,[H|T],[H|T1]) :- addToList(X,T,T1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to delete a member from the list
deleteFromList(X,[X|T],T).

deleteFromList(X,[H|T],[H|T1]) :- deleteFromList(X,T,T1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to check if the given list is a permutation of another list(Of same size).
perm([],[]).

perm([H|T],X) :-
	perm(T,Y),
	deleteFromList(H,X,Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to check the validity of input
checkLimits(X,Y):- X>0,X<9,Y>0,Y<9.
checkLimits(_,_) :- 
	write('IMPOSSIBLE\n'),
	halt.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to obtain final solution for the problem
getFinalSolution(_,_,[]):-
	write('IMPOSSIBLE\n'),
	halt.

getFinalSolution(X,Y,[H|T]) :-
	checkYValue(X,Y,H),
	printBoard(H).

getFinalSolution(X,Y,[H|T]):- getFinalSolution(X,Y,T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to check if a list has appropriate value of x
checkYValue(X,Y,[H|T]) :- 
	X>1,
	X1 is X-1,
	checkYValue(X1,Y,T).

checkYValue(1,Y,[H|T]) :- H=Y.

checkYValue(_,_,_) :- false.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prints the board for the corresponding X and Y
printBoard([]).

printBoard([H|T]) :-
	H1 is H-1,
	printZero(H1),
	write('1 '),
	H2 is 8-H,
	printZero(H2),
	write('\n'),
	printBoard(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method to print a particular number of zeros
printZero(X) :-
	X>0,
	write('0 '),
	X1 is X-1,
	printZero(X1).

printZero(_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Start point of the program
main :-
	findall(X,perm([1,2,3,4,5,6,7,8],X),PERMS),
	getSolutions(PERMS,[],VALID),
	read_integer(X),
	read_integer(Y),
	checkLimits(X,Y),
	getFinalSolution(X,Y,VALID).