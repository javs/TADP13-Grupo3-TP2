class Advice

  attr_accessor :accion

  def initialize(accion)
    @accion = accion
  end

  def modificar(clase, metodo)

    simbolo = metodo.name
    simboloOriginal = ("__" + simbolo.to_s + "__").to_sym
    args = metodo.parameters.map {
        |param|
      param[1].to_s
    }
    clase.send :alias_method, simboloOriginal, simbolo
    self.ejecucionNueva(clase, simbolo, simboloOriginal, *args)

  end

  def ejecucionNueva(clase, simbolo, simboloOriginal, *args)
    raise :subclass_responsability
  end

end

class AdviceAntes < Advice

  def ejecucionNueva(clase, simbolo, simboloOriginal, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        accion.call *args
        self.send(simboloOriginal, *args)
      end
    end
  end

end

class AdviceDespues < Advice

  def ejecucionNueva(clase, simbolo, simboloOriginal, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        self.send(simboloOriginal, *args)
        accion.call *args
      end
    end
  end

end

class AdviceError < Advice

  def ejecucionNueva(clase, simbolo, simboloOriginal, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        begin
          self.send(simboloOriginal, *args)
        rescue
          accion.call *args
        end
      end
    end
  end

end

class AdviceEnLugarDe < Advice

  def ejecucionNueva(clase, simbolo, simboloOriginal, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        accion.call *args
      end
    end
  end

end