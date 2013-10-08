require_relative 'join_point'

class MotorDeAspectos
  def aspecto(point_cut, advice)
    a_modificar = []
    todos_los_metodos.each do |clase, metodos|
      metodos.each do |metodo|
        a_modificar.push(metodo) if point_cut.filtra_metodo?(clase, metodo)
      end
    end

    # Parte 2
    # a_modificar.each { |clase, metodo| advice.modificar(clase, metodo) }
  end

 private

  def todos_los_metodos
    @todos = Hash.new

    ObjectSpace.each_object(Class) do |c|
      @todos[c] =
          (c.methods + c.private_methods).collect { |m| c.method(m) } +
          (c.instance_methods + c.private_instance_methods).collect { |m| c.instance_method(m) }
    end

    @todos
  end
end
