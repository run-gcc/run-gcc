#!/usr/bin/env bats

setup() {
  export test_file="test_new_file"
  export script_path="src/run-gcc"
  # Clean up any existing test files
  rm -f "${test_file}.c" "${test_file}.cpp" "${test_file}_competitive.c" "${test_file}_competitive.cpp"
}

teardown() {
  # Clean up test files after each test
  rm -f "${test_file}.c" "${test_file}.cpp" "${test_file}_competitive.c" "${test_file}_competitive.cpp"
}

@test "List available C templates" {
  run $script_path --list-templates c
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Available templates for .c files:" ]]
  [[ "$output" =~ "default" ]]
}

@test "List available C++ templates" {
  run $script_path --list-templates cpp
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Available templates for .cpp files:" ]]
  [[ "$output" =~ "default" ]]
}

@test "Create a new C file with default template" {
  run $script_path --new "${test_file}.c"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Success: Created '${test_file}.c' from template 'default'" ]]
  [ -f "${test_file}.c" ]
  # Check that file contains expected content
  grep -q "#include <stdio.h>" "${test_file}.c"
  grep -q "int main()" "${test_file}.c"
}

@test "Create a new C++ file with default template" {
  run $script_path --new "${test_file}.cpp"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Success: Created '${test_file}.cpp' from template 'default'" ]]
  [ -f "${test_file}.cpp" ]
  # Check that file contains expected content
  grep -q "#include <iostream>" "${test_file}.cpp"
  grep -q "int main()" "${test_file}.cpp"
}

@test "Create a new C file with competitive template" {
  run $script_path --new "${test_file}_competitive.c" --template competitive
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Success: Created '${test_file}_competitive.c' from template 'competitive'" ]]
  [ -f "${test_file}_competitive.c" ]
  # Check that file contains expected content
  grep -q "#include <stdio.h>" "${test_file}_competitive.c"
  grep -q "scanf" "${test_file}_competitive.c"
}

@test "Create a new C++ file with competitive template" {
  run $script_path --new "${test_file}_competitive.cpp" --template competitive
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Success: Created '${test_file}_competitive.cpp' from template 'competitive'" ]]
  [ -f "${test_file}_competitive.cpp" ]
  # Check that file contains expected content
  grep -q "#include <iostream>" "${test_file}_competitive.cpp"
  grep -q "ios_base::sync_with_stdio" "${test_file}_competitive.cpp"
}

@test "Error when creating file that already exists" {
  # Create the file first
  $script_path --new "${test_file}.c"
  
  # Try to create it again
  run $script_path --new "${test_file}.c"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Error: File '${test_file}.c' already exists" ]]
}

@test "Error when using invalid template name" {
  run $script_path --new "${test_file}.c" --template invalid_template
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Warning: Template 'invalid_template' not found" ]]
  [[ "$output" =~ "Available templates for .c files:" ]]
  # File should not be created
  [ ! -f "${test_file}.c" ]
}

@test "Error when using unsupported file extension" {
  run $script_path --new "${test_file}.py"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Error: Unsupported file extension 'py'" ]]
}

@test "Compile and run a file created from template" {
  # Create a new C file
  $script_path --new "${test_file}.c"
  
  # Modify the file to have some actual code
  cat > "${test_file}.c" << 'EOF'
#include <stdio.h>

int main() {
    printf("Hello from template!\n");
    return 0;
}
EOF
  
  # Compile and run the file
  run $script_path "${test_file}.c"
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "Hello from template!" ]]
}
