# SpecsWatcher

A useful CLI for searching Spec's online inventory.

## Installation

```shell
git clone git@vault.aaronortbals.com:aortbals/specs_watcher.git
cd specs_watcher
gem build specs_watcher.gemspec && gem install specs_watcher
```

## Usage

### Commands

Search through Spec's inventory.

```
specs_watcher search [KEYWORD] [(--category | -c) CATEGORY] [(--verbose | -v)]
```

Check availability for an item by zip code and UPC

```
specs_watcher availability ZIP UPC
```

Describe available commands or one specific command

```
specs_watcher help [COMMAND]
```

#### Search

Search by keyword

```
specs_watcher search balvenie
```

List a category

```
specs_watcher -c bourbon
```
