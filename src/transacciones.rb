require_relative 'join_point'
require_relative 'advice'

class AdviceTransaccion

  def initialize(objeto)
    @objeto = objeto
  end

  def modificar_objecto

    accessors = lista_de_accessors

    return true if accessors.empty?

    @objeto.singleton_class.class_eval do

      def commit

        self.instance_variables.select do |variable|
          variable =~ /copia$/
        end.each do |variable|
          self.instance_variable_set(variable.to_s.sub(/_copia/,'').to_sym,instance_variable_get(variable))
        end

      end

      def rollback
        puts 'rollbackeo'
      end

    end

    accessors.each do |accessor|

      accessor_es_setter = accessor.name =~ /^(\w+)=$/ ? true : false
      accessor_copia = "@#{accessor.name}_copia".sub(/=/,'').to_sym

      if accessor_es_setter
        proc = Proc.new { |valor|
          @objeto.instance_variable_set(accessor_copia,valor)
        }
      else
        @objeto.instance_variable_set(accessor_copia,@objeto.send(accessor.name))
        proc = Proc.new {
          @objeto.instance_variable_get(accessor_copia)
        }
      end

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

end





