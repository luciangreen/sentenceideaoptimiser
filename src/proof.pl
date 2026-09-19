:- module(proof, [build_proof/5]).

build_proof(Goal, ParsedIdea, OriginalChain, Alternative, proof(
    goal(Goal),
    steps([
        semantic_parse(ParsedIdea),
        original_chain(OriginalChain),
        alternative_chain(Alternative)
    ])
)).
