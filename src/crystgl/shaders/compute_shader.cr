require "./shader"
module CrystGL
  class ComputeShader < Shader
    @@stage = Shader::Stage::Compute
  end
end