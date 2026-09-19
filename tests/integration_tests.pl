:- begin_tests(integration).

:- use_module('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl').

:- initialization(load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl')).

test(explain_reasoning_text) :-
    check_sentence_optimised("Reverse the list and take the first item", Report),
    explain_reasoning(Report, Text),
    sub_string(Text, _, _, _, "Original chain").

test(least_cost_path) :-
    least_cost_rule_path(ab, eb, Path, Cost),
    member(Path, [[ab,ax,eb],[ab,cb,eb]]),
    integer(Cost).

:- end_tests(integration).
