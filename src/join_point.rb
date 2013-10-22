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
    return true if clase.name =~ regex
    false
  end

end

class JoinPointNombreMetodo < JoinPointExpresionRegular

  def filtra_metodo?(clase,metodo)
    return true if metodo.name =~ regex
    false
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

class JoinPointTipoDeParametros < JoinPoint

  attr_reader :tipo

  def initialize(tipo)
    @tipo = tipo
  end

  def filtra_metodo?(clase,metodo)
    metodo.parameters.any?{|parametro| parametro[0] == tipo}
  end

end

class JoinPointNombreParametros < JoinPointExpresionRegular

  def filtra_metodo?(clase,metodo)
    metodo.parameters.any?{|parametro| parametro[1] =~ regex}
  end

end

class JoinPointMetodosAccessors < JoinPoint
  def initialize(clase)
    setters =  (clase.instance_methods + clase.private_instance_methods).select{|item| item.to_s =~ /^(\w+)=$/}
    getters = setters.collect{|item| item.to_s.slice(0..item.to_s.length-2)}
    @metodos = (setters + getters).collect{|item| clase.instance_method(item)}
  end

  def filtra_metodo?(clase, metodo)
    @metodos.include? metodo
  end
end

class JoinPointMetodosEspecificos < JoinPoint

  def initialize(*metodos)
    @metodos = metodos
  end

  def filtra_metodo?(clase, metodo)
    @metodos.include? metodo
  end

end