module CrystGL
  class VertexArray

    @id : LibGL::Enum
    @bound : Bool
    @defining_attributes : Bool
    @attributes : Array(Attribute)

    def self.generate(n : Int32)
      LibGL.gen_vertex_arrays(n, out ids)
      Slice(LibGL::Enum).new(pointerof(ids), n).map {|id| VertexArray.new(id)}
    end

    def initialize
      LibGL.gen_vertex_arrays(1, out id)
      @id = id
      @bound = false
      @defining_attributes = false
      @attributes = Array(Attribute).new
    end

    protected def initialize(id : LibGL::Enum)
      @id = id
      @bound = false
      @defining_attributes = false
      @attributes = Array(Attribute).new
    end

    def defining_attributes?
      @defining_attributes
    end

    def attributes
      @attributes
    end

    def bind(&block)
      self.bind
      yield self
      self.unbind
    end

    def bind
      raise "cannot double-bind vertex array" if bound?
      LibGL.bind_vertex_array(@id)
      @bound = true
    end

    def unbind
      raise "cannot unbind unbound vertex array" unless bound?
      LibGL.bind_vertex_array(0)
      @bound = false
    end

    private def attach_attributes
      stride = @attributes.reduce(0) { |memo, a| memo + (a.count * sizeof(typeof(a.data_type))) }
      @attributes.each_with_index do |a, i|
        a.stride = stride 
        a.offset = @attributes[i-1].offset + (@attributes[i-1].count * sizeof(typeof(@attributes[i-1].data_type))) unless i == 0
        a.register
        a.enable
      end
    end

    def define_attributes(&block)
      raise "must be bound to define attributes!" unless bound?
      @defining_attributes = true
      @attributes.clear
      yield self
      attach_attributes
      @defining_attributes = false
    end

    def attribute(count : Int32, data_type : DataType, normalized : Bool)
      raise "must be specified within a define_attributes block!" unless defining_attributes?
      index = @attributes.size
      @attributes << Attribute.new(index, count, data_type, normalized)
    end

    private def bound?
      @bound
    end

    def delete
      LibGL.delete_vertex_arrays(1, pointerof(@id))
    end

    def to_unsafe
      @id
    end

    class Attribute

      @normalized : Bool

      getter index : Int32
      getter count : Int32
      getter data_type : DataType
      property stride : Int32
      property offset : Int32

      def initialize(index : Int32, count : Int32, data_type : DataType, normalized : Bool)
        @index = index
        @count = count
        @data_type = data_type
        @normalized = normalized
        @stride = 0
        @offset = 0
      end

      def normalized?
        @normalized
      end

      def register
        LibGL.vertex_attrib_pointer(@index, @count, @data_type, Boolean.from(@normalized), @stride, Pointer(Void).new(@offset))
      end

      def enable
        LibGL.enable_vertex_attrib_array(@index)
      end

      def disable
        LibGL.disable_vertex_attrib_array(@index)
      end
    end
  end
end