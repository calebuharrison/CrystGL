module CrystGL
  class Texture

    alias ParameterHash = Hash(ParameterName, ParameterValue | Float32 | Int32 | Enumerable(Float32) | Enumerable(Int32) | Enumerable(UInt32))

    enum Target : LibGL::Enum
      Texture1D                 = LibGL::TEXTURE_1D
      Texture2D                 = LibGL::TEXTURE_2D
      Texture3D                 = LibGL::TEXTURE_3D
      Texture1DArray            = LibGL::TEXTURE_1D_ARRAY
      Texture2DArray            = LibGL::TEXTURE_2D_ARRAY
      TextureRectangle          = LibGL::TEXTURE_RECTANGLE
      TextureCubeMap            = LibGL::TEXTURE_CUBE_MAP
      TextureCubeMapArray       = LibGL::TEXTURE_CUBE_MAP_ARRAY
      TextureBuffer             = LibGL::TEXTURE_BUFFER
      Texture2DMultisample      = LibGL::TEXTURE_2D_MULTISAMPLE
      Texture2DMultisampleArray = LibGL::TEXTURE_2D_MULTISAMPLE_ARRAY
      ProxyTexture2D            = LibGL::PROXY_TEXTURE_2D
      ProxyTexture1DArray       = LibGL::PROXY_TEXTURE_1D_ARRAY
      TextureCubeMapPositiveX   = LibGL::TEXTURE_CUBE_MAP_POSITIVE_X
      TextureCubeMapNegativeX   = LibGL::TEXTURE_CUBE_MAP_NEGATIVE_X
      TextureCubeMapPositiveY   = LibGL::TEXTURE_CUBE_MAP_POSITIVE_Y
      TextureCubeMapNegativeY   = LibGL::TEXTURE_CUBE_MAP_NEGATIVE_Y
      TextureCubeMapPositiveZ   = LibGL::TEXTURE_CUBE_MAP_POSITIVE_Z
      TextureCubeMapNegativeZ   = LibGL::TEXTURE_CUBE_MAP_NEGATIVE_Z
      ProxyTextureCubeMap       = LibGL::PROXY_TEXTURE_CUBE_MAP

      def set_parameters(params : ParameterHash)
        params.each do |key, value|
          if value.is_a?(ParameterValue)
            LibGL.tex_parameter_i(self, key, value.as(ParameterValue))
          elsif value.is_a?(Int32)
            LibGL.tex_parameter_i(self, key, value.as(Int32))
          elsif value.is_a?(Float32)
            LibGL.tex_parameter_f(self, key, value.as(Float32))
          elsif value.is_a?(Enumerable(Float32))
            LibGL.tex_parameter_fv(self, key, Pointer(Void).new(value.object_id))
          elsif value.is_a?(Enumerable(Int32))
            LibGL.tex_parameter_iv(self, key, Pointer(Void).new(value.object_id))
          else
            LibGL.tex_parameter_iuiv(self, key, Pointer(Void).new(value.object_id))
          end
        end
      end

      def generate_mipmap
        LibGL.generate_mipmap(self)
      end

      def image_2d(level_of_detail : Int32, internal_format : CrystGL::InternalFormat, width : Int32, height : Int32, format : Format, data_type : DataType, data : Slice(UInt8))
        LibGL.tex_image_2d(self, level_of_detail, internal_format, width, height, 0, format, data_type, data)
      end
    end

    enum ParameterName : LibGL::Enum
      DepthStencilTextureMode = LibGL::DEPTH_STENCIL_TEXTURE_MODE
      TextureBaseLevel        = LibGL::TEXTURE_BASE_LEVEL
      TextureBorderColor      = LibGL::TEXTURE_BORDER_COLOR
      TextureCompareFunc      = LibGL::TEXTURE_COMPARE_FUNC
      TextureCompareMode      = LibGL::TEXTURE_COMPARE_MODE
      TextureLODBias          = LibGL::TEXTURE_LOD_BIAS
      TextureMinFilter        = LibGL::TEXTURE_MIN_FILTER
      TextureMagFilter        = LibGL::TEXTURE_MAG_FILTER
      TextureMinLOD           = LibGL::TEXTURE_MIN_LOD
      TextureMaxLOD           = LibGL::TEXTURE_MAX_LOD
      TextureMaxLevel         = LibGL::TEXTURE_MAX_LEVEL
      TextureSwizzleR         = LibGL::TEXTURE_SWIZZLE_R
      TextureSwizzleG         = LibGL::TEXTURE_SWIZZLE_G
      TextureSwizzleB         = LibGL::TEXTURE_SWIZZLE_B
      TextureSwizzleA         = LibGL::TEXTURE_SWIZZLE_A
      TextureSwizzleRGBA      = LibGL::TEXTURE_SWIZZLE_RGBA
      TextureWrapS            = LibGL::TEXTURE_WRAP_S
      TextureWrapT            = LibGL::TEXTURE_WRAP_T
      TextureWrapR            = LibGL::TEXTURE_WRAP_R
    end

    enum ParameterValue : LibGL::Enum
      DepthComponent        = LibGL::DEPTH_COMPONENT
      StencilComponent      = LibGL::STENCIL_COMPONENT
      LEqual                = LibGL::LEQUAL
      GEqual                = LibGL::GEQUAL
      Less                  = LibGL::LESS
      Greater               = LibGL::GREATER
      Equal                 = LibGL::EQUAL
      NotEqual              = LibGL::NOTEQUAL
      Always                = LibGL::ALWAYS
      Never                 = LibGL::NEVER
      CompareRefToTexture   = LibGL::COMPARE_REF_TO_TEXTURE
      None                  = LibGL::NONE
      Nearest               = LibGL::NEAREST
      Linear                = LibGL::LINEAR
      NearestMipmapNearest  = LibGL::NEAREST_MIPMAP_NEAREST
      LinearMipmapNearest   = LibGL::LINEAR_MIPMAP_NEAREST
      NearestMipmapLinear   = LibGL::NEAREST_MIPMAP_LINEAR
      LinearMipmapLinear    = LibGL::LINEAR_MIPMAP_LINEAR
      Red                   = LibGL::RED
      Green                 = LibGL::GREEN
      Blue                  = LibGL::BLUE
      Alpha                 = LibGL::ALPHA
      Zero                  = LibGL::ZERO
      One                   = LibGL::ONE
      ClampToEdge           = LibGL::CLAMP_TO_EDGE
      ClampToBorder         = LibGL::CLAMP_TO_BORDER
      MirroredRepeat        = LibGL::MIRRORED_REPEAT
      Repeat                = LibGL::REPEAT
      MirrorClampToEdge     = LibGL::MIRROR_CLAMP_TO_EDGE
    end

    enum Unit : LibGL::Enum
      Texture0 = LibGL::TEXTURE0  

      def self.activate(n : Int32)
        Unit.from_int(n).activate
      end

      def self.from_int(n : Int32)
        Unit.new(Texture0.value + n)
      end

      def activate
        LibGL.active_texture(self)
      end
    end

    @id     : LibGL::Enum
    @bound  : Bool
    @target : Target = Target.new(0_u32)

    def self.generate(n : Int32)
      LibGL.gen_textures(n, out ids)
      Slice(LibGL::Enum).new(pointerof(ids), n).map {|id| Texture.new(id)}
    end

    def initialize
      LibGL.gen_textures(1, out id)
      @id = id
      @bound = false
    end

    protected def initialize(id : LibGL::Enum)
      @id = id
      @bound = false
    end

    def target
      @target
    end

    def set_parameters(params : ParameterHash)
      params.each do |key, value|
        if value.is_a?(ParameterValue)
          LibGL.texture_parameter_i(self, key, value.as(ParameterValue))
        elsif value.is_a?(Int32)
          LibGL.texture_parameter_i(self, key, value.as(Int32))
        elsif value.is_a?(Float32)
          LibGL.texture_parameter_f(self, key, value.as(Float32))
        elsif value.is_a?(Enumerable(Float32))
          LibGL.texture_parameter_fv(self, key, Pointer(Void).new(value.object_id))
        elsif value.is_a?(Enumerable(Int32))
          LibGL.texture_parameter_iv(self, key, Pointer(Void).new(value.object_id))
        else
          LibGL.texture_parameter_iuiv(self, key, Pointer(Void).new(value.object_id))
        end
      end
    end

    def bind(target : Target, &block)
      self.bind(target)
      yield self, target
      self.unbind
    end

    def bind(target : Target)
      @target = target
      LibGL.bind_texture(@target, self)
      @bound = true
    end

    def unbind
      LibGL.bind_texture(@target, 0)
      @bound = false
      @target = Target.new(0_u32)
    end

    def to_unsafe
      @id
    end
  end
end