require_relative 'join_point'

class MotorDeAspectos
  def aspecto(point_cut, advice)
    a_modificar = todos_los_metodos.select do |clase, metodo|
      point_cut.filtra_metodo?(clase, metodo)
    end

    # Parte 2
    # a_modificar.each { |clase, metodo| advice.modificar(clase, metodo) }
  end

  private

  def todos_los_metodos
    return @todos if not @todos.nil?

    @todos = Hash.new

    ObjectSpace.each_object(Class) do |c|
      @todos[c] =
          (c.methods + c.private_methods).collect { |m| c.method(m) } +
          (c.instance_methods + c.private_instance_methods).collect { |m| c.instance_method(m) }
    end

    @todos
  end
end