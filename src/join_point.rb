class JoinPoint

  # "PRIVATE"

  def matched_hash
    hash = Hash.new
    clases.each { | clazz | hash[clazz] = metodos_de_clase(clazz) }
    hash
  end

  def metodos_de_clase(clazz)
    clazz.instance_methods(true)
  end

  # "PUBLIC"

  def metodos
    matched_hash.values.reduce(Array.new) {| all, matched | all | matched}
  end

  def clases
    ObjectSpace.each_object(Class)
  end

end

class JoinPointExpresionRegular < JoinPoint

  def initialize(regex)
    @regex = regex
  end

  def regex
    @regex
  end

  def clases
    super.find_all {| clazz | criteria.call clazz }
  end

  def criteria
    raise 'SubclassResponsability'
  end

end

class JoinPointNombreClase < JoinPointExpresionRegular

  def criteria
    Proc.new { | clazz |
      if @regex =~ clazz.name
        true
      else
        false
      end
    }
  end

end

class JoinPointNombreMetodo < JoinPointExpresionRegular

  def criteria
    Proc.new { | clazz |
      not metodos_de_clase(clazz).empty?
    }
  end

  def metodos_de_clase(clazz)
    super.find_all { | method |
      regex =~ method
    }
  end

end

class JoinPointClasesEspecificas < JoinPoint

  def initialize(*clases)
    @clases = clases
  end

  def clases
    @clases
  end

end