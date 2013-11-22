require_relative '../src/motor_de_aspectos'
require_relative '../src/transacciones'

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
    if (obj.class == Class)
      JoinPointClasesEspecificas.new obj
    else
      JoinPointNombreClase.new obj
    end
  end

  def clase_accessor(obj)
    JoinPointMetodosAccessors.new obj
  end

  def metodo(regex)
    JoinPointNombreMetodo.new(regex)
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

  def aridad(cantidad)
    JoinPointAridadMetodo.new(cantidad)
  end

  def transaccionable(objeto)
    AdviceTransaccion.new(objeto).modificar_objecto
  end

  def nombre(objeto)
    objeto
  end

  def con(objeto)
    objeto
  end

  def de(objeto)
    objeto
  end

  def matchea(objeto)
    objeto
  end

  def tipo(objeto)
    objeto
  end

  def coincide(objeto)
    objeto
  end

  def el(objeto)
    objeto
  end

  def la(objeto)
    objeto
  end

  def del(objeto)
    objeto
  end

  def entonces(objeto)
    objeto
  end

  def original(objeto)
    objeto
  end

  def en(objeto)
    objeto
  end

  def caso(objeto)
    objeto
  end

  def pertenece(objeto)
    objeto
  end

  def a(objeto)
    objeto
  end

  def es(objeto)
    objeto
  end

  def hacer(objeto)
    objeto
  end

  def al(objeto)
    objeto
  end

  def objeto(objeto)
    objeto
  end

  end
