:- begin_tests(equivalence).

:- use_module('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl').

:- initialization(load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl')).

test(proven_equivalence_under_conditions) :-
    equivalent_ideas([reverse_list, first_item], [last_item], Evidence),
    Evidence = proven(ontology(nonempty_list)).

test(structural_equivalence) :-
    equivalent_ideas(foo(a,b), foo(c,d), structurally_equivalent).

:- end_tests(equivalence).
