
ask(trekking,0).

ask(X,Y):-
	like(Y), related(X,Y).
ask(X,Y):-
	random(X).	

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

append([A | B], C, [A | D]) :- append(B, C, D).
	append([], A, A).

related(X,Y):- romantic(L),member(X,L),member(Y,L).

related(X,Y):- outdoorsy(L),member(X,L),member(Y,L).

related(X,Y):- social(L),member(X,L),member(Y,L).

related(X,Y):- health_freak(L),member(X,L),member(Y,L).

related(X,Y):- loner(L),member(X,L),member(Y,L).

random(X):- romantic(L),member(X,L).

random(X):- outdoorsy(L),member(X,L).

random(X):- social(L),member(X,L).

random(X):- health_freak(L),member(X,L).

random(X):- loner(L),member(X,L).


romantic([gifts,wine,dinner,candlelight,rains,tea,concert,night,poetry,music,movie,dating,magic,novels,stories,roses,bouquets,courtship,chickflicks,cruise,breeze,diaries,painting]).
outdoorsy([picnic,trekking,soccer,sports,jogging,kayaking,parks,event,woods,mountains,beaches,cricket,action_movies,dogs,lakes,fairs,swimming,breeze,fitness,water]).
social([coffee,picnic,friends,party,beer,music,concert,event,movie,soccer,dinner,gifts,gardens, roses, flowers,bouquet,cricket,board_games,cafe,netflix,dogs,networking,exhibitions,fairs,debates]).
health_freak([sports,tea,fruitjuice,smoothie,trekking,training,jogging,soccer,sweating,sleeping,swimming,lakes,exercise,burpees,fitness,cats,water,music]).
loner([books,coffee,woods,candlelight,sleeping,training,jogging,night,tea,beaches,poetry,tea,rains,fiction, novels,board_games,netflix,cats,music,painting,sketching,writing,diaries]).

like(nothing).
dislike(nothing).
a.