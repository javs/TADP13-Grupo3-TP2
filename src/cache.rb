require_relative '../src/advice'

class AbstractCache

  def self.cache
    raise 'subclass_responsibility'
  end

  def self.advice
    cachear_o_devolver_cacheado = Proc.new {
        |clase, simbolo, simbolo_original, instancia, *args|
      invocacion = invocacion_cacheada(clase, simbolo, instancia, args)
      invocacion_cacheada = self.cache.detect {|cached| cached.eql? invocacion}
      unless invocacion_cacheada.nil?
        next invocacion_cacheada.resultado
      else
        resultado = instancia.send simbolo_original, *args
        invocacion.resultado = resultado
        self.cache << invocacion
      end
      resultado
    }
    AdviceEnLugarDe.new(cachear_o_devolver_cacheado)
  end

  def self.invocacion_cacheada(clase, simbolo, instancia, args)
    raise 'subclass_responsibility'
  end

  def self.clear_cache
    @@cache = Array.new
  end

end

class StatelessCache < AbstractCache

  @@cache = Array.new

  def self.cache
    @@cache
  end

  InvocacionCacheadaSinEstado = Struct.new(:clase, :simbolo, :args, :resultado) do
    def eql?(other)
      (clase.eql? other.clase) and (simbolo.eql? other.simbolo) and (args.eql? other.args)
    end
  end

  def self.invocacion_cacheada(clase, simbolo, instancia, args)
    InvocacionCacheadaSinEstado.new(clase, simbolo, args)
  end

end

class StatefulCache < AbstractCache

  @@cache = Array.new

  def self.cache
    @@cache
  end

  InvocacionCacheadaConEstado = Struct.new(:clase, :simbolo, :estado, :args, :resultado) do
    def eql?(other)
      (clase.eql? other.clase) and (simbolo.eql? other.simbolo) and (args.eql? other.args) and (compare_estados?(estado,other.estado))
    end
    def compare_estados?(cacheado, objeto)
      variables_de_cacheado = cacheado.keys
      variables_de_objeto = objeto.keys
      diferencias_entre_variables = (variables_de_cacheado - variables_de_objeto) and (variables_de_objeto - variables_de_cacheado)
      if (diferencias_entre_variables) == []
        variables_de_cacheado.all? {
            |variable|
          cacheado[variable].eql?(objeto[variable])
        }
      else
        false
      end
    end
  end

  def self.invocacion_cacheada(clase, simbolo, instancia, args)
    estado = Hash.new
    instancia.instance_variables.each {
      | variable | estado[variable] = instancia.instance_variable_get(variable)
    }
    InvocacionCacheadaConEstado.new(clase, simbolo, estado, args)
  end

end