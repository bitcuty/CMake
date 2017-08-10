set(__UNDOCUMENTED_CMAKE_FIND_PACKAGE_ROOT 1)
cmake_policy(SET CMP0057 NEW)
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/PackageRoot)
set(PackageRoot_BASE ${CMAKE_CURRENT_SOURCE_DIR}/PackageRoot)

macro(CleanUpPackageRootTest)
  unset(Foo_ROOT)
  unset(ENV{Foo_ROOT})
  unset(FOO_TEST_FILE_FOO)
  unset(FOO_TEST_FILE_ZOT)
  unset(FOO_TEST_PATH_FOO)
  unset(FOO_TEST_PATH_ZOT)
  unset(FOO_TEST_PROG_FOO)
  unset(FOO_TEST_FILE_FOO CACHE)
  unset(FOO_TEST_FILE_ZOT CACHE)
  unset(FOO_TEST_PATH_FOO CACHE)
  unset(FOO_TEST_PATH_ZOT CACHE)
  unset(FOO_TEST_PROG_FOO CACHE)
endmacro()

macro(RunPackageRootTest)
  message("----------")
  message("Foo_ROOT      :${Foo_ROOT}")
  message("ENV{Foo_ROOT} :$ENV{Foo_ROOT}")
  message("")

  find_package(Foo)
  message("find_package(Foo)")
  message("FOO_TEST_FILE_FOO :${FOO_TEST_FILE_FOO}")
  message("FOO_TEST_FILE_ZOT :${FOO_TEST_FILE_ZOT}")
  message("FOO_TEST_PATH_FOO :${FOO_TEST_PATH_FOO}")
  message("FOO_TEST_PATH_ZOT :${FOO_TEST_PATH_ZOT}")
  message("FOO_TEST_PROG_FOO :${FOO_TEST_PROG_FOO}")
  CleanUpPackageRootTest()
  message("")
endmacro()

RunPackageRootTest()

set(Foo_ROOT      ${PackageRoot_BASE}/foo/cmake_root)
RunPackageRootTest()

set(ENV{Foo_ROOT} ${PackageRoot_BASE}/foo/env_root)
RunPackageRootTest()

set(Foo_ROOT      ${PackageRoot_BASE}/foo/cmake_root)
set(ENV{Foo_ROOT} ${PackageRoot_BASE}/foo/env_root)
RunPackageRootTest()
