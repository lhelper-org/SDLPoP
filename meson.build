project('SDLPoP', 'c', version : '1.23', default_options : ['c_std=gnu99'])

cc = meson.get_compiler('c')

sdl2_dep = dependency('sdl2', method: 'config-tool')
sdl2_image_dep = dependency('SDL2_image')
threads_dep = dependency('threads')
m_dep = cc.find_library('m', required: false)
dl_dep = cc.find_library('dl', required: false)

sdlpop_link_args = []
if cc.get_id() == 'gcc' and get_option('buildtype') == 'release'
    sdlpop_link_args += '-static-libgcc'
endif

subdir('src')

install_subdir('data', install_dir : get_option('prefix'))