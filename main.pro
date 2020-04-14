implement main
    open core

class predicates
    askMainQuestion : ().
    dontAttack : (integer, integer, integer, integer) nondeterm anyflow.
    attack : (integer, integer, integer, integer) nondeterm. %nondeterm anyflow.
    any : (integer) multi (o) determ.
    dontAttack : (integer, integer, integer*) nondeterm anyflow.
    dontAttack : (integer*) nondeterm anyflow.
    abs : (integer, integer) nondeterm (i,o) nondeterm.

clauses
    any(0).
    any(1).
    any(2).
    any(3).
    any(4).
    any(5).
    any(6).
    any(7).

    attack(X1, Y1, X2, Y2) :-
        X2 = X1.
    attack(X1, Y1, X2, Y2) :-
        Y2 = Y1.
    attack(X1, Y1, X2, Y2) :-
        abs(X2 - X1, Abs),
        abs(Y2 - Y1, Abs).

    dontAttack(X1, Y1, X2, Y2) :-
        any(X1),
        any(Y1),
        any(X2),
        any(Y2),
        not(attack(X1, Y1, X2, Y2)).

    dontAttack(X1, Y1, [X2, Y2 | OtherElements]) :-
        dontAttack([X2, Y2 | OtherElements]),
        dontAttack(X1, Y1, X2, Y2),
        dontAttack(X1, Y1, OtherElements).

    dontAttack(X, Y, []) :-
        any(X),
        any(Y).  %Граничное условие

    dontAttack([X1, Y1 | OtherElements]) :-
        dontAttack(X1, Y1, OtherElements).

    dontAttack([]).

    askMainQuestion() :-
        X1 = 0,
        X2 = 1,
        X3 = 2,
        X4 = 3,
        X5 = 4,
        X6 = 5,
        X7 = 6,
        X8 = 7,
        dontAttack([X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5, X6, Y6, X7, Y7, X8, Y8]),
        stdio::write(X1, ":", Y1, " — ", X2, ":", Y2, " — ", X3, ":", Y3, " — ", X4, ":", Y4, " — ", X5, ":", Y5, " — ", X6, ":", Y6, " — ", X7, ":",
            Y7, " — ", X8, ":", Y8),
        stdio::nl, %new line
        fail.

    askMainQuestion().

    abs(X, Result) :-
        X >= 0,
        Result = X.
    abs(X, Result) :-
        X < 0,
        Result = -X.

    run() :-
        console::init(),
        askMainQuestion(),
        _ = stdIO::readchar().

end implement main

goal
    mainExe::run(main::run).
