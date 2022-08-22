set(dmg "${bin_dir}/${FOUND_FILE_1}")
execute_process(COMMAND hdiutil udifderez -xml "${dmg}" OUTPUT_VARIABLE out ERROR_VARIABLE err RESULT_VARIABLE res)
if(NOT res EQUAL 0)
  string(REPLACE "\n" "\n  " err "  ${err}")
  message(FATAL_ERROR "Running 'hdiutil udifderez -xml' on\n  ${dmg}\nfailed with:\n${err}")
endif()
foreach(key "LPic" "STR#" "TEXT")
  if(out MATCHES "<key>${key}</key>")
    string(REPLACE "\n" "\n  " out "  ${out}")
    message(FATAL_ERROR "error: running 'hdiutil udifderez -xml' on\n  ${dmg}\nhas unexpected '${key}' key:\n${out}")
  endif()
endforeach()
