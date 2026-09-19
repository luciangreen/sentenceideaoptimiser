:- begin_tests(optimiser).

:- use_module('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl').

:- initialization(load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl')).

test(chain_optimisation) :-
    optimise_rule_chain([reverse_list, first_item], Optimised, _),
    Optimised == [last_item].

test(check_sentence_optimised) :-
    check_sentence_optimised("Reverse the list and take the first item", Report),
    Report = report(_,_,_,_,alternative_chain([last_item]),_,_,result(not_optimised),_,_).

test(cost_compare) :-
    chain_cost([reverse_list, first_item], C1),
    chain_cost([last_item], C2),
    C2 < C1.

:- end_tests(optimiser).
