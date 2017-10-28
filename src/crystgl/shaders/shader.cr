module CrystGL
  abstract class Shader

    enum Stage : LibGL::Enum
      Compute         = LibGL::COMPUTE_SHADER
      Fragment        = LibGL::FRAGMENT_SHADER
      Geometry        = LibGL::GEOMETRY_SHADER
      TessControl     = LibGL::TESS_CONTROL_SHADER
      TessEvaluation  = LibGL::TESS_EVALUATION_SHADER
      Vertex          = LibGL::VERTEX_SHADER
    end

    enum Parameter : LibGL::Enum
      Stage = LibGL::SHADER_TYPE
      CompileStatus = LibGL::COMPILE_STATUS
      DeleteStatus = LibGL::DELETE_STATUS
      InfoLogLength = LibGL::INFO_LOG_LENGTH
      SourceLength = LibGL::SHADER_SOURCE_LENGTH
    end

    @id : LibGL::Enum
    @@stage : Stage = Stage.new(0_u32)

    def self.create(source : String) : Shader
      self.new(source).tap { |s| s.compile }
    end

    def initialize(source : String)
      @id = LibGL.create_shader(@@stage)
      ptr = source.to_unsafe
      LibGL.shader_source(@id, 1, pointerof(ptr), nil)
    end

    def compile
      LibGL.compile_shader(@id)
      raise info_log unless compiled?
    end

    def shader_type : ShaderStage
      LibGL.get_shader_iv(@id, Parameter::Stage, out shader_stage)
      ShaderStage.new(shader_stage)
    end

    def compiled? : Bool
      LibGL.get_shader_iv(@id, Parameter::CompileStatus, out status) 
      Boolean.new(status).true?
    end

    def deleted? : Bool
      LibGL.get_shader_iv(@id, Parameter::DeleteStatus, out status)
      Boolean.new(status).true?
    end

    private def info_log_length : Int32
      LibGL.get_shader_iv(@id, Parameter::InfoLogLength, out length)
      length
    end

    def info_log : String
      length = info_log_length
      log = Array(UInt8).new(length, 0_u8).to_unsafe
      LibGL.get_shader_info_log(@id, length, nil, log)
      String.new(log)
    end

    private def source_length : Int32
      LibGL.get_shader_iv(@id, Parameter::SourceLength, out length)
      length
    end

    def source : String
      length = source_length
      s = Array(UInt8).new(length, 0_u8).to_unsafe
      LibGL.get_shader_source(@id, length, nil, s)
      String.new(s)
    end

    def delete
      LibGL.delete_shader(@id)
    end

    def to_unsafe
      @id
    end
  end
end