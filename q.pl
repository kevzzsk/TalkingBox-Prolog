
/* SPORTS */
/* team_size, arena_type, play_device, game_mode, winning_condition */
tennis([court,single,doubles,outdoor,ball,racket,highestpoint]).
swimming([pool,single,water,fastest]).
basketball([team,court,indoor,ball,highestpoint,fiveman]).
table_tennis([single,doubles,table,ball,racket,highestpoint,indoor]).
snooker([table,single,ball,stick,highestpoint]).
waterpolo([team,sevenman,indoor,water,ball,highestpoint,pool]).
track([single,outdoor,fastest,court]).
floorball([court,team,sixman,ball,stick,indoor,highestpoint]).

/* RULES */
has(X):-
    tennis(L),
    selected(tennis),
    member(X,L),
    incr.

has(X):-
    swimming(L),
    selected(swimming),
    member(X,L),
    incr.

has(X):-
    basketball(L),
    selected(basketball),
    member(X,L),
    incr.

has(X):-
    table_tennis(L),
    selected(table_tennis),
    member(X,L),
    incr.


is(X):-
    selected(X).



:- dynamic counter/1.

initcounter :-
    retractall(counter(_)),
    assertz(counter(0)).

incr :-
    counter(V0),
    retractall(counter(_)),
    succ(V0, V),
    assertz(counter(V)).

:- initcounter.



selected(tennis).


