require "lib_gl"
module CrystGL
  enum Boolean
    True  = LibGL::TRUE
    False = LibGL::FALSE

    def true?
      self == Boolean::True
    end

    def self.from(b : Bool)
      if b
        Boolean::True
      else
        Boolean::False
      end
    end
  end
end