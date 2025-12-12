# pgvector-tcl

[pgvector](https://github.com/pgvector/pgvector) examples for Tcl

Supports [tdbc::postgres](https://www.tcl-lang.org/man/tcl9.0/TdbcpostgresCmd/tdbc_postgres.html)

[![Build Status](https://github.com/pgvector/pgvector-tcl/actions/workflows/build.yml/badge.svg)](https://github.com/pgvector/pgvector-tcl/actions)

## Getting Started

Follow the instructions for your database library:

- [tdbc::postgres](#tdbcpostgres)

## tdbc::postgres

Enable the extension

```tcl
$db allrows "CREATE EXTENSION IF NOT EXISTS vector"
```

Create a table

```tcl
$db allrows "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))"
```

Insert vectors

```tcl
set params [dict create embedding {[1,2,3]} embedding2 {[4,5,6]}]
$db allrows "INSERT INTO items (embedding) VALUES (:embedding), (:embedding2)" $params
```

Get the nearest neighbors

```tcl
set params [dict create embedding {[3,1,2]}]
$db foreach row "SELECT * FROM items ORDER BY embedding <-> :embedding LIMIT 5" $params {
    puts $row
}
```

Add an approximate index

```tcl
$db allrows "CREATE INDEX ON items USING hnsw (embedding vector_l2_ops)"
```

Use `vector_ip_ops` for inner product and `vector_cosine_ops` for cosine distance

See a [full example](example.tcl)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/pgvector/pgvector-tcl/issues)
- Fix bugs and [submit pull requests](https://github.com/pgvector/pgvector-tcl/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/pgvector/pgvector-tcl.git
cd pgvector-tcl
createdb pgvector_tcl_test
tclsh example.tcl
```

Specify the path to libpq if needed:

```sh
ln -s /opt/homebrew/opt/libpq/lib/libpq.dylib libpq.dylib
```
