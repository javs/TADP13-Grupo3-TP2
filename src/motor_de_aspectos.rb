require_relative 'join_point'
require_relative 'advice'
require_relative 'method_observer'

class MotorDeAspectos
  def aspecto(point_cut, advice, auto_clase=nil)

    metodos_a_analizar = Hash.new
    metodos_a_modificar = Hash.new

    if auto_clase
      metodos_a_analizar[auto_clase] = metodos_de_una_clase(auto_clase) + metodos_de_una_clase(auto_clase.superclass)
    else
      metodos_a_analizar = todos_los_metodos
    end

    metodos_a_analizar.each_pair do |clase, metodos|
      metodos.each do |metodo|
        if point_cut.filtra_metodo?(clase, metodo)
          metodos_a_modificar[clase] = Array.new if metodos_a_modificar[clase].nil?
          metodos_a_modificar[clase].push(metodo)
        end
      end
    end

    observar_nuevos_metodos(point_cut, advice)

    metodos_a_modificar.each do |clase, metodos|
      metodos.each do |metodo|
        advice.modificar(clase, metodo)
      end
    end
  end

  def observar_nuevos_metodos(point_cut, advice)
    Class.send(:include, MethodObserver) unless Class.include? MethodObserver
    Class.__agregar_aspecto__(point_cut, advice)
  end

  private

  def todos_los_metodos
    @todos = Hash.new

    ObjectSpace.each_object(Class) do |clase|
      @todos[clase] = metodos_de_una_clase(clase)
    end

    @todos
  end

  def metodos_de_una_clase(clase)
    (clase.instance_methods(false)).collect { |m| clase.instance_method(m) }
  end

end
