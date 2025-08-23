#!/usr/bin/env bats

setup() {
  export test_c_file="tests/test_files/hello.c"
}

@test "Handle spaces in compiler flags safely" {
  # Create a config with spaces in flags to test proper quoting
  echo 'compiler_flags="-Wall -Wextra -O2"' > .run-gccrc-test
  echo 'c_flags="-std=c11 -pedantic"' >> .run-gccrc-test
  echo 'linker_flags="-lm -static"' >> .run-gccrc-test
  
  # Test compilation with spaced flags
  run bash -c "source .run-gccrc-test && src/run-gcc '$test_c_file'"
  
  # Clean up
  rm -f .run-gccrc-test
  
  [ "$status" -eq 0 ]
  [[ "$output" == *"Hello World!"* ]]
}

@test "Verify temp file cleanup" {
  # Count temp files before
  temp_count_before=$(ls -1 /tmp/run-gcc-* 2>/dev/null | wc -l || echo 0)
  
  # Run with performance measurement to create temp files
  if command -v bc >/dev/null 2>&1; then
    run src/run-gcc "$test_c_file" -p
    [ "$status" -eq 0 ]
  fi
  
  # Count temp files after
  temp_count_after=$(ls -1 /tmp/run-gcc-* 2>/dev/null | wc -l || echo 0)
  
  # Should have cleaned up temp files
  [ "$temp_count_after" -eq "$temp_count_before" ]
}