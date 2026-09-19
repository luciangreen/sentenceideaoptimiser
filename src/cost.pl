:- module(cost,
    [ chain_cost/2,
      compare_chains/3,
      least_cost_rule_path/4
    ]).

:- use_module(ontology, [ontology_rule/7]).
:- use_module(rule_graph, [rule_path/3]).

chain_cost(Chain, Cost) :-
    chain_cost(Chain, 0, Cost).

chain_cost([], Acc, Acc).
chain_cost([Rule|Rest], Acc, Cost) :-
    ( ontology_rule(Rule, _, _, _, _, RuleCost, _) -> Acc1 is Acc + RuleCost
    ; Acc1 is Acc + 1
    ),
    chain_cost(Rest, Acc1, Cost).

compare_chains(Chain1, Chain2, comparison(better(Chain1), Cost1, Cost2)) :-
    chain_cost(Chain1, Cost1),
    chain_cost(Chain2, Cost2),
    Cost1 < Cost2, !.
compare_chains(Chain1, Chain2, comparison(better(Chain2), Cost1, Cost2)) :-
    chain_cost(Chain1, Cost1),
    chain_cost(Chain2, Cost2),
    Cost2 < Cost1, !.
compare_chains(Chain1, Chain2, comparison(equal, Cost, Cost)) :-
    chain_cost(Chain1, Cost),
    chain_cost(Chain2, Cost).

least_cost_rule_path(Start, Goal, BestPath, BestCost) :-
    findall(Path, rule_path(Start, Goal, Path), Paths),
    Paths \= [],
    map_list_to_pairs(chain_cost, Paths, Pairs),
    keysort(Pairs, [BestCost-BestPath|_]).
