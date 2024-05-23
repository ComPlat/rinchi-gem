# frozen_string_literal: true

require "mkmf"

RINCHI_DIR_NAME = "RInChI"
RINCHI_GIT = ENV.fetch("RINCHI_GIT", "https://github.com/IUPAC-InChI/RInChI.git")
RINCHI_GIT_TAG = ENV.fetch("RINCHI_GIT_TAG", "main")
RINCHI_GIT_REVISION = ENV.fetch("RINCHI_GIT_REVISION", "0e14efe8")

FileUtils.rm_rf(RINCHI_DIR_NAME)
args = [RINCHI_GIT, RINCHI_DIR_NAME]
if RINCHI_GIT_TAG.to_s.strip != ""
  args << "--branch"
  args << RINCHI_GIT_TAG
end
system("git", "clone", *args) or abort

system("cd #{RINCHI_DIR_NAME} && git checkout #{RINCHI_GIT_REVISION}") or abort if RINCHI_GIT_REVISION.to_s.strip != ""

inc_dirs = "-I. -I./RInChI/src/lib -I./RInChI/src/parsers -I./RInChI/src/rinchi -I./RInChI/src/writers -I./RInChI/INCHI-1-API/INCHI_API/inchi_dll"

system("swig #{inc_dirs} -c++ -ruby rinchi.i") or abort

$INCFLAGS << inc_dirs

$srcs = [
  "rinchi.cpp",
  "rinchi_wrap.cxx",
  "./RInChI/src/lib/rinchi_utils.cpp",
  "./RInChI/src/lib/rinchi_logger.cpp",
  "./RInChI/src/lib/inchi_api_intf.cpp",
  "./RInChI/src/lib/inchi_generator.cpp",
  "./RInChI/src/lib/rinchi_hashing.cpp",
  "./RInChI/src/parsers/mdl_molfile.cpp",
  "./RInChI/src/parsers/mdl_molfile_reader.cpp",
  "./RInChI/src/parsers/mdl_rxnfile_reader.cpp",
  "./RInChI/src/parsers/mdl_rdfile_reader.cpp",
  "./RInChI/src/parsers/rinchi_reader.cpp",
  "./RInChI/src/writers/mdl_rxnfile_writer.cpp",
  "./RInChI/src/writers/mdl_rdfile_writer.cpp",
  "./RInChI/src/rinchi/rinchi_reaction.cpp",
  "./RInChI/src/rinchi/rinchi_consts.cpp",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichi_bns.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichi_io.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichican2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichicano.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichicans.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiisot.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichilnct.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimak2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimake.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap1.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap4.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichinorm.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiparm.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt1.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt3.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiqueu.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiread.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiring.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr1.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr3.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr4.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr5.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr6.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr7.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichisort.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichister.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichitaut.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ikey_base26.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ikey_dll.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_a.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_a2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_main.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/runichi.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/sha2.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/strutil.c",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/util.c"
]

$objs = [
  "rinchi.o",
  "rinchi_wrap.o",
  "./RInChI/src/lib/rinchi_utils.o",
  "./RInChI/src/lib/rinchi_logger.o",
  "./RInChI/src/lib/inchi_api_intf.o",
  "./RInChI/src/lib/inchi_generator.o",
  "./RInChI/src/lib/rinchi_hashing.o",
  "./RInChI/src/parsers/mdl_molfile.o",
  "./RInChI/src/parsers/mdl_molfile_reader.o",
  "./RInChI/src/parsers/mdl_rxnfile_reader.o",
  "./RInChI/src/parsers/mdl_rdfile_reader.o",
  "./RInChI/src/parsers/rinchi_reader.o",
  "./RInChI/src/writers/mdl_rxnfile_writer.o",
  "./RInChI/src/writers/mdl_rdfile_writer.o",
  "./RInChI/src/rinchi/rinchi_reaction.o",
  "./RInChI/src/rinchi/rinchi_consts.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichi_bns.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichi_io.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichican2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichicano.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichicans.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiisot.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichilnct.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimak2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimake.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap1.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichimap4.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichinorm.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiparm.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt1.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiprt3.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiqueu.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiread.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichiring.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr1.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr3.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr4.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr5.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr6.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichirvr7.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichisort.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichister.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ichitaut.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ikey_base26.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/ikey_dll.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_a.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_a2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/inchi_dll_main.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/runichi.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/sha2.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/strutil.o",
  "./RInChI/INCHI-1-API/INCHI_API/inchi_dll/util.o"
]

create_makefile("rinchi")
