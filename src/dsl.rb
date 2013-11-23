require_relative '../src/motor_de_aspectos'
require_relative '../src/transacciones'
require_relative '../src/cache'

class Aspecto

  def self.aplicar(&bloque_configuracion)
    Aspecto.new.instance_eval &bloque_configuracion
  end

  def reemplazando(bloque)
    AdviceEnLugarDe.new bloque
  end

  alias_method :lugar, :reemplazando

  def despues(bloque)
    AdviceDespues.new bloque
  end

  def antes(bloque)
    AdviceAntes.new bloque
  end

  def error(bloque)
    AdviceError.new bloque
  end

  def si(point_cut)
    raise 'un_solo_si_permitido_exception' unless @point_cut.nil?
    @point_cut = point_cut
  end

  def y(joinpoint)
    @point_cut = @point_cut.y(joinpoint)
  end

  def o(joinpoint)
    @point_cut = @point_cut.o(joinpoint)
  end

  def no(joinpoint)
    joinpoint.no
  end

  def ejecutar(advice)
    MotorDeAspectos.new.aspecto(@point_cut,advice)
    @point_cut = nil
  end

  def clase(obj)
    if obj.class == Class
      JoinPointClasesEspecificas.new obj
    elsif obj.class == Array
      raise 'el array no contiene todas clases' unless obj.all? { |o| o.class == Class }
      JoinPointClasesEspecificas.new *obj
    else
      JoinPointNombreClase.new obj
    end
  end

  def metodo(obj)
    if obj.class == UnboundMethod or obj.class == Method
      JoinPointMetodosEspecificos.new obj
    elsif obj.class == Array
      raise 'el array no contiene todos metodos' unless obj.all? { |o| o.class == UnboundMethod or o.class == Method }
      JoinPointMetodosEspecificos.new *obj
    else
      JoinPointNombreMetodo.new obj
    end
  end

  def accessor(obj)
    JoinPointMetodosAccessors.new obj
  end

  def jerarquia(clase)
    JoinPointJerarquiaDeClase.new(clase)
  end

  def parametro(param)
    if param.eql? :opt or param.eql? :req
      JoinPointTipoDeParametros.new(param)
    else
      JoinPointNombreParametros.new(param)
    end

  end

  def opcional
    :opt
  end

  def requerido
    :req
  end

  alias_method :cachear, :ejecutar

  def usando(objeto)
    StatefulCache.advice
  end

  def sin(objeto)
    StatelessCache.advice
  end

  def usar(objeto)
  end

  def estado
  end

  def aridad(cantidad)
    JoinPointAridadMetodo.new(cantidad)
  end

  def transaccionable(objeto)
    AdviceTransaccion.new(objeto).modificar_objecto
  end

  def pasamanos(objeto)
    objeto
  end

  def self.crear_pasamanos(*args)
    args.each { | nombre_pasamanos | alias_method nombre_pasamanos, :pasamanos }
  end

  crear_pasamanos :hacer, :es, :pertenece, :coincide, :matchea
  crear_pasamanos :nombre, :original, :tipo, :caso, :objeto
  crear_pasamanos :en, :a, :de, :un, :con, :entonces
  crear_pasamanos :el, :la, :al, :del, :los


end
