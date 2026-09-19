:- module(ontology,
    [ load_ontology/1,
      ontology_rule/7,
      rule/2,
      equivalent/3,
      relation/2,
      synonym/2,
      optimise_for/1,
      current_objective/1
    ]).

:- dynamic ontology_rule/7.
:- dynamic rule/2.
:- dynamic equivalent/3.
:- dynamic relation/2.
:- dynamic synonym/2.
:- dynamic current_objective/1.

current_objective(rule_count).

load_ontology(File) :-
    setup_call_cleanup(
        open(File, read, In),
        load_ontology_stream(In),
        close(In)
    ).

load_ontology_stream(In) :-
    repeat,
    read_term(In, Term, []),
    ( Term == end_of_file -> !
    ; load_term(Term),
      fail
    ).

load_term(ontology_rule(Name, Inputs, Outputs, Preconditions, Operation, Cost, Properties)) :-
    !,
    assertz(ontology_rule(Name, Inputs, Outputs, Preconditions, Operation, Cost, Properties)).
load_term(rule(A, Bs)) :- !, assertz(rule(A, Bs)).
load_term(equivalent(A, B, Conditions)) :- !, assertz(equivalent(A, B, Conditions)).
load_term(equivalent(A, B)) :- !, assertz(equivalent(A, B, true)).
load_term(synonym(A, B)) :- !, (assertz(synonym(A, B)), assertz(synonym(B, A))).
load_term(Term) :-
    Term =.. [Functor, A, B],
    member(Functor, [implies, expands, specialises, generalises, requires, produces, consumes, before, after, inverse, optimisation, composition]),
    !,
    Head =.. [Functor, A],
    assertz(relation(Head, B)).
load_term(_).

optimise_for(Objective) :-
    retractall(current_objective(_)),
    assertz(current_objective(Objective)).
