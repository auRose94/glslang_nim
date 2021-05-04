# GLSLang_nim [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=96STXBG8HMW2E)

## GLSLang [Nimterop](https://github.com/nimterop/nimterop) wrapper & library

This project was created to help with Vulkan and OpenGL. I needed something to compile my GLSL code.
It's technically capable of printing HLSL, but it can print SPIRV and even present a program handle.

It's using only the C interface and has no C++ utilities available.

Later versions might include helper functions but this just includes the imports for now.

This project will download [GLSLang](https://github.com/KhronosGroup/glslang), build it, and wrap it for you.

Works on Windows and Linux (tested with WSL).

### Functions

```nim
proc ProfileName*(profile: EProfile): cstring
proc ShInitialize*(): cint
proc ShFinalize*(): cint
proc StageName*(a1: EShLanguage): cstring
proc ShConstructCompiler*(a1: EShLanguage; debugOptions: cint): ShHandle
proc ShConstructLinker*(a1: EShExecutable; debugOptions: cint): ShHandle
proc ShConstructUniformMap*(): ShHandle
proc ShDestruct*(a1: ShHandle)
proc ShCompile*(a1: ShHandle; shaderStrings: cchar; numStrings: cint;
                lengths: ptr cint; a5: EShOptimizationLevel;
                resources: ptr TBuiltInResource; debugOptions: cint): cint
proc ShLinkExt*(a1: ShHandle; h: UncheckedArray[ShHandle]; numHandles: cint): cint
proc ShSetEncryptionMethod*(a1: ShHandle)
proc ShGetInfoLog*(a1: ShHandle): cstring
proc ShGetExecutable*(a1: ShHandle): pointer
proc ShSetVirtualAttributeBindings*(a1: ShHandle; a2: ptr ShBindingTable): cint
proc ShSetFixedAttributeBindings*(a1: ShHandle; a2: ptr ShBindingTable): cint
proc ShExcludeAttributes*(a1: ShHandle; attributes: ptr cint; count: cint): cint
proc ShGetUniformLocation*(uniformMap: ShHandle; name: cstring): cint
```

### Types

```nim
type
  EProfile* = enum
    EBadProfile = 0,
    ENoProfile = (1 shl 0),
    ECoreProfile = (1 shl 1),
    ECompatibilityProfile = (1 shl 2),
    EProfileCount = 5,
    EEsProfile = (1 shl 3)

  TLimits* = object
    nonInductiveForLoops*: bool
    whileLoops*: bool
    doWhileLoops*: bool
    generalUniformIndexing*: bool
    generalAttributeMatrixVectorIndexing*: bool
    generalVaryingIndexing*: bool
    generalSamplerIndexing*: bool
    generalVariableIndexing*: bool
    generalConstantMatrixVectorIndexing*: bool

  TBuiltInResource* = object
    maxLights*: cint
    maxClipPlanes*: cint
    maxTextureUnits*: cint
    maxTextureCoords*: cint
    maxVertexAttribs*: cint
    maxVertexUniformComponents*: cint
    maxVaryingFloats*: cint
    maxVertexTextureImageUnits*: cint
    maxCombinedTextureImageUnits*: cint
    maxTextureImageUnits*: cint
    maxFragmentUniformComponents*: cint
    maxDrawBuffers*: cint
    maxVertexUniformVectors*: cint
    maxVaryingVectors*: cint
    maxFragmentUniformVectors*: cint
    maxVertexOutputVectors*: cint
    maxFragmentInputVectors*: cint
    minProgramTexelOffset*: cint
    maxProgramTexelOffset*: cint
    maxClipDistances*: cint
    maxComputeWorkGroupCountX*: cint
    maxComputeWorkGroupCountY*: cint
    maxComputeWorkGroupCountZ*: cint
    maxComputeWorkGroupSizeX*: cint
    maxComputeWorkGroupSizeY*: cint
    maxComputeWorkGroupSizeZ*: cint
    maxComputeUniformComponents*: cint
    maxComputeTextureImageUnits*: cint
    maxComputeImageUniforms*: cint
    maxComputeAtomicCounters*: cint
    maxComputeAtomicCounterBuffers*: cint
    maxVaryingComponents*: cint
    maxVertexOutputComponents*: cint
    maxGeometryInputComponents*: cint
    maxGeometryOutputComponents*: cint
    maxFragmentInputComponents*: cint
    maxImageUnits*: cint
    maxCombinedImageUnitsAndFragmentOutputs*: cint
    maxCombinedShaderOutputResources*: cint
    maxImageSamples*: cint
    maxVertexImageUniforms*: cint
    maxTessControlImageUniforms*: cint
    maxTessEvaluationImageUniforms*: cint
    maxGeometryImageUniforms*: cint
    maxFragmentImageUniforms*: cint
    maxCombinedImageUniforms*: cint
    maxGeometryTextureImageUnits*: cint
    maxGeometryOutputVertices*: cint
    maxGeometryTotalOutputComponents*: cint
    maxGeometryUniformComponents*: cint
    maxGeometryVaryingComponents*: cint
    maxTessControlInputComponents*: cint
    maxTessControlOutputComponents*: cint
    maxTessControlTextureImageUnits*: cint
    maxTessControlUniformComponents*: cint
    maxTessControlTotalOutputComponents*: cint
    maxTessEvaluationInputComponents*: cint
    maxTessEvaluationOutputComponents*: cint
    maxTessEvaluationTextureImageUnits*: cint
    maxTessEvaluationUniformComponents*: cint
    maxTessPatchComponents*: cint
    maxPatchVertices*: cint
    maxTessGenLevel*: cint
    maxViewports*: cint
    maxVertexAtomicCounters*: cint
    maxTessControlAtomicCounters*: cint
    maxTessEvaluationAtomicCounters*: cint
    maxGeometryAtomicCounters*: cint
    maxFragmentAtomicCounters*: cint
    maxCombinedAtomicCounters*: cint
    maxAtomicCounterBindings*: cint
    maxVertexAtomicCounterBuffers*: cint
    maxTessControlAtomicCounterBuffers*: cint
    maxTessEvaluationAtomicCounterBuffers*: cint
    maxGeometryAtomicCounterBuffers*: cint
    maxFragmentAtomicCounterBuffers*: cint
    maxCombinedAtomicCounterBuffers*: cint
    maxAtomicCounterBufferSize*: cint
    maxTransformFeedbackBuffers*: cint
    maxTransformFeedbackInterleavedComponents*: cint
    maxCullDistances*: cint
    maxCombinedClipAndCullDistances*: cint
    maxSamples*: cint
    maxMeshOutputVerticesNV*: cint
    maxMeshOutputPrimitivesNV*: cint
    maxMeshWorkGroupSizeX_NV*: cint
    maxMeshWorkGroupSizeY_NV*: cint
    maxMeshWorkGroupSizeZ_NV*: cint
    maxTaskWorkGroupSizeX_NV*: cint
    maxTaskWorkGroupSizeY_NV*: cint
    maxTaskWorkGroupSizeZ_NV*: cint
    maxMeshViewCountNV*: cint
    maxDualSourceDrawBuffersEXT*: cint
    limits*: TLimits

  SpvVersion* = object
    spv*: cuint
    vulkanGlsl*: cint
    vulkan*: cint
    openGl*: cint
    vulkanRelaxed*: bool

  TInputLanguage* = object
    languageFamily*: EShSource
    stage*: EShLanguage
    dialect*: EShClient
    dialectVersion*: cint
    vulkanRulesRelaxed*: bool

  TClient* = object
    client*: EShClient
    version*: EShTargetClientVersion

  TTarget* = object
    language*: EShTargetLanguage
    version*: EShTargetLanguageVersion
    hlslFunctionality1*: bool

  TEnvironment* = object
    input*: TInputLanguage
    client*: TClient
    target*: TTarget

  ShBinding* = object
    name*: cstring
    binding*: cint

  ShBindingTable* = object
    numBindings*: cint
    bindings*: ptr ShBinding

  ShHandle* = pointer

  defineEnum(TExtensionBehavior)
  defineEnum(EShLanguage)
  defineEnum(EShSource)
  defineEnum(EShClient)
  defineEnum(EShTargetLanguage)
  defineEnum(EShTargetClientVersion)
  defineEnum(EShTargetLanguageVersion)
  defineEnum(EShExecutable)
  defineEnum(EShOptimizationLevel)
  defineEnum(EShTextureSamplerTransformMode)
  defineEnum(EShMessages)
  defineEnum(EShReflectionOptions)
  const
    EBhMissing* = (0).TExtensionBehavior
    EBhRequire* = (EBhMissing + 1).TExtensionBehavior
    EBhEnable* = (EBhRequire + 1).TExtensionBehavior
    EBhWarn* = (EBhEnable + 1).TExtensionBehavior
    EBhDisable* = (EBhWarn + 1).TExtensionBehavior
    EBhDisablePartial* = (EBhDisable + 1).TExtensionBehavior
    EShLangVertex* = (0).EShLanguage
    EShLangTessControl* = (EShLangVertex + 1).EShLanguage
    EShLangTessEvaluation* = (EShLangTessControl + 1).EShLanguage
    EShLangGeometry* = (EShLangTessEvaluation + 1).EShLanguage
    EShLangFragment* = (EShLangGeometry + 1).EShLanguage
    EShLangCompute* = (EShLangFragment + 1).EShLanguage
    EShLangRayGen* = (EShLangCompute + 1).EShLanguage
    EShLangRayGenNV* = (EShLangRayGen).EShLanguage
    EShLangIntersect* = (EShLangRayGenNV + 1).EShLanguage
    EShLangIntersectNV* = (EShLangIntersect).EShLanguage
    EShLangAnyHit* = (EShLangIntersectNV + 1).EShLanguage
    EShLangAnyHitNV* = (EShLangAnyHit).EShLanguage
    EShLangClosestHit* = (EShLangAnyHitNV + 1).EShLanguage
    EShLangClosestHitNV* = (EShLangClosestHit).EShLanguage
    EShLangMiss* = (EShLangClosestHitNV + 1).EShLanguage
    EShLangMissNV* = (EShLangMiss).EShLanguage
    EShLangCallable* = (EShLangMissNV + 1).EShLanguage
    EShLangCallableNV* = (EShLangCallable).EShLanguage
    EShLangTaskNV* = (EShLangCallableNV + 1).EShLanguage
    EShLangMeshNV* = (EShLangTaskNV + 1).EShLanguage
    EShLangCount* = (EShLangMeshNV + 1).EShLanguage
    EShSourceNone* = (0).EShSource
    EShSourceGlsl* = (EShSourceNone + 1).EShSource
    EShSourceHlsl* = (EShSourceGlsl + 1).EShSource
    EShSourceCount* = (EShSourceHlsl + 1).EShSource
    EShClientNone* = (0).EShClient
    EShClientVulkan* = (EShClientNone + 1).EShClient
    EShClientOpenGL* = (EShClientVulkan + 1).EShClient
    EShClientCount* = (EShClientOpenGL + 1).EShClient
    EShTargetNone* = (0).EShTargetLanguage
    EShTargetSpv* = (EShTargetNone + 1).EShTargetLanguage
    EShTargetCount* = (EShTargetSpv + 1).EShTargetLanguage
    EShTargetVulkan_1_0* = ((1 shl typeof(1)(22))).EShTargetClientVersion
    EShTargetVulkan_1_1* = ((1 shl typeof(1)(22)) or
        typeof(1)((1 shl typeof(1)(12)))).EShTargetClientVersion
    EShTargetVulkan_1_2* = ((1 shl typeof(1)(22)) or
        typeof(1)((2 shl typeof(2)(12)))).EShTargetClientVersion
    EShTargetOpenGL_450* = (450).EShTargetClientVersion
    EShTargetClientVersionCount* = (4).EShTargetClientVersion
    EShTargetSpv_1_0* = ((1 shl typeof(1)(16))).EShTargetLanguageVersion
    EShTargetSpv_1_1* = ((1 shl typeof(1)(16)) or typeof(1)((1 shl typeof(1)(8)))).EShTargetLanguageVersion
    EShTargetSpv_1_2* = ((1 shl typeof(1)(16)) or typeof(1)((2 shl typeof(2)(8)))).EShTargetLanguageVersion
    EShTargetSpv_1_3* = ((1 shl typeof(1)(16)) or typeof(1)((3 shl typeof(3)(8)))).EShTargetLanguageVersion
    EShTargetSpv_1_4* = ((1 shl typeof(1)(16)) or typeof(1)((4 shl typeof(4)(8)))).EShTargetLanguageVersion
    EShTargetSpv_1_5* = ((1 shl typeof(1)(16)) or typeof(1)((5 shl typeof(5)(8)))).EShTargetLanguageVersion
    EShTargetLanguageVersionCount* = (6).EShTargetLanguageVersion
    EShExVertexFragment* = (0).EShExecutable
    EShExFragment* = (EShExVertexFragment + 1).EShExecutable
    EShOptNoGeneration* = (0).EShOptimizationLevel
    EShOptNone* = (EShOptNoGeneration + 1).EShOptimizationLevel
    EShOptSimple* = (EShOptNone + 1).EShOptimizationLevel
    EShOptFull* = (EShOptSimple + 1).EShOptimizationLevel
    EshOptLevelCount* = (EShOptFull + 1).EShOptimizationLevel
    EShTexSampTransKeep* = (0).EShTextureSamplerTransformMode
    EShTexSampTransUpgradeTextureRemoveSampler* = (EShTexSampTransKeep + 1).EShTextureSamplerTransformMode
    EShTexSampTransCount* = (EShTexSampTransUpgradeTextureRemoveSampler + 1).EShTextureSamplerTransformMode
    EShMsgDefault* = (0).EShMessages
    EShMsgRelaxedErrors* = ((1 shl typeof(1)(0))).EShMessages
    EShMsgSuppressWarnings* = ((1 shl typeof(1)(1))).EShMessages
    EShMsgAST* = ((1 shl typeof(1)(2))).EShMessages
    EShMsgSpvRules* = ((1 shl typeof(1)(3))).EShMessages
    EShMsgVulkanRules* = ((1 shl typeof(1)(4))).EShMessages
    EShMsgOnlyPreprocessor* = ((1 shl typeof(1)(5))).EShMessages
    EShMsgReadHlsl* = ((1 shl typeof(1)(6))).EShMessages
    EShMsgCascadingErrors* = ((1 shl typeof(1)(7))).EShMessages
    EShMsgKeepUncalled* = ((1 shl typeof(1)(8))).EShMessages
    EShMsgHlslOffsets* = ((1 shl typeof(1)(9))).EShMessages
    EShMsgDebugInfo* = ((1 shl typeof(1)(10))).EShMessages
    EShMsgHlslEnable16BitTypes* = ((1 shl typeof(1)(11))).EShMessages
    EShMsgHlslLegalization* = ((1 shl typeof(1)(12))).EShMessages
    EShMsgHlslDX9Compatible* = ((1 shl typeof(1)(13))).EShMessages
    EShMsgBuiltinSymbolTable* = ((1 shl typeof(1)(14))).EShMessages
    EShMsgCount* = (EShMsgBuiltinSymbolTable + 1).EShMessages
    EShReflectionDefault* = (0).EShReflectionOptions
    EShReflectionStrictArraySuffix* = ((1 shl typeof(1)(0))).EShReflectionOptions
    EShReflectionBasicArraySuffix* = ((1 shl typeof(1)(1))).EShReflectionOptions
    EShReflectionIntermediateIO* = ((1 shl typeof(1)(2))).EShReflectionOptions
    EShReflectionSeparateBuffers* = ((1 shl typeof(1)(3))).EShReflectionOptions
    EShReflectionAllBlockVariables* = ((1 shl typeof(1)(4))).EShReflectionOptions
    EShReflectionUnwrapIOBlocks* = ((1 shl typeof(1)(5))).EShReflectionOptions
    EShReflectionAllIOVariables* = ((1 shl typeof(1)(6))).EShReflectionOptions
    EShReflectionSharedStd140SSBO* = ((1 shl typeof(1)(7))).EShReflectionOptions
    EShReflectionSharedStd140UBO* = ((1 shl typeof(1)(8))).EShReflectionOptions
    EShReflectionCount* = (EShReflectionSharedStd140UBO + 1).EShReflectionOptions
```
