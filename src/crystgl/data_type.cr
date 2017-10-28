module CrystGL
  enum DataType : LibGL::Enum
    Byte = LibGL::BYTE
    UnsignedByte = LibGL::UNSIGNED_BYTE
    Short = LibGL::SHORT
    UnsignedShort = LibGL::UNSIGNED_SHORT
    Int = LibGL::INT
    UnsignedInt = LibGL::UNSIGNED_INT
    HalfFloat = LibGL::HALF_FLOAT
    Float = LibGL::FLOAT
    Double = LibGL::DOUBLE
    Fixed = LibGL::FIXED
    Int2101010Rev = LibGL::INT_2_10_10_10_REV
    UnsignedInt2101010Rev = LibGL::UNSIGNED_INT_2_10_10_10_REV
    UnsignedInt10f11f11fRev = LibGL::UNSIGNED_INT_10F_11F_11F_REV
  end

  def self.from(v : Int8) : DataType
    DataType::Byte
  end

  def self.from(v : UInt8) : DataType
    DataType::UnsignedByte
  end

  def self.from(v : Int16) : DataType
    DataType::Short
  end

  def self.from(v : UInt16) : DataType
    DataType::UnsignedShort
  end

  def self.from(v : Int32) : DataType
    DataType::Int
  end

  def self.from(v : UInt32) : DataType
    DataType::UnsignedInt
  end

  def self.from(v : Float32) : DataType
    DataType::Float
  end

  def self.from(v : Float64) : DataType
    DataType::Double
  end

end