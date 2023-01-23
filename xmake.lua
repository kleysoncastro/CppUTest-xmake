set_project("template-cpputest")

set_version("1.0.0")

-- local lib cpputest

cpputest_home = "/usr/"

set_warnings("all", "error")


if is_mode("debug", "check", "coverage") then

    -- enable the debug symbols
    set_symbols("debug")

    -- disable optimization
    set_optimize("none")

    -- add defines for debug
    add_defines("__tb_debug__")

    -- attempt to enable some checkers for pc
    if is_mode("check") and is_arch("i386", "x86_64") then
        add_cxflags("-fsanitize=address", "-ftrapv")
        add_mxflags("-fsanitize=address", "-ftrapv")
        add_ldflags("-fsanitize=address")
    end

    -- enable coverage
    if is_mode("coverage") then
        add_cxflags("--coverage")
        add_mxflags("--coverage")
        add_ldflags("--coverage")
    end
end

-- the release mode
if is_mode("release") then

    -- set the symbols visibility: hidden
    set_symbols("hidden")

    -- enable fastest optimization
    set_optimize("fastest")

    -- strip all symbols
    set_strip("all")
end




-- add target
target("main")

    set_kind("binary")
    set_toolset("cxx", "clang")
    set_toolset("ld", "clang++")


    -- add include directories
    add_includedirs("include")
    add_includedirs("include/mqtt")


    -- add files
    add_files("src/**.cpp")
    add_files("include/mqtt/mqtt_util.cpp")



-- add target
target("tests")

    -- set kind
    set_kind("binary")
    set_toolset("cxx", "clang")
    set_toolset("ld", "clang++")

    add_includedirs("include", cpputest_home .. "include")
    add_includedirs("include/mqtt")

    -- add link library

    add_links("CppUTest")
    add_links("CppUTestExt")

    -- add_linkdirs(cpputest_home .. "lib")

    -- add files tests
    add_files("tests/*.cpp")
    add_files("tests/mqtt/*.cpp")
    -- add files include 
    add_files("include/mqtt/mqtt_util.cpp")


