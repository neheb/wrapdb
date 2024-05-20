project(
  'cjson',
  'c',
  version: '1.7.18',
  meson_version: '>=0.49.0',
  license: 'MIT',
)

dllimport_args = []
cc = meson.get_compiler('c')
if cc.get_argument_syntax() == 'msvc'
  add_project_arguments(cc.get_supported_arguments('/D_CRT_SECURE_NO_WARNINGS', '-Wno-deprecated-declarations'), language: 'c')
endif

if get_option('default_library') == 'static'
  add_project_arguments('-DCJSON_HIDE_SYMBOLS', '-UCJSON_API_VISIBILITY', language : 'c')
  dllimport_args = ['-DCJSON_HIDE_SYMBOLS']
else
  add_project_arguments('-DCJSON_EXPORT_SYMBOLS', '-DCJSON_API_VISIBILITY', language : 'c')
  dllimport_args = ['-DCJSON_IMPORT_SYMBOLS']
endif

libm = cc.find_library('m', required: false)

headers = files('cJSON.h', 'cJSON_Utils.h')
install_headers(headers, subdir: 'cjson')

subdir('include-workaround-meson/cjson')
incdir = include_directories('include-workaround-meson')

libcjson = library(
    'cjson',
    'cJSON.c',
    dependencies: libm,
    install: true,
)
libcjson_dep = declare_dependency(
    compile_args: dllimport_args,
    include_directories: incdir,
    link_with: libcjson,
)

libcjson_utils = library(
    'cjson_utils',
    'cJSON_Utils.c',
    dependencies: [libcjson_dep, libm],
    install: true,
)
libcjson_utils_dep = declare_dependency(
    compile_args: dllimport_args,
    include_directories: incdir,
    link_with: libcjson_utils,
)

pkgconfig = import('pkgconfig')
pkgconfig.generate(
    libcjson,
    name: 'libcjson',
    description: 'Ultralightweight JSON parser in ANSI C',
    url: 'https://github.com/DaveGamble/cJSON',
)
pkgconfig.generate(
    libcjson_utils,
    name: 'libcjson_utils',
    description: 'An implementation of JSON Pointer, Patch and Merge Patch based on cJSON.',
    url: 'https://github.com/DaveGamble/cJSON',
    requires: libcjson,
)

if meson.version().version_compare('>=0.54.0')
    meson.override_dependency('libcjson', libcjson_dep)
    meson.override_dependency('libcjson_utils', libcjson_utils_dep)
endif

subdir('tests')
