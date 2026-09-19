:- begin_tests(graph).

:- use_module('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl').

:- initialization(load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl')).

test(direct_rule_connection) :-
    connected_rule(ab, ac).

test(multihop_rule_path) :-
    rule_path(ab, eb, Path),
    member(Path, [[ab,cb,eb],[ab,ax,eb]]).

test(nested_expansion) :-
    expand_rule_recursive(ab, Tree),
    Tree = node(ab, _).

:- end_tests(graph).
