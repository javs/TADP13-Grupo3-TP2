require_relative '../src/motor_de_aspectos'

class Aspecto

  def self.aplicar(&bloque_configuracion)
    Aspecto.new.instance_eval &bloque_configuracion
  end

  def reemplazando(bloque)
    AdviceEnLugarDe.new bloque
  end

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

  def clase(regex)
    JoinPointNombreClase.new(regex)
  end

  def metodo(regex)
    JoinPointNombreMetodo.new(regex)
  end

  def jerarquia(clase)
    JoinPointJerarquiaDeClase.new(clase)
  end

  def parametro(regex)
    JoinPointNombreParametros.new(regex)
  end

  def nombre(joinpoint)
    joinpoint
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

end