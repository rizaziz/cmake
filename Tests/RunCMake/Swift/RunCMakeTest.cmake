include(RunCMake)

if(RunCMake_GENERATOR STREQUAL Xcode)
  if(XCODE_BELOW_6_1)
    run_cmake(XcodeTooOld)
  endif()
elseif(RunCMake_GENERATOR STREQUAL Ninja)
  if(CMAKE_Swift_COMPILER)
    if (CMAKE_SYSTEM_NAME MATCHES "Windows")
      run_cmake_with_options(Win32ExecutableDisallowed)
    else()
      run_cmake_with_options(Win32ExecutableIgnored)
      set(RunCMake_TEST_OPTIONS -DCMAKE_SYSTEM_NAME=Darwin)
      run_cmake(SwiftMultiArch)
      unset(RunCMake_TEST_OPTIONS)
    endif()
  endif()
elseif(RunCMake_GENERATOR STREQUAL "Ninja Multi-Config")
  if(CMAKE_Swift_COMPILER)
    set(RunCMake_TEST_OPTIONS "-DCMAKE_CONFIGURATION_TYPES=Debug\\;Release")
    run_cmake(SwiftSimple)
    unset(RunCMake_TEST_OPTIONS)
  endif()
else()
  run_cmake(NotSupported)
endif()