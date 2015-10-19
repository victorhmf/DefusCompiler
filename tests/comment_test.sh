#! /bin/sh
# file: atribution_test.sh

test_comment_missing(){
  ./../defus comments/no_comments.c > ../output/log.txt
  output=$(grep -r "Nenhum comentario encontrado!" ../output/log.txt)
  msg="Nenhum comentario encontrado!"
  assertEquals "$output" "$msg"
}


test_single_line_comment(){
  ./../defus comments/simple_single_line_comment.c > ../output/log.txt
  output=$(cat ../output/log.txt)
  msg="sl comment "
  assertEquals "$msg" "$output"
}

test_multiple_line_comment(){
  ./../defus comments/simple_multiple_line_comment.c > ../output/log.txt
  output=$(cat ../output/log.txt)
  msg="ml comment "
  assertEquals "$output" "$msg"
}


# load shunit2
. src/shunit2
