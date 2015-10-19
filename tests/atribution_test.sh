#! /bin/sh
# file: atribution_test.sh

test_unitiliazed_variable(){
  ./defus atribution/simpleatribution.c
  output=$(grep -r "Decclaração de variável encontrada!" ../output/message.txt)
  msg="Declaração de variável encontrada!"
  assertEquals "$output" "$msg"
}


# load shunit2
. src/shunit2
