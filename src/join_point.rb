class JoinPoint

  def metodos
    matched_hash.values.reduce(Array.new) {| all, matched | all | matched }
  end

  def clases
    ObjectSpace.each_object(Class)
  end

  private

  def matched_hash
    hash = Hash.new
    clases.each { | clazz | hash[clazz] = metodos_de_clase(clazz) }
    hash
  end

  def metodos_de_clase(clazz)
    clazz.instance_methods(true).collect { |method| clazz.instance_method(method) }
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
    super.find_all {| clazz | criteria(clazz) }
  end

  def criteria(clazz)
    raise 'SubclassResponsability'
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

class JoinPointClasesEspecificas < JoinPoint

  def initialize(*clases)
    @clases = clases
  end

  def clases
    @clases
  end

end
