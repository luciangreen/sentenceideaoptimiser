:- begin_tests(parser).

:- use_module('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl').

:- initialization(load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl')).

test(sentence_parse_find_positions) :-
    sentence_idea("Find the position of every a in the input and return the positions.", Idea),
    Idea = idea(operation(find_positions), item(a), source(input), property(position), quantifier(all), result(positions)).

test(sentence_parse_code_concept) :-
    sentence_idea("Reverse the list and take the first item.", Idea),
    Idea = sequence([reverse(list,input,reversed), first(reversed,output)]).

test(unknown_concepts) :-
    sentence_idea("Blorp the quux", idea(unknown, unknown_concepts(U))),
    U == ["blorp","the","quux"].

:- end_tests(parser).
