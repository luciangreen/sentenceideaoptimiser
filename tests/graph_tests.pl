:- begin_tests(graph).

:- use_module('../src/main.pl').

% Load the ontology relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../ontology/core_rules.pl', '/ontology/core_rules.pl']),
       atomic_list_concat([Dir, Rel], Path),
       exists_file(Path)
   ->  load_ontology(Path)
   ;   throw(error(existence_error(file, 'ontology/core_rules.pl'), _))
   ).

test(direct_rule_connection) :-
    connected_rule(ab, ac).

test(multihop_rule_path) :-
    rule_path(ab, eb, Path),
    member(Path, [[ab,cb,eb],[ab,ax,eb]]).

test(nested_expansion) :-
    expand_rule_recursive(ab, Tree),
    Tree = node(ab, _).

:- end_tests(graph).
