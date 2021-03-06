# Only include a subfolder

This example shows how to only include from a specific folder

## mkdocs.yml

```yaml
{% include "examples/ok-mkdocs-docs-include/mkdocs-test.yml" %}
```

## Input

```
project
│   README.md
|   test.md
|
└───subfolder
|   |    draft.md
|   |    index.md
```

## Output

```
project
│   README.md
|   test.md
|
└───subfolder
|   |    draft.md
|   |    index.md
│
└───site
|   |
|   └───subfolder
│       │   index.html  [From subfolder/index.md, not from README.md]
|       |
|       └───draft
│       │   |    index.html
```
