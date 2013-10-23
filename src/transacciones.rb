require_relative 'join_point'
require_relative 'advice'

class AdviceTransaccion

  def initialize(objeto)
    @objeto = objeto
    @objeto_copia = objeto.dup
  end

  def modificar_objecto

    crear_metodos_transacciones

    lista_de_accessors.each do |accessor|

      accessor_es_getter = accessor.name !~ /^(\w+)=$/ ? true : false
      atributo_simbolo = "@#{accessor.name}".sub(/=/,'').to_sym

      proc = Proc.new { |valor|
        @objeto_copia.instance_variable_set(atributo_simbolo,valor)
      }
      proc = Proc.new {
        @objeto_copia.instance_variable_get(atributo_simbolo)
      } if accessor_es_getter

      AdviceEnLugarDe.new(proc).modificar(@objeto.singleton_class,accessor)

    end

  end

  private

  def lista_de_accessors
    metodos =
        (@objeto.class.instance_methods +
            @objeto.class.private_instance_methods).collect do |metodo|
          @objeto.class.instance_method(metodo)
        end

    join_point = JoinPointMetodosAccessors.new(@objeto.class)

    metodos.select do |metodo|
      join_point.filtra_metodo?(@objeto.class, metodo)
    end

  end

  def crear_metodos_transacciones

    adivce_transaccion = self
    objecto_copia = @objeto_copia

    @objeto.singleton_class.class_eval do

      define_method(:commit) do
        objecto_copia.instance_variables.each do |atributo|
          valor = objecto_copia.instance_variable_get(atributo)
          self.instance_variable_set(atributo,valor)
        end
      end

      define_method(:rollback) do
        adivce_transaccion.instance_variable_set(:@objeto_copia,self.dup)
      end

    end

  end

end