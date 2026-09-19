:- module(rule_graph,
    [ connected_rule/2,
      rule_path/3,
      rule_paths/3,
      expand_rule/2,
      expand_rule_recursive/2
    ]).

:- use_module(ontology, [rule/2, relation/2]).

connected_rule(A, B) :-
    rule(A, Bs),
    member(B, Bs).
connected_rule(A, B) :-
    relation(expands(A), B).

rule_path(A, B, Path) :-
    rule_path(A, B, [A], Rev),
    reverse(Rev, Path).

rule_path(B, B, Visited, Visited).
rule_path(A, B, Visited, Path) :-
    connected_rule(A, Next),
    \+ memberchk(Next, Visited),
    rule_path(Next, B, [Next|Visited], Path).

rule_paths(A, B, Paths) :-
    findall(Path, rule_path(A, B, Path), Raw),
    sort(Raw, Paths).

expand_rule(Rule, Expansion) :-
    ( rule(Rule, Expansion) -> true ; Expansion = [Rule] ).

expand_rule_recursive(Rule, Tree) :-
    expand_rule_recursive(Rule, [], Tree).

expand_rule_recursive(Rule, Visited, recursion(Rule)) :-
    memberchk(Rule, Visited), !.
expand_rule_recursive(Rule, _Visited, leaf(Rule)) :-
    \+ rule(Rule, _), !,
    \+ relation(expands(Rule), _).
expand_rule_recursive(Rule, Visited, node(Rule, Children)) :-
    ( rule(Rule, Nexts) -> Targets = Nexts
    ; findall(N, relation(expands(Rule), N), Targets)
    ),
    maplist(expand_child([Rule|Visited]), Targets, Children).

expand_child(Visited, Child, Tree) :-
    expand_rule_recursive(Child, Visited, Tree).
