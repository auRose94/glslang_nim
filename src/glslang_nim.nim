#[
  Author: Golden Rose <GoldRose94@outlook.com>
  Name: glslang.nim
  Info: Retrieves, modifies, translates, and links GLSLang.
]#
import nimterop/[build, cimport]
import os, distros, regex, strutils

const baseDir = getProjectCacheDir("glslang", false)
const newPath = baseDir/"glslang"/"Public"/"ShaderLang.hpp"
const oldPath = baseDir/"glslang"/"Public"/"ShaderLang.h"
const outpath = currentSourcePath.parentDir()/"glslang.nim"

when fileExists(outpath):
  # If the file was generated before, just import it...
  include glslang
else:
  static:
    #cDebug() # Print wrapper to stdout
    cSkipSymbol @["EshTargetSpv", "EshTargetClientVersion"]

  setDefines(@["ShaderLangGit", "ShaderLangStd", "ShaderLangStatic"])
  proc ShaderLangPreBuild(outdir, path: string) =
    var data: string = readFile(oldPath)

    var match: RegexMatch
    if data.find(re"//(\s+)?Deferred-Lowering C\+\+ Interface", match, 0):
      let cppStart = match.boundaries.a
      data = data.substr(0, cppStart-1)

    data = data.replace(re"//(.*)", "")
    data = data.replace(re"(\n){2,}", "\n\n")
    data &= "#endif //_COMPILER_INTERFACE_INCLUDED_"
    data = data.strip()
    let oldData = readFile(newPath)
    if oldData.cmpIgnoreCase(data) != 0:
      echo "Different!"
      writeFile(newPath, data)

  cOverride:
    type 
      EProfile* = enum 
        EBadProfile           = 0
        ENoProfile            = (1 shl 0)
        ECoreProfile          = (1 shl 1)
        ECompatibilityProfile = (1 shl 2)
        EProfileCount = 5
        EEsProfile            = (1 shl 3)

  getHeader(
      # The header file to wrap, full path is returned in `headerPath`
      header = "ShaderLang.hpp",                        
      # Git repo URL
      giturl = "https://github.com/KhronosGroup/glslang",
      # Where to download/build/search
      outdir = baseDir,
      cmakeFlags = 
        "-DCMAKE_BUILD_TYPE=Release -DENABLE_CTEST=OFF",                                     
      # Alterate names of the library binary, full path returned in `headerLPath`
      altNames = "glslang"
  )

  cIncludeDir(baseDir)
  cIncludeDir(baseDir/"SPIRV")
  cIncludeDir(baseDir/"StandAlone")
  cIncludeDir(baseDir/"glslang"/"Public")
  cIncludeDir(baseDir/"OGLCompilersDLL")
  const lPath = ShaderLangLPath.parentDir()
  cIncludeDir(lPath.parentDir()/"include")
  echo "ShaderLangPath", ShaderLangPath

  cPassL(lPath/"libGenericCodeGen.a")
  cPassL(lPath/../"OGLCompilersDLL"/"libOGLCompiler.a")
  cPassL(lPath/../"SPIRV"/"libSPIRV.a")

  cCompile(baseDir/"glslang/CInterface/*.cpp", "cpp")
  cCompile(baseDir/"glslang/GenericCodeGen/*.cpp", "cpp")
  cCompile(baseDir/"glslang/MachineIndependent/*.cpp", "cpp")
  cCompile(baseDir/"OGLCompilersDLL/*.cpp", "cpp")

  when detectOs(Windows):
    cCompile(
      baseDir/"glslang/OSDependent/Windows/*.cpp", "cpp")
      
  when detectOs(Linux) or detectOs(MacOSX) or detectOs(Posix):
    cCompile(
      baseDir/"glslang/OSDependent/Unix/*.cpp", "cpp")

  cImport(
    ShaderLangPath, 
    recurse = true, 
    mode="cpp", 
    nimFile=outpath)
