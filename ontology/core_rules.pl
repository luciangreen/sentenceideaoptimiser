rule(ab, [ac, cb]).
rule(ac, [ad, dc]).
rule(cb, [ce, eb]).
rule(ab, [ax]).
rule(ax, [ad, dc, ce, eb]).

ontology_rule(reverse_list, [list], [list], [], reverse, 5, [deterministic, pure]).
ontology_rule(first_item, [list], [item], [nonempty_list], first, 2, [deterministic, pure]).
ontology_rule(last_item, [list], [item], [nonempty_list], last, 1, [deterministic, pure]).
ontology_rule(enumerate_input, [input], [stream], [], enumerate, 2, [pure]).
ontology_rule(compare_character, [stream], [match], [], compare, 2, [pure]).
ontology_rule(obtain_position, [match], [position], [], position, 2, [pure]).
ontology_rule(collect_results, [position], [positions], [], collect, 2, [pure]).
ontology_rule(indexed_character_search, [input], [positions], [], indexed_search, 3, [pure]).
ontology_rule(reverse_first, [list], [item], [nonempty_list], reverse_first, 7, [pure]).

synonym(find, enumerate).
synonym(position, index).
synonym(positions, indexes).
synonym(reverse, reverse).

equivalent(sequence([reverse_list, first_item]), last_item, nonempty_list).
equivalent([reverse_list, first_item], [last_item], nonempty_list).
equivalent(sequence([reverse, first]), last, nonempty_list).
