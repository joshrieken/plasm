# Plasm

A composable query library for [Ecto](https://github.com/elixir-lang/ecto).

:heart::heart::heart: Ecto, :cry::cry::cry: because I have to implement my own count and random and whatnot functions in all my projects.

NO MORE.


## Examples

Instead of writing this in your model:

``` elixir
def count(query) do
  for q in query,
  select: count("*")
end
```

And using it this way:
``` elixir
Quaffle |> Quaffle.count |> Repo.one
```

Just use Plasm:

``` elixir
Quaffle |> Plasm.count |> Repo.one
```

More examples:

``` elixir
Boggart |> Plasm.updated_after("2016-01-04T14:00:00Z") |> Plasm.take(10) |> Repo.all
```

``` elixir
Truffle |> Plasm.for_ids([3,6,9]) |> Repo.all
```

``` elixir
MagicalElixir |> Plasm.random |> Repo.one
```


## Inspiration

Many thanks to Drew Olson (@drewolson) for his [talk at ElixirConf 2015](https://www.youtube.com/watch?v=g84TDHt9MDc) and [insightful blog post](http://blog.drewolson.org/composable-queries-ecto/) on the subject of composable Ecto queries.


## TODO:

- [ ] Tests
- [ ] Hex docs
- [ ] More functions


## Installation

Add Plasm to your list of dependencies in `mix.exs`:

``` elixir
def deps do
  [{:plasm, "~> 0.0.1"}]
end
```

Ensure Plasm is started before your application:

``` elixir
def application do
  [applications: [:plasm]]
end
```


## Copyright and License

Copyright (c) 2016, Atomic Fads LLC.

Plasm source code is licensed under the Apache 2 License (see LICENSE.md).
