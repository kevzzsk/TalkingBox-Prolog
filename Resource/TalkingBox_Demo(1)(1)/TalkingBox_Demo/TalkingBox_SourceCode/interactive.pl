
ask(trekking,0).
/*
Count_romantic = 0.
Count_outdoorsy = 0.
Count_social = 0.
Count_health_freak = 0.
Count_loner = 0.*/
a.
/*member of a list */
a.
/*
ask(X,Y):-
	like(Y), related(X,Y), X\=Y, subtract(all(ALL), memorize(REMOVE), NEW), member(X,NEW).
ask(X,Y):-
	dislike(Y), not(related(X,Y)), X\=Y, subtract(all(ALL), memorize(REMOVE), NEW), member(X,NEW).
ask(X,Y):-
	not(related(X,Y)),  X\=Y, subtract(all(ALL), memorize(REMOVE), NEW), member(X,NEW).
ask(X,Y):-
	subtract(all(ALL), memorize(REMOVE), NEW), member(X,NEW).
	*/
ask(X,Y):-
	like(Y), related(X,Y).
ask(X,Y):-
	random(X).
	
	
/* member of a list*/
member(X,[X|_]).
member(X,[_|R]) :- member(X,R).
/* takeout a member from a list*/
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).
/* append a member to a list*/
append([A | B], C, [A | D]) :- append(B, C, D).
	append([], A, A).
/* Counter increment function 
count_romantic(1,0).
count_romantic(X,Y):- X is Y +1.

related(X,Y) tests if Y is in a list that contains X */
a.
/*
related(X,Y):- member(X,romantic),member(Y,romantic),succ(Count_romantic,Count_romantic).
related(X,Y):- member(X,outdoorsy),member(Y,outdoorsy),succ(Count_outdoorsy,Count_outdoorsy).
related(X,Y):- member(X,social),member(Y,social),succ(Count_social,Count_social).
related(X,Y):- member(X,health_freak),member(Y,health_freak),succ(Count_health_freak,Count_health_freak).
related(X,Y):- member(X,loner),member(Y,loner),succ(Count_loner,Count_loner).*/
related(X,Y):- romantic(L),member(X,L),member(Y,L).
/*,succ(Count_romantic,Count_romantic).*/
related(X,Y):- outdoorsy(L),member(X,L),member(Y,L).
/*,succ(Count_outdoorsy,Count_outdoorsy).*/
related(X,Y):- social(L),member(X,L),member(Y,L).
/*,succ(Count_social,Count_social).*/
related(X,Y):- health_freak(L),member(X,L),member(Y,L).
/*,succ(Count_health_freak,Count_health_freak).*/
related(X,Y):- loner(L),member(X,L),member(Y,L).

random(X):- romantic(L),member(X,L).
/*,succ(Count_romantic,Count_romantic).*/
random(X):- outdoorsy(L),member(X,L).
/*,succ(Count_outdoorsy,Count_outdoorsy).*/
random(X):- social(L),member(X,L).
/*,succ(Count_social,Count_social).*/
random(X):- health_freak(L),member(X,L).
/*,succ(Count_health_freak,Count_health_freak).*/
random(X):- loner(L),member(X,L).
/*,succ(Count_loner,Count_loner).*/

romantic([gifts,wine,dinner,candlelight,rains,tea,concert,night,poetry,music,movie,dating,magic,novels,stories,roses,bouquets,courtship,chickflicks,cruise,breeze,diaries,painting]).
outdoorsy([picnic,trekking,soccer,sports,jogging,kayaking,parks,event,woods,mountains,beaches,cricket,action_movies,dogs,lakes,fairs,swimming,breeze,fitness,water]).
social([coffee,picnic,friends,party,beer,music,concert,event,movie,soccer,dinner,gifts,gardens, roses, flowers,bouquet,cricket,board_games,cafe,netflix,dogs,networking,exhibitions,fairs,debates]).
health_freak([sports,tea,fruitjuice,smoothie,trekking,training,jogging,soccer,sweating,sleeping,swimming,lakes,exercise,burpees,fitness,cats,water,music]).
loner([books,coffee,woods,candlelight,sleeping,training,jogging,night,tea,beaches,poetry,tea,rains,fiction, novels,board_games,netflix,cats,music,painting,sketching,writing,diaries]).

/*Do not know what is below this*/
all(L):- flatten([romantic(X),outdoorsy(X),social(X),health_freak(X),loner(X)], L).

flatten(List, FlatList) :-
flatten(List, [], FlatList0),!,FlatList = FlatList0.
flatten(Var, Tl, [Var|Tl]) :- var(Var),!.
flatten([], Tl, Tl) :- !.
flatten([Hd|Tl], Tail, List) :-
  !,
  flatten(Hd, FlatHeadTail, List),
  flatten(Tl, Tail, FlatHeadTail).
flatten(NonList, Tl, [NonList|Tl]).
/*Do not know what is above this*/


like(X).
dislike(X).
a.
like(trekking).
dislike(picnic).
dislike(soccer).