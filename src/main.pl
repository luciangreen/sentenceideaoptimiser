:- module(main,
    [ load_ontology/1,
      sentence_idea/2,
      connected_rule/2,
      rule_path/3,
      expand_rule/2,
      expand_rule_recursive/2,
      infer_rule/3,
      idea_rules/2,
      candidate_solution/3,
      equivalent_ideas/3,
      chain_cost/2,
      least_cost_rule_path/4,
      optimise_rule_chain/3,
      optimise_idea/3,
      check_sentence_optimised/2,
      explain_reasoning/2,
      run_cli/0
    ]).

:- use_module(ontology).
:- use_module(parser).
:- use_module(rule_graph).
:- use_module(inference).
:- use_module(equivalence).
:- use_module(cost).
:- use_module(optimiser).
:- use_module(explanation).

:- initialization(run_cli, main).

run_cli :-
    current_prolog_flag(argv, Argv),
    load_ontology('/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/core_rules.pl'),
    handle_args(Argv).

handle_args(['--sentence', SentenceAtom|_]) :-
    atom_string(SentenceAtom, Sentence),
    check_sentence_optimised(Sentence, Report),
    explain_reasoning(Report, Text),
    format("~s~n", [Text]).
handle_args(['--rule', Rule|_]) :-
    expand_rule_recursive(Rule, Tree),
    format("~q~n", [Tree]).
handle_args(['--from', From, '--to', To|_]) :-
    ( least_cost_rule_path(From, To, Path, Cost) ->
        format("PATH: ~w~nCOST: ~w~n", [Path, Cost])
    ; writeln("No path found")
    ).
handle_args(_) :-
    writeln('Usage:'),
    writeln('  swipl src/main.pl --sentence "Reverse the list and take the first item"'),
    writeln('  swipl src/main.pl --rule ab'),
    writeln('  swipl src/main.pl --from ab --to eb').
