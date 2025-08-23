#!/usr/bin/env bats

setup() {
  export valid_c_file="tests/test_files/hello.c"
}

@test "Handle missing bc dependency" {
  # Temporarily rename bc to simulate it being missing
  if command -v bc >/dev/null 2>&1; then
    sudo mv "$(which bc)" "$(which bc).bak" 2>/dev/null || skip "Cannot move bc command"
    
    run src/run-gcc "$valid_c_file" -p
    
    # Restore bc
    sudo mv "$(which bc).bak" "$(which bc)" 2>/dev/null || true
    
    [ "$status" -ne 0 ]
    [[ "$output" == *"Missing required dependencies: bc"* ]]
  else
    run src/run-gcc "$valid_c_file" -p
    [ "$status" -ne 0 ]
    [[ "$output" == *"Missing required dependencies: bc"* ]]
  fi
}