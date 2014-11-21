# SpecsWatcher

TODO: Write a gem description

## Installation

```shell
git clone git@vault.aaronortbals.com:aortbals/specs_watcher.git
cd specs_watcher
gem build specs_watcher.gemspec && gem install specs_watcher
```

## Usage

### Commands

Commands:

Check availability for an item by zip code and UPC

```
specs_watcher availability ZIP UPC
```

Search through Spec's Liquor Inventory

```
specs_watcher search [KEYWORD] [(--category | -c) CATEGORY] [(--verbose | -v)]
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
