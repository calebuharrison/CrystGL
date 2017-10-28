module CrystGL

  alias InternalFormat = BaseInternalFormat | SizedInternalFormat | CompressedInternalFormat

  enum BaseInternalFormat : LibGL::Enum
    DepthComponent  = LibGL::DEPTH_COMPONENT
    DepthStencil    = LibGL::DEPTH_STENCIL
    Red             = LibGL::RED
    RG              = LibGL::RG
    RGB             = LibGL::RGB
    RGBA            = LibGL::RGBA
  end

  enum SizedInternalFormat : LibGL::Enum
    R8              = LibGL::R8
    R8SNorm         = LibGL::R8_SNORM
    R16             = LibGL::R16
    R16SNorm        = LibGL::R16_SNORM
    RG8             = LibGL::RG8
    RG8SNorm        = LibGL::RG8_SNORM
    RG16            = LibGL::RG16
    RG16SNorm       = LibGL::RG16_SNORM
    R3G3B2          = LibGL::R3_G3_B2
    RGB4            = LibGL::RGB4
    RGB5            = LibGL::RGB5
    RGB8            = LibGL::RGB8
    RGB8SNorm       = LibGL::RGB8_SNORM
    RGB10           = LibGL::RGB10
    RGB12           = LibGL::RGB12
    RGB16SNorm      = LibGL::RGB16_SNORM
    RGBA2           = LibGL::RGBA2
    RGBA4           = LibGL::RGBA4
    RGB5A1          = LibGL::RGB5_A1
    RGBA8           = LibGL::RGBA8
    RGBA8SNorm      = LibGL::RGBA8_SNORM
    RGB10A2         = LibGL::RGB10_A2
    RGB10A2UI       = LibGL::RGB10_A2UI
    RGBA12          = LibGL::RGBA12
    RGBA16          = LibGL::RGBA16
    SRGB8           = LibGL::SRGB8
    SRGB8Alpha8     = LibGL::SRGB8_ALPHA8
    R16F            = LibGL::R16F
    RG16F           = LibGL::RG16F
    RGB16F          = LibGL::RGB16F
    RGBA16F         = LibGL::RGBA16F
    R32F            = LibGL::R32F
    RG32F           = LibGL::RG32F
    RGB32F          = LibGL::RGB32F
    RGBA32F         = LibGL::RGBA32F
    R11FG11FB10F    = LibGL::R11F_G11F_B10F
    RGB9E5          = LibGL::RGB9_E5
    R8I             = LibGL::R8I
    R8UI            = LibGL::R8UI
    R16I            = LibGL::R16I
    R16UI           = LibGL::R16UI
    R32I            = LibGL::R32I
    R32UI           = LibGL::R32UI
    RG8I            = LibGL::RG8I
    RG8UI           = LibGL::RG8UI
    RG16I           = LibGL::RG16I
    RG16UI          = LibGL::RG16UI
    RG32I           = LibGL::RG32I
    RG32UI          = LibGL::RG32UI
    RGB8I           = LibGL::RGB8I
    RGB8UI          = LibGL::RGB8UI
    RGB16I          = LibGL::RGB16I
    RGB16UI         = LibGL::RGB16UI
    RGB32I          = LibGL::RGB32I
    RGB32UI         = LibGL::RGB32UI
    RGBA8I          = LibGL::RGBA8I
    RGBA8UI         = LibGL::RGBA8UI
    RGBA16I         = LibGL::RGBA16I
    RGBA16UI        = LibGL::RGBA16UI
    RGBA32I         = LibGL::RGBA32I
    RGBA32UI        = LibGL::RGBA32UI
  end

  enum CompressedInternalFormat : LibGL::Enum
    CompressedRed                   = LibGL::COMPRESSED_RED
    CompressedRG                    = LibGL::COMPRESSED_RG
    CompressedRGB                   = LibGL::COMPRESSED_RGB
    CompressedRGBA                  = LibGL::COMPRESSED_RGBA
    CompressedSRGB                  = LibGL::COMPRESSED_SRGB
    CompressedSRGBAlpha             = LibGL::COMPRESSED_SRGB_ALPHA
    CompressedRedRGTC1              = LibGL::COMPRESSED_RED_RGTC1
    CompressedSignedRedRGTC1        = LibGL::COMPRESSED_SIGNED_RED_RGTC1
    CompressedRGRGTC2               = LibGL::COMPRESSED_RG_RGTC2
    CompressedSignedRGRGTC2         = LibGL::COMPRESSED_SIGNED_RG_RGTC2
    CompressedRGBABPTCUNorm         = LibGL::COMPRESSED_RGBA_BPTC_UNORM
    CompressedSRGBAlphaBPTCUNorm    = LibGL::COMPRESSED_SRGB_ALPHA_BPTC_UNORM
    CompressedRGBBPTCSignedFloat    = LibGL::COMPRESSED_RGB_BPTC_SIGNED_FLOAT
    CompressedRGBBPTCUnsignedFloat  = LibGL::COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT
  end

  enum Format : LibGL::Enum
    Red             = LibGL::RED
    RG              = LibGL::RG
    RGB             = LibGL::RGB
    BGR             = LibGL::BGR
    RGBA            = LibGL::RGBA
    BGRA            = LibGL::BGRA
    RedInteger      = LibGL::RED_INTEGER
    RGInteger       = LibGL::RG_INTEGER
    RGBInteger      = LibGL::RGB_INTEGER
    BGRInteger      = LibGL::BGR_INTEGER
    RGBAInteger     = LibGL::RGBA_INTEGER
    BGRAInteger     = LibGL::BGRA_INTEGER
    StencilIndex    = LibGL::STENCIL_INDEX
    DepthComponent  = LibGL::DEPTH_COMPONENT
    DepthStencil    = LibGL::DEPTH_STENCIL
  end
end