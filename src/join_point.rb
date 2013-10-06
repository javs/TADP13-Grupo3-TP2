class JoinPoint
  def filtra_metodo?(clase, metodo)
    raise :subclass_responsibility
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

# migrar -------

class JoinPointExpresionRegular < JoinPoint

  def initialize(regex)
    @regex = regex
  end

  def regex
    @regex
  end

  def clases
    super.find_all {| clazz | criteria(clazz) }
  end

  def criteria(clazz)
    raise :subclass_responsibility
  end

end

class JoinPointNombreClase < JoinPointExpresionRegular

  def criteria(clazz)
    if clazz.name =~ regex
      true
    else
      false
    end
  end

end

class JoinPointNombreMetodo < JoinPointExpresionRegular

  def criteria(clazz)
      not metodos_de_clase(clazz).empty?
  end

  def metodos_de_clase(clazz)
    super.find_all { | method |
       method.name =~ regex
    }
  end

end

