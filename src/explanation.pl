:- module(explanation, [explain_reasoning/2]).

explain_reasoning(
    report(
        sentence(S),
        parsed_idea(Idea),
        original_chain(Original),
        original_cost(OCost),
        alternative_chain(Alt),
        alternative_cost(ACost),
        equivalence(Eq),
        result(Result),
        improvement(Improve),
        _
    ),
    Text
) :-
    format(string(Text),
        "Sentence: ~w~nIdea: ~w~nOriginal chain: ~w (cost ~w)~nAlternative: ~w (cost ~w)~nEquivalence: ~w~nResult: ~w~nImprovement: ~w",
        [S, Idea, Original, OCost, Alt, ACost, Eq, Result, Improve]).
