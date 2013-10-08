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

  def criteria(clase,metodo)
    raise 'subclass_responsibility'
  end

  def filtra_metodo?(clase,metodo)
    self.criteria(clase,metodo)
  end

end

class JoinPointNombreClase < JoinPointExpresionRegular

  def criteria(clase,metodo)
    return false unless clase.name =~ regex
    true
  end

end

class JoinPointNombreMetodo < JoinPointExpresionRegular

  def criteria(clase,metodo)
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

class JoinPointJerarquiaDeClase

  attr_reader :superclase

  def initialize(clase)
    @superclase = clase
  end

  def filtra_metodo?(clase,metodo)
    clase.ancestors.include? superclase
  end

end
