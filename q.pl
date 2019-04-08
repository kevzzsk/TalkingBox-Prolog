
/* SPORTS */
/* team_size, arena_type, play_device, game_mode, winning_condition */
tennis([court,single,doubles,outdoor,ball,racket,highestpoint]).
swimming([pool,single,water,fastest]).
basketball([team,court,indoor,ball,highestpoint,five_man]).
table_tennis([single,doubles,table,ball,racket,highestpoint,indoor]).
waterpolo([team,seven_man,indoor,water,ball,highestpoint,pool]).
track([single,outdoor,fastest,court]).
floorball([court,team,six_man,ball,stick,indoor,highestpoint]).

/* list of sports to be choosen from */
randomizer_sports([tennis,swimming,basketball,table_tennis,waterpolo,track,floorball]).

/* RULES */

/* Out=0 => X is true, 
   Out=1 => X is False, 
   Out=2 counter is more than 10 */
has(X,Out):-
    counter(C),
    C<10 ->
    (has(X) ->
    Out is 0
    ;Out is 1)
    ;Out is 2.

has(X):-
    selected(tennis),
    tennis(L),
    incr,
    member(X,L).

has(X):-
    selected(swimming),
    swimming(L),
    incr,
    member(X,L).

has(X):-
    selected(basketball),
    basketball(L),
    incr,
    member(X,L).

has(X):-
    selected(table_tennis),
    table_tennis(L),
    incr,
    member(X,L).

has(X):-
    selected(waterpolo),
    waterpolo(L),
    incr,
    member(X,L).

has(X):-
    selected(track),
    track(L),
    incr,
    member(X,L).

has(X):-
    selected(floorball),
    floorball(L),
    incr,
    member(X,L).


is(X):-
    selected(X).

/* randomly pick one sports */
pick_random :-
    category(sports),
    randomizer_sports(L),
    random_member(X,L),
    retractall(selected(_)),
    assertz(selected(X)).

/* append all the sports' list, remove duplicate and flatten the list */
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

/* add counter(0) to KB at the start */
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



