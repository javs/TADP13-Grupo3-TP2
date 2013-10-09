require_relative 'operadores'

class JoinPoint
  include Operable

  def filtra_metodo?(clase, metodo)
    raise 'subclass_responsibility'
  end
end

class JoinPointClasesEspecificas < JoinPoint

  def initialize(*clases)
    @clases = clases
  end

  def filtra_metodo?(clase, metodo)
    @clases.include? clase
  end

end

class JoinPointExpresionRegular < JoinPoint

  attr_reader :regex

  def initialize(regex)
    @regex = regex
  end

  def filtra_metodo?(clase,metodo)
    raise 'subclass_responsibility'
  end

end

class JoinPointNombreClase < JoinPointExpresionRegular

  def filtra_metodo?(clase,metodo)
    return false unless clase.name =~ regex
    true
  end

end

class JoinPointNombreMetodo < JoinPointExpresionRegular

  def filtra_metodo?(clase,metodo)
    return false unless metodo.name =~ regex
    true
  end

end

class JoinPointAridadMetodo < JoinPoint

  attr_reader :requeridos

  def initialize(requeridos)
    @requeridos = requeridos
  end

  def filtra_metodo?(clase,metodo)
    aridad = metodo.arity
    aridad += 1 if aridad < 0
    aridad.abs == requeridos
  end

end

class JoinPointJerarquiaDeClase < JoinPoint

  attr_reader :superclase

  def initialize(clase)
    @superclase = clase
  end

  def filtra_metodo?(clase,metodo)
    clase.ancestors.include? superclase
  end

end



class JoinPointParametrosOpcionales < JoinPoint

  def tiene_parametros_opcionales?(metodo)
    metodo.arity<0
  end

  def filtra_metodo?(clase,metodo)
    self.tiene_parametros_opcionales?(metodo)
  end

end

class JoinPointNombreParametros < JoinPointExpresionRegular

  def filtra_metodo?(clase,metodo)
    metodo.parameters.any?{|parametro| parametro[1] =~ regex}
  end

end