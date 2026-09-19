:- module(equivalence, [equivalent_ideas/3]).

:- use_module(ontology, [equivalent/3]).

 equivalent_ideas(Idea, Idea, proven(identity)).
 equivalent_ideas(Idea1, Idea2, proven(ontology(Conditions))) :-
    equivalent(Idea1, Idea2, Conditions),
    Conditions \= true.
 equivalent_ideas(Idea1, Idea2, proven(ontology(true))) :-
    equivalent(Idea1, Idea2, true).
 equivalent_ideas(Idea1, Idea2, structurally_equivalent) :-
    Idea1 =.. [F|A1],
    Idea2 =.. [F|A2],
    same_length(A1, A2).
 equivalent_ideas(_Idea1, _Idea2, unknown).
