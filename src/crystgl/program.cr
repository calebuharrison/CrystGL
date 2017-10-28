module CrystGL
  class Program

    enum Parameter : LibGL::Enum
      DeleteStatus                      = LibGL::DELETE_STATUS
      LinkStatus                        = LibGL::LINK_STATUS
      ValidateStatus                    = LibGL::VALIDATE_STATUS
      InfoLogLength                     = LibGL::INFO_LOG_LENGTH
      AttachedShaders                   = LibGL::ATTACHED_SHADERS
      ActiveAtomicCounterBuffers        = LibGL::ACTIVE_ATOMIC_COUNTER_BUFFERS
      ActiveAttributes                  = LibGL::ACTIVE_ATTRIBUTES
      ActiveAttributeMaxLength          = LibGL::ACTIVE_ATTRIBUTE_MAX_LENGTH
      ActiveUniforms                    = LibGL::ACTIVE_UNIFORMS
      ActiveUniformMaxLength            = LibGL::ACTIVE_UNIFORM_MAX_LENGTH
      BinaryLength                      = LibGL::PROGRAM_BINARY_LENGTH
      ComputeWorkGroupSize              = LibGL::COMPUTE_WORK_GROUP_SIZE
      TransformFeedbackBufferMode       = LibGL::TRANSFORM_FEEDBACK_BUFFER_MODE
      TransformFeedbackVaryings         = LibGL::TRANSFORM_FEEDBACK_VARYINGS
      TransformFeedbackVaryingMaxLength = LibGL::TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH
      GeometryVerticesOut               = LibGL::GEOMETRY_VERTICES_OUT
      GeometryInputType                 = LibGL::GEOMETRY_INPUT_TYPE
      GeometryOutputType                = LibGL::GEOMETRY_OUTPUT_TYPE
    end

    @id : LibGL::Enum

    def initialize
      @id = LibGL.create_program
    end

    def self.create(shaders : Enumerable(Shader)) : Program
      program = self.new
      shaders.each { |s| program.attach(s) }
      program.link
      raise program.info_log unless program.linked?
      program
    end

    def attach(shader : Shader)
      LibGL.attach_shader(@id, shader)
    end

    def use(&block)
      LibGL.use_program(self)
      yield self
      LibGL.use_program(0)
    end

    def link
      LibGL.link_program(@id)
    end

    def deleted? : Bool
      LibGL.get_program_iv(@id, Parameter::DeleteStatus, out deleted)
      Boolean.new(deleted).true?
    end

    def linked? : Bool
      LibGL.get_program_iv(@id, Parameter::LinkStatus, out linked)
      Boolean.new(linked).true?
    end

    def validated? : Bool
      LibGL.get_program_iv(@id, Parameter::ValidateStatus, out validated)
      Boolean.new(validated).true?
    end

    def info_log_length : Int32
      LibGL.get_program_iv(@id, Parameter::InfoLogLength, out length)
      length
    end

    def info_log : String
      length = info_log_length
      log = Array(UInt8).new(length, 0_u8).to_unsafe
      LibGL.get_program_info_log(@id, info_log_length, nil, log)
      String.new(log)
    end

    def attached_shaders : Int32
      LibGL.get_program_iv(@id, Parameter::AttachedShaders, out num)
      num
    end

    def active_atomic_counter_buffers : Int32
      LibGL.get_program_iv(@id, Parameter::ActiveAtomicCounterBuffers, out num)
      num
    end

    def active_attributes : Int32
      LibGL.get_program_iv(@id, Parameter::ActiveAttributes, out num)
      num
    end

    def active_uniform_max_length : Int32
      LibGL.get_program_iv(@id, Parameter::ActiveUniformMaxLength, out length)
      length
    end

    def binary_length : Int32
      LibGL.get_program_iv(@id, Parameter::BinaryLength, out length)
      length
    end

    def compute_work_group_size : Tuple(Int32)
      LibGL.get_program_iv(@id, Parameter::ComputeWorkGroupSize, out ary)
      ary
    end

    def transform_feedback_buffer_mode : Int32
      LibGL.get_program_iv(@id, Parameter::TransformFeedbackBufferMode, out mode)
      mode
    end

    def transform_feedback_varyings : Int32
      LibGL.get_program_iv(@id, Parameter::TransformFeedbackVaryings, out num)
      num
    end

    def transform_feedback_varying_max_length : Int32
      LibGL.get_program_iv(@id, Parameter::TransformFeedbackVaryingMaxLength, out length)
      length
    end

    def geometry_vertices_out : Int32
      LibGL.get_program_iv(@id, Parameter::GeometryVerticesOut, out num)
      num
    end

    def geometry_input_type : Int32
      LibGL.get_program_iv(@id, Parameter::GeometryInputType, out input_type)
      input_type
    end

    def geometry_output_type : Int32
      LibGL.get_program_iv(@id, Parameter::GeometryOutputType, out output_type)
      output_type
    end

    private def uniform_location(name : String) : LibGL::Int
      LibGL.get_uniform_location(self, name)
    end

    def set_uniform(name : String, b0 : Bool)
      LibGL.uniform_1i(uniform_location(name), Boolean.from(b0))
    end

    def set_uniform(name : String, b0 : Bool, b1 : Bool)
      LibGL.uniform_2i(uniform_location(name), Boolean.from(b0), Boolean.from(b1))
    end

    def set_uniform(name : String, b0 : Bool, b1 : Bool, b2 : Bool)
      LibGL.uniform_3i(uniform_location(name), Boolean.from(b0), Boolean.from(b1), Boolean.from(b2))
    end

    def set_uniform(name : String, b0 : Bool, b1 : Bool, b2 : Bool, b3 : Bool)
      LibGL.uniform_4i(uniform_location(name), Boolean.from(b0), Boolean.from(b1), Boolean.from(b2), Boolean.from(b3))
    end

    def set_uniform(name : String, count : Int32, data : Enumerable(Bool))
      bools = data.map {|d| Boolean.from(d)}
      ptr = Pointer(Void).new(bools.object_id)
      case bools.size
      when 1
        LibGL.uniform_1iv(uniform_location(name), count, ptr)
      when 2
        LibGL.uniform_2iv(uniform_location(name), count, ptr)
      when 3
        LibGL.uniform_3iv(uniform_location(name), count, ptr)
      when 4
        LibGL.uniform_4iv(uniform_location(name), count, ptr)
      else
        raise "Invalid uniform vector length"
      end
    end

    def set_uniform(name : String, i0 : Int32)
      LibGL.uniform_1i(uniform_location(name), i0)
    end

    def set_uniform(name : String, i0 : Int32, i1 : Int32)
      LibGL.uniform_2i(uniform_location(name), i0, i1)
    end

    def set_uniform(name : String, i0 : Int32, i1 : Int32, i2 : Int32)
      LibGL.uniform_3i(uniform_location(name), i0, i1, i2)
    end

    def set_uniform(name : String, i0 : Int32, i1 : Int32, i2 : Int32, i3 : Int32)
      LibGL.uniform_4i(uniform_location(name), i0, i1, i2, i3)
    end

    def set_uniform(name : String, count : Int32, data : Enumerable(Int32))
      ptr = Pointer(Void).new(data.object_id)
      case data.size
      when 1
        LibGL.uniform_1iv(uniform_location(name), count, ptr)
      when 2
        LibGL.uniform_2iv(uniform_location(name), count, ptr)
      when 3
        LibGL.uniform_3iv(uniform_location(name), count, ptr)
      when 4
        LibGL.uniform_4iv(uniform_location(name), count, ptr)
      else
        raise "Invalid uniform vector length"
      end
    end

    def set_uniform(name : String, ui0 : UInt32)
      LibGL.uniform_1ui(uniform_location(name), ui0)
    end

    def set_uniform(name : String, ui0 : UInt32, ui1 : UInt32)
      LibGL.uniform_2ui(uniform_location(name), ui0, ui1)
    end

    def set_uniform(name : String, ui0 : UInt32, ui1 : UInt32, ui2 : UInt32)
      LibGL.uniform_3ui(uniform_location(name), ui0, ui1, ui2)
    end

    def set_uniform(name : String, ui0 : UInt32, ui1 : UInt32, ui2 : UInt32, ui3 : UInt32)
      LibGL.uniform_4ui(uniform_location(name), ui0, ui1, ui2, ui3)
    end

    def set_uniform(name : String, count : Int32, data : Enumerable(UInt32))
      ptr = Pointer(Void).new(data.object_id)
      case data.size
      when 1
        LibGL.uniform_1uiv(uniform_location(name), count, ptr)
      when 2
        LibGL.uniform_2uiv(uniform_location(name), count, ptr)
      when 3
        LibGL.uniform_3uiv(uniform_location(name), count, ptr)
      when 4
        LibGL.uniform_4uiv(uniform_location(name), count, ptr)
      else
        raise "Invalid uniform vector length"
      end
    end

    def set_uniform(name : String, f0 : Float32)
      LibGL.uniform_1f(uniform_location(name), f0)
    end

    def set_uniform(name : String, f0 : Float32, f1 : Float32)
      LibGL.uniform_2f(uniform_location(name), f0, f1)
    end

    def set_uniform(name : String, f0 : Float32, f1 : Float32, f2 : Float32)
      LibGL.uniform_3f(uniform_location(name), f0, f1, f2)
    end

    def set_uniform(name : String, f0 : Float32, f1 : Float32, f2 : Float32, f3 : Float32)
      LibGL.uniform_4f(uniform_location(name), f0, f1, f2, f3)
    end

    def set_uniform(name : String, count : Int32, data : Enumerable(Float32))
      ptr = Pointer(Void).new(data.object_id)
      case data.size
      when 1
        LibGL.uniform_1fv(uniform_location(name), count, ptr)
      when 2
        LibGL.uniform_2fv(uniform_location(name), count, ptr)
      when 3
        LibGL.uniform_3fv(uniform_location(name), count, ptr)
      when 4
        LibGL.uniform_4fv(uniform_location(name), count, ptr)
      else
        raise "Invalid uniform vector length"
      end
    end

    def set_uniform(name : String, count : Int32, transpose : Bool, data : Enumerable)
      LibGL.uniform_matrix_4fv(uniform_location(name), count, Boolean.from(transpose), data)
    end

    def to_unsafe
      @id
    end
  end
end