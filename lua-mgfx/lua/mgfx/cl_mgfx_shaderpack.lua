MGFXShaderPack = MGFXShaderPack or {}
MGFXShaderPack.Version = '1784020223'

local base_path = "mgfx/"
local chunk_files = {
    "cl_mgfx_shaderpack_chunk_01.lua",
    "cl_mgfx_shaderpack_chunk_02.lua",
    "cl_mgfx_shaderpack_chunk_03.lua",
    "cl_mgfx_shaderpack_chunk_04.lua",
    "cl_mgfx_shaderpack_chunk_05.lua",
}
local chunks = {}

for i = 1, #chunk_files do
    local chunk = include(base_path .. chunk_files[i])
    if not isstring(chunk) or chunk == "" then
        error("MGFX shaderpack chunk did not load: " .. chunk_files[i])
    end
    chunks[i] = chunk
end

MGFXShaderPack.GMA = table.concat(chunks)
