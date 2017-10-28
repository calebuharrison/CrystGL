require "lib_gl"

module CrystGL
  class Buffer

    @[Flags]
    enum Bit : LibGL::Enum
      Color   = LibGL::COLOR_BUFFER_BIT
      Depth   = LibGL::DEPTH_BUFFER_BIT
      Stencil = LibGL::STENCIL_BUFFER_BIT
    end

    enum UsageHint : LibGL::Enum
      StreamDraw  = LibGL::STREAM_DRAW
      StreamRead  = LibGL::STREAM_READ
      StreamCopy  = LibGL::STREAM_COPY
      StaticDraw  = LibGL::STATIC_DRAW
      StaticRead  = LibGL::STATIC_READ
      StaticCopy  = LibGL::STATIC_COPY
      DynamicDraw = LibGL::DYNAMIC_DRAW
      DynamicRead = LibGL::DYNAMIC_READ
      DynamicCopy = LibGL::DYNAMIC_COPY
    end

    enum Target : LibGL::Enum
      Array             = LibGL::ARRAY_BUFFER
      AtomicCounter     = LibGL::ATOMIC_COUNTER_BUFFER
      CopyRead          = LibGL::COPY_READ_BUFFER
      CopyWrite         = LibGL::COPY_WRITE_BUFFER
      DrawIndirect      = LibGL::DRAW_INDIRECT_BUFFER
      DispatchIndirect  = LibGL::DISPATCH_INDIRECT_BUFFER
      ElementArray      = LibGL::ELEMENT_ARRAY_BUFFER
      PixelPack         = LibGL::PIXEL_PACK_BUFFER
      PixelUnpack       = LibGL::PIXEL_UNPACK_BUFFER
      Query             = LibGL::QUERY_BUFFER
      ShaderStorage     = LibGL::SHADER_STORAGE_BUFFER
      Texture           = LibGL::TEXTURE_BUFFER
      TransformFeedback = LibGL::TRANSFORM_FEEDBACK_BUFFER
      Uniform           = LibGL::UNIFORM_BUFFER

      def buffer_data(d : Enumerable, usage_hint : UsageHint)
        size = d.reduce(0) {|memo, i| memo + sizeof(typeof(i))}
        LibGL.buffer_data(self, size, pointerof(d), usage_hint)
      end
    end

    @id : LibGL::Enum
    @bound : Bool
    @target : Target = Target.new(0_u32)

    def self.generate(n : Int32) : Array(Buffer)
      LibGL.gen_buffers(n, out ids)
      Slice(LibGL::Enum).new(pointerof(ids), n).map {|id| Buffer.new(id)}
    end

    def initialize
      LibGL.gen_buffers(1, out id)
      @id = id
      @bound = false
    end

    protected def initialize(id : LibGL::Enum)
      @id = id
      @bound = false
    end

    def bind(target : Target, &block)
      self.bind(target)
      yield self, target
      self.unbind
    end

    def bind(target : Target)
      @target = target
      LibGL.bind_buffer(@target, self)
      @bound = true
    end

    def unbind
      LibGL.bind_buffer(@target, 0)
      @bound = false
      @target = Target.new(0_u32)
    end

    def delete
      LibGL.delete_buffers(1, pointerof(@id))
    end

    def target
      @target
    end

    def to_unsafe
      @id
    end
  end
end