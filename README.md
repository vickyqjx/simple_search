# Zendesk Search
This is a zendesk search solution

## Prerequisite

- Erlang ~> 21
- Elixir ~> 1.8

## How to run

### Use Docker

Use the official Elixir docker image. Install [Docker](https://www.docker.com/products/docker-desktop)

Under project root, run the following

```
docker run -it -v $(pwd):/src -w="/src" elixir:1.8 bash
```

Inside the running container, you should be in the `/src` folder. Now you can follow below commands to build the project.

Install dependencies:

```elixir
mix deps.get
```

Building our executable:

```elixir
mix escript.build
```

Start application:

```elixir
./zendesk_search
```

To run tests:

```elixir
mix test
```

### Example
Select which dataset to search:

![Select which dataset to search](https://github.com/vickyqjx/zendesk_search/blob/master/data/images/select_resource.png)

Select which field to search on:

![Select which field to search on](https://github.com/vickyqjx/zendesk_search/blob/master/data/images/select_field.png)

Enter search term, and get results:

![Enter search term, and get results](https://github.com/vickyqjx/zendesk_search/blob/master/data/images/enter_term.png)
