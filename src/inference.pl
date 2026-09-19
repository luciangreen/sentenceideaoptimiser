:- module(inference,
    [ compose_rules/2,
      infer_rule/3,
      derive_rules/2,
      idea_rules/2,
      candidate_solution/3
    ]).

:- use_module(parser, [sentence_idea/2]).
:- use_module(idea_ir, [idea_operations/2]).
:- use_module(ontology, [rule/2, ontology_rule/7, synonym/2]).
:- use_module(rule_graph, [rule_path/3]).

compose_rules(Rules, composition(Rules)).

infer_rule(A, C, derived_rule(A_to_C, [A, B], proof(path([A,B,C])))) :-
    rule(A, Next),
    member(B, Next),
    rule(B, Next2),
    member(C, Next2),
    atom_concat(A, '_to_', T1),
    atom_concat(T1, C, A_to_C).

derive_rules(KnownRules, DerivedRules) :-
    findall(D,
        ( member(A, KnownRules),
          infer_rule(A, _, D)
        ),
        Ds),
    sort(Ds, DerivedRules).

idea_rules(Idea, Rules) :-
    idea_operations(Idea, Ops),
    findall(rule_candidate(Name, Evidence),
        (
            member(Op, Ops),
            candidate_rule_for_op(Op, Name, Evidence)
        ),
        Raw),
    sort(Raw, Rules).

candidate_rule_for_op(Op, Name, evidence(operation(Op), ontology_rule(Name))) :-
    ontology_rule(Name, _, _, _, Op, _, _).
candidate_rule_for_op(Op, Name, evidence(operation(Op), synonym(Syn))) :-
    synonym(Op, Syn),
    ontology_rule(Name, _, _, _, Syn, _, _).
candidate_rule_for_op(Op, Op, evidence(operation(Op), fallback)).

candidate_solution(Idea, Chain, Evidence) :-
    idea_rules(Idea, [rule_candidate(Name, _)|_]),
    ( rule_path(Name, _, Chain) -> true ; Chain = [Name] ),
    Evidence = evidence(from_idea(Idea), via(Name)).
candidate_solution(Sentence, Chain, Evidence) :-
    string(Sentence),
    sentence_idea(Sentence, Idea),
    candidate_solution(Idea, Chain, Evidence).
