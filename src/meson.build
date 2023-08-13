source_files = files(
    'main.c', 'data.c', 'seg000.c', 'seg001.c', 'seg002.c', 'seg003.c', 'seg004.c',
    'seg005.c', 'seg006.c', 'seg007.c', 'seg008.c', 'seg009.c', 'seqtbl.c', 'replay.c',
    'options.c', 'lighting.c', 'screenshot.c', 'menu.c', 'midi.c', 'opl3.c', 'stb_vorbis.c'
)

executable('prince', source_files,
           dependencies : [sdl2_dep, sdl2_image_dep, m_dep, dl_dep, threads_dep],
           link_args : sdlpop_link_args,
           install : true)

