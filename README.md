# sentenceideaoptimiser

Sentence Idea Optimiser in SWI-Prolog.

## Command showcase

The CLI supports 3 command modes and a fallback usage message.

### 1) Explain whether a sentence is optimised (`--sentence`)

Use this to analyse a sentence and print a full reasoning report.

```bash
swipl main.pl \
  --sentence "Reverse the list and take the first item"
```

What it does:

- loads the core ontology
- checks whether the sentence is already optimised
- prints a human-readable explanation of the reasoning

### 2) Expand a rule recursively (`--rule`)

Use this to inspect how a rule unfolds through recursive expansion.

```bash
swipl main.pl \
  --rule ab
```

What it does:

- loads the core ontology
- recursively expands the selected rule
- prints the expansion tree as a Prolog term

### 3) Find least-cost rule path (`--from` / `--to`)

Use this to find the cheapest path between two rules.

```bash
swipl main.pl \
  --from ab --to eb
```

What it does:

- loads the core ontology
- searches for a least-cost path from `ab` to `eb`
- prints:
  - `PATH: [...]`
  - `COST: <number>`
- prints `No path found` when no connection exists

### 4) Show built-in usage (no arguments)

Use this to print the CLI help text.

```bash
swipl main.pl
```

What it does:

- prints available command forms:
  - `--sentence "<text>"`
  - `--rule <rule_id>`
  - `--from <rule_id> --to <rule_id>`

## Ontology extension

Add facts to files under `ontology/` using these forms:

- `ontology_rule/7`
- `rule/2`
- `equivalent/3`
- relation facts such as `implies/2`, `expands/2`, `requires/2`
- `synonym/2`

Load additional ontology files with `load_ontology/1`.

## Run tests

```bash
swipl -q -g "[tests/parser_tests], [tests/graph_tests], [tests/equivalence_tests], [tests/optimiser_tests], [tests/integration_tests], run_tests, halt"
```

## Results

- `not_optimised`: a cheaper equivalent chain was found and proved.
- `already_optimised`: the sentence was read and no cheaper chain exists.
- `optimisation_unproved`: a cheaper chain exists but its equivalence is not proved.
- `no_rules_for_idea`: the sentence was read, but no rule chain is known for it.
- `not_understood`: the sentence matched no known idea; its words are listed in `unknown_words`.

"X then Y", "X, then Y" and "X and then Y" are read as "X and Y". The tests
load the program and ontology relative to their own folder, so they run from
any checkout.
