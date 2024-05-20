if not get_option('tests')
  subdir_done()
endif

e = executable('root-test', '../test.c', dependencies: libcjson_dep)
test('root-test', e)

unity_tests = [
    'cjson_add',
    'compare_tests',
    'minify_tests',
    'misc_tests',
    'parse_array',
    'parse_examples',
    'parse_hex4',
    'parse_number',
    'parse_object',
    'parse_string',
    'parse_value',
    'parse_with_opts',
    'print_array',
    'print_number',
    'print_object',
    'print_string',
    'print_value',
    'readme_examples',
]

weak_arg = []
if cc.has_function_attribute('weak')
  weak_arg = '-DUNITY_WEAK_ATTRIBUTE=__attribute__((weak))'
elif cc.has_function_attribute('selectany')
  weak_arg = '-DUNITY_WEAK_ATTRIBUTE=__declspec(selectany)'
endif

unity = static_library('unity', 'unity/src/unity.c', c_args: weak_arg)
unity_incdir = include_directories('unity/src')
unity_dep = declare_dependency(compile_args: weak_arg, link_with: unity, include_directories: unity_incdir)
us = cc.get_argument_syntax() == 'msvc' ? ['unity_setup.c'] : []

foreach t : unity_tests
    e = executable(
        t,
        '@0@.c'.format(t),
        us,
        dependencies: [
            libcjson_dep,
            unity_dep,
        ],
    )

    test(t, e, workdir: meson.current_source_dir())
endforeach

cjson_utils_tests = [
  'json_patch',
  'old_utils',
  'misc_utils',
]

foreach t : cjson_utils_tests
    e = executable(
        t,
        '@0@_tests.c'.format(t),
        us,
        dependencies: [
            libcjson_dep,
            libcjson_utils_dep,
            unity_dep,
        ],
    )

    test(t, e, workdir: meson.current_source_dir())
endforeach
