:- module(optimiser,
    [ optimise_rule_chain/3,
      optimise_idea/3,
      check_sentence_optimised/2,
      propose_rule/2,
      accept_rule/1,
      reject_rule/1
    ]).

:- use_module(parser, [sentence_idea/2]).
:- use_module(inference, [idea_rules/2]).
:- use_module(cost, [chain_cost/2]).
:- use_module(equivalence, [equivalent_ideas/3]).
:- use_module(proof, [build_proof/5]).
:- use_module(ontology, [ontology_rule/7, equivalent/3]).

:- dynamic learned_rule/1.
:- dynamic accepted_rule/1.

optimise_rule_chain(Chain, OptimisedChain, Proof) :-
    ( direct_replacement(Chain, Candidate, Eq) ->
        chain_cost(Chain, C1),
        chain_cost(Candidate, C2),
        ( C2 < C1 -> OptimisedChain = Candidate
        ; OptimisedChain = Chain
        ),
        Proof = proof(replacement(Chain, Candidate, Eq), costs(C1, C2))
    ; OptimisedChain = Chain,
      chain_cost(Chain, C),
      Proof = proof(no_replacement, costs(C, C))
    ).

 direct_replacement([reverse_list, first_item], [last_item], equivalent_under(nonempty_list)) :-
    !.
 direct_replacement([reverse, first], [last], equivalent_under(nonempty_list)) :- !.
 direct_replacement([A,B], [C], equivalence_from_ontology(Cond)) :-
    equivalent(sequence([A,B]), C, Cond).

optimise_idea(Idea, OptimisedIdea, Proof) :-
    idea_rules(Idea, Candidates),
    findall(Name, member(rule_candidate(Name,_), Candidates), Chain0),
    Chain0 \= [],
    optimise_rule_chain(Chain0, OptimisedChain, RuleProof),
    OptimisedIdea = idea_implementation(OptimisedChain),
    Proof = proof(idea(Idea), RuleProof).

check_sentence_optimised(Sentence, Report) :-
    sentence_idea(Sentence, ParsedIdea),
    initial_chain(ParsedIdea, OriginalChain),
    chain_cost(OriginalChain, OriginalCost),
    optimise_rule_chain(OriginalChain, AlternativeChain, OptimiseProof),
    chain_cost(AlternativeChain, AlternativeCost),
    equivalent_ideas(OriginalChain, AlternativeChain, Equivalence),
    status_from_cost_and_equivalence(OriginalCost, AlternativeCost, Equivalence, Status),
    Improvement is OriginalCost - AlternativeCost,
    build_proof(sentence_optimisation, ParsedIdea, OriginalChain, AlternativeChain, MachineProof),
    Report = report(
        sentence(Sentence),
        parsed_idea(ParsedIdea),
        original_chain(OriginalChain),
        original_cost(OriginalCost),
        alternative_chain(AlternativeChain),
        alternative_cost(AlternativeCost),
        equivalence(Equivalence),
        result(Status),
        improvement(Improvement),
        proof([OptimiseProof, MachineProof])
    ).

initial_chain(sequence([reverse(_, _, _), first(_, _)]), [reverse_list, first_item]) :- !.
initial_chain(sequence([reverse, first]), [reverse, first]) :- !.
initial_chain(idea(operation(find_positions), _, _, _, _, _), [enumerate_input, compare_character, obtain_position, collect_results]) :- !.
initial_chain(_, [unknown_operation]).

status_from_cost_and_equivalence(C1, C2, proven(_), not_optimised) :- C2 < C1, !.
status_from_cost_and_equivalence(_C1, _C2, unknown, optimisation_unproved) :- !.
status_from_cost_and_equivalence(_C1, _C2, structurally_equivalent, optimisation_unproved) :- !.
status_from_cost_and_equivalence(_C1, _C2, _, already_optimised).

propose_rule(Derivation, Rule) :-
    Rule = derived_rule(Derivation),
    assertz(learned_rule(Rule)).

accept_rule(Rule) :-
    learned_rule(Rule),
    assertz(accepted_rule(Rule)).

reject_rule(Rule) :-
    retractall(learned_rule(Rule)),
    retractall(accepted_rule(Rule)).
