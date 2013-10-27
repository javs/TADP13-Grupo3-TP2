require_relative 'method_observer'

class Advice

  attr_accessor :accion

  def initialize(accion)
    @accion = accion
  end

  def modificar(clase, metodo)

    simbolo = metodo.name
    simbolo_original = ("__" + simbolo.to_s + "__").to_sym
    args = metodo.parameters.map {
        |param|
      param[1].to_s
    }

    while clase.method_defined?(simbolo_original)
      simbolo_original =  ("__" + simbolo_original.to_s + "__").to_sym
    end

    Class.permitir_aplicar_aspectos_a_nuevos_metodos = false

    clase.send :alias_method, simbolo_original, simbolo
    self.ejecucion_nueva(clase, simbolo, simbolo_original, *args)

    Class.permitir_aplicar_aspectos_a_nuevos_metodos = true
  end

  def ejecucion_nueva(clase, simbolo, simbolo_original, *args)
    raise 'subclass_responsibility'
  end

end

class AdviceAntes < Advice

  def ejecucion_nueva(clase, simbolo, simbolo_original, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        accion.call clase, simbolo, simbolo_original, self, *args
        self.send(simbolo_original, *args)
      end
    end
  end

end

class AdviceDespues < Advice

  def ejecucion_nueva(clase, simbolo, simbolo_original, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        resultado = self.send(simbolo_original, *args)
        accion.call clase, simbolo, simbolo_original, self, *args
        resultado
      end
    end
  end

end

class AdviceError < Advice

  def ejecucion_nueva(clase, simbolo, simbolo_original, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        begin
          resultado = self.send(simbolo_original, *args)
        rescue
          accion.call clase, simbolo, simbolo_original, self, *args
          resultado
        end
      end
    end
  end

end

class AdviceEnLugarDe < Advice

  def ejecucion_nueva(clase, simbolo, simbolo_original, *args)
    accion = self.accion
    clase.class_eval do
      define_method(simbolo) do |*args|
        accion.call clase, simbolo, simbolo_original, self, *args
      end
    end
  end

end
