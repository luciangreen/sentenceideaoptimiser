:- begin_tests(optimiser).

:- use_module('../src/main.pl').

% Load the ontology relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../ontology/core_rules.pl', '/ontology/core_rules.pl']),
       atomic_list_concat([Dir, Rel], Path),
       exists_file(Path)
   ->  load_ontology(Path)
   ;   throw(error(existence_error(file, 'ontology/core_rules.pl'), _))
   ).

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

test(unknown_sentence_not_understood) :-
    check_sentence_optimised("Sort the list and take the first item", Report),
    assertion(Report = report(_, parsed_idea(unknown), unknown_words(_), result(not_understood), _, _)),
    explain_reasoning(Report, Text),
    assertion(sub_string(Text, _, _, _, "not_understood")).

test(then_reads_as_and) :-
    check_sentence_optimised("Reverse the list, then take the first item", Report),
    assertion(arg(8, Report, result(not_optimised))).

test(last_item_already_optimised) :-
    check_sentence_optimised("Take the last item", Report),
    assertion(arg(8, Report, result(already_optimised))).

test(parsed_idea_without_rules) :-
    check_sentence_optimised("For every character return its index", Report),
    assertion(arg(8, Report, result(no_rules_for_idea))).

:- end_tests(optimiser).
