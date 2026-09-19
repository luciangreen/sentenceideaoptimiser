:- module(idea_ir,
    [ idea_normal_form/2,
      idea_operations/2
    ]).

idea_normal_form(Idea, Idea).

idea_operations(sequence(Ops), Ops) :- !.
idea_operations(pipeline(Ops), Ops) :- !.
idea_operations(idea(operation(Op), _, _, _, _, _), [Op]) :- !.
idea_operations(idea(_,_,_,_,_,_), [find_positions]).
idea_operations(Other, [Other]).
