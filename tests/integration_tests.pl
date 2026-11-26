:- begin_tests(integration).

:- use_module('../src/main.pl').

% Load the ontology relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../ontology/core_rules.pl', '/ontology/core_rules.pl']),
       atomic_list_concat([Dir, Rel], Path),
       exists_file(Path)
   ->  load_ontology(Path)
   ;   throw(error(existence_error(file, 'ontology/core_rules.pl'), _))
   ).

test(explain_reasoning_text) :-
    check_sentence_optimised("Reverse the list and take the first item", Report),
    explain_reasoning(Report, Text),
    sub_string(Text, _, _, _, "Original chain").

test(least_cost_path) :-
    least_cost_rule_path(ab, eb, Path, Cost),
    member(Path, [[ab,ax,eb],[ab,cb,eb]]),
    integer(Cost).

:- end_tests(integration).
