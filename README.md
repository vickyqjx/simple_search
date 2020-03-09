

# Zendesk Search
This is a zendesk search solution

## Prerequisite

- Erlang ~> 21
- Elixir ~> 1.8

### How to install Erlang
Using Homebrew
```
brew install erlang
```
For other OS: [https://www.erlang.org/downloads](https://www.erlang.org/downloads)

### How to install Elixir
Using Homebrew
```
brew install elixir
```
For other OS: [https://elixir-lang.org/install.html](https://elixir-lang.org/install.html)
## How to Run

**Run under project directory**

Install dependencies:
```
mix deps.get
```

Building our executable:
```
mix escript.build
```

Start application:
```
./zendesk_search
```

## Test
Run test:
```elixir
mix test
```
