package require tdbc::postgres 1.0

set db [tdbc::postgres::connection new -db pgvector_tcl_test]

$db allrows "CREATE EXTENSION IF NOT EXISTS vector"

$db allrows "DROP TABLE IF EXISTS items"

$db allrows "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))"

set params [dict create embedding {[1,2,3]} embedding2 {[4,5,6]}]
$db allrows "INSERT INTO items (embedding) VALUES (:embedding), (:embedding2)" $params

set params [dict create embedding {[3,1,2]}]
$db foreach row "SELECT * FROM items ORDER BY embedding <-> :embedding LIMIT 5" $params {
    puts $row
}

$db close
