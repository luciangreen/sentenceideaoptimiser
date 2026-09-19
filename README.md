# sentenceideaoptimiser

Sentence Idea Optimiser in SWI-Prolog.

## Run CLI

```bash
swipl /home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl --sentence "Reverse the list and take the first item"
swipl /home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl --rule ab
swipl /home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/src/main.pl --from ab --to eb
```

## Ontology extension

Add facts to files under `/home/runner/work/sentenceideaoptimiser/sentenceideaoptimiser/ontology/` using these forms:

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
