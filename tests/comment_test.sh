#! /bin/sh
# file: atribution_test.sh

test_multiline_comment(){
  output=$(grep -r "Nenhum comentario encontrado!" ../output/log.txt)
  msg="Nenhum comentario encontrado!"
  assertEquals "$output" "$msg"
}


# load shunit2
. src/shunit2
