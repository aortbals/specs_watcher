# SpecsWatcher

Quickly search through Spec’s online inventory and check availability.

## Installation

```shell
gem install specs_watcher
```

## Commands

Search through Spec's inventory.

```
specs_watcher search [KEYWORD] [(--category | -c)=CATEGORY] [(--verbose | -v)] [(--format | -f) FORMAT]
```

Check availability for an item by zip code and UPC

```
specs_watcher availability [ZIP] [UPC]
```

Describe available commands or one specific command

```
specs_watcher help [COMMAND]
```

## Examples

Search by keyword:

```
specs_watcher search balvenie
```

List a category:

```
specs_watcher search -c bourbon
```

Show the available categories:

```
specs_watcher help search
```

Use the power of unix to construct more complex queries:

```
specs_watcher search -c boutique_bourbon | egrep -i '(noahs mill|basil haydens)'
```

Print the output as json:

```
specs_watcher search balvenie -f json
```

Note: `--format json` always includes the additional columns provided by the `--verbose` flag.
