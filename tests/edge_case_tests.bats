#!/usr/bin/env bats

setup() {
  export valid_c_file="tests/test_files/hello.c"
}

@test "Handle output file cleanup correctly" {
  # Test that compiled output is cleaned up by default
  run src/run-gcc "$valid_c_file"
  [ "$status" -eq 0 ]
  
  # Check that no output file remains
  [ ! -f "hello" ]
}

@test "Verify configuration loading works correctly" {
  # Test that config loading works without errors
  echo 'show_diff="true"' > .run-gccrc-test
  echo 'cleanup_output="false"' >> .run-gccrc-test
  
  run bash -c "source .run-gccrc-test && src/run-gcc '$valid_c_file'"
  
  # Clean up
  rm -f .run-gccrc-test hello
  
  [ "$status" -eq 0 ]
  [[ "$output" == *"Hello World!"* ]]
}

@test "Verify error message consistency" {
  # Test missing file error
  run src/run-gcc "nonexistent.c"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Error:"* ]]
  [[ "$output" == *"does not exist"* ]]
}

@test "Handle special characters in file paths" {
  # Create a test file with spaces (if possible)
  local test_file_with_spaces="tests/test_files/hello with spaces.c"
  if [[ ! -f "$test_file_with_spaces" ]]; then
    cp "$valid_c_file" "$test_file_with_spaces" || skip "Cannot create file with spaces"
  fi
  
  run src/run-gcc "$test_file_with_spaces"
  
  # Clean up
  rm -f "$test_file_with_spaces" "hello with spaces"
  
  [ "$status" -eq 0 ]
  [[ "$output" == *"Hello World!"* ]]
}