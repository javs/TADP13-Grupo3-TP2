class Advice

  attr_reader :antes, :despues, :error, :enLugarDe

  def initialize(antes=Proc.new {}, despues=Proc.new {}, error=nil, enLugarDe=nil)
    @antes = antes
    @despues = despues
    @error = error
    @enLugarDe = enLugarDe
  end

  def modificar(clase, metodo)

    simbolo = metodo.name
    simboloOriginal = ("__" + simbolo.to_s + "__").to_sym
    args = metodo.parameters.map {
        |param|
      param[1].to_s
    }
    antes = self.antes
    despues = self.despues
    error = self.error
    enLugarDe = self.enLugarDe

    clase.class_eval do

      alias_method simboloOriginal, simbolo

      define_method(simbolo) do |*args|
        antes.call *args
        begin
          unless enLugarDe.nil? then enLugarDe.call(*args) else self.send(simboloOriginal, *args) end
        rescue
          unless error.nil? then error.call(*args) else raise end
          end
        despues.call *args
      end

    end

  end

end

class AdviceAntes < Advice

  def initialize(accion)
    super(antes=accion)
  end

end

class AdviceDespues < Advice

  def initialize(accion)
    super(Proc.new{}, despues=accion)
  end

end

class AdviceError < Advice

  def initialize(accion)
    super(Proc.new{},Proc.new{},error=accion)
  end

end

class AdviceEnLugarDe < Advice

  def initialize(accion)
    super(Proc.new{},Proc.new{},nil,enLugarDe=accion)
  end

end