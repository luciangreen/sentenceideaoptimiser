:- begin_tests(parser).

:- use_module('../src/main.pl').

% Load the ontology relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../ontology/core_rules.pl', '/ontology/core_rules.pl']),
       atomic_list_concat([Dir, Rel], Path),
       exists_file(Path)
   ->  load_ontology(Path)
   ;   throw(error(existence_error(file, 'ontology/core_rules.pl'), _))
   ).

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
