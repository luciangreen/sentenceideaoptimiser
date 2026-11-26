:- begin_tests(equivalence).

:- use_module('../src/main.pl').

% Load the ontology relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../ontology/core_rules.pl', '/ontology/core_rules.pl']),
       atomic_list_concat([Dir, Rel], Path),
       exists_file(Path)
   ->  load_ontology(Path)
   ;   throw(error(existence_error(file, 'ontology/core_rules.pl'), _))
   ).

test(proven_equivalence_under_conditions) :-
    equivalent_ideas([reverse_list, first_item], [last_item], Evidence),
    Evidence = proven(ontology(nonempty_list)).

test(identical_ideas_are_equivalent) :-
    equivalent_ideas(foo(a,b), foo(a,b), proven(identity)).

test(different_ideas_need_evidence) :-
    equivalent_ideas(foo(a,b), foo(c,d), unknown).

:- end_tests(equivalence).
