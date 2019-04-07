
/* SPORTS */
/* team_size, arena_type, play_device, game_mode, winning_condition */
tennis([court,single,doubles,outdoor,ball,racket,highestpoint]).
swimming([pool,single,water,fastest]).
basketball([team,court,indoor,ball,highestpoint,five_man]).
table_tennis([single,doubles,table,ball,racket,highestpoint,indoor]).
waterpolo([team,seven_man,indoor,water,ball,highestpoint,pool]).
track([single,outdoor,fastest,court]).
floorball([court,team,six_man,ball,stick,indoor,highestpoint]).

randomizer_sports([tennis,swimming,basketball,table_tennis,waterpolo,track,floorball]).

/* RULES */
has(X):-
    tennis(L),
    selected(tennis),
    incr,
    member(X,L).

has(X):-
    swimming(L),
    selected(swimming),
    incr,
    member(X,L).

has(X):-
    basketball(L),
    selected(basketball),
    incr,
    member(X,L).

has(X):-
    table_tennis(L),
    selected(table_tennis),
    incr,
    member(X,L).

has(X):-
    waterpolo(L),
    selected(waterpolo),
    incr,
    member(X,L).

has(X):-
    track(L),
    selected(track),
    incr,
    member(X,L).

has(X):-
    floorball(L),
    selected(floorball),
    incr,
    member(X,L).


is(X):-
    selected(X).


pick_random :-
    category(sports),
    randomizer_sports(L),
    random_member(X,L),
    retractall(selected(_)),
    assertz(selected(X)).

list_flat :-
    tennis(A),
    swimming(B),
    append(A,B,L),
    basketball(C),
    append(L,C,L2),
    table_tennis(D),
    append(L2,D,L3),
    waterpolo(E),
    append(L3,E,L4),
    track(F),
    append(L4,F,L5),
    floorball(G),
    append(L5,G,L6),
    flatten(L6,L7),
    remove_dupe(L7,L8),
    retractall(flat(_)),
    assertz(flat(L8)).

/* removing duplicate from flatten list */
remove_dupe([],L). 
remove_dupe([H|T],L) :-
    member(H,L) ->
    remove_dupe(T,L);
    append(L,[H],L2),
    remove_dupe(T,L2).


initcounter :-
    retractall(counter(_)),
    assertz(counter(0)).

incr :-
    counter(V0),
    retractall(counter(_)),
    succ(V0, V),
    assertz(counter(V)).

/* init functions */
category(sports).
:- initcounter.

:- pick_random.

:- list_flat.



