require 'rspec'

require_relative '../src/transacciones'
require_relative '../test/fixture'

describe AdviceTransaccion do

  it 'debe trabajar con copias de los atributos' do

    persona = Persona.new

    AdviceTransaccion.new(persona).modificar_objecto

    persona.nombre = 'Pepe'
    persona.nombre.should == 'Pepe'
    persona.instance_variable_get(:@nombre).should == nil

  end

  it 'debe poder hacer un commit' do

    persona = Persona.new

    AdviceTransaccion.new(persona).modificar_objecto

    persona.nombre = 'Pepe'
    persona.nombre.should == 'Pepe'
    persona.instance_variable_get(:@nombre).should == nil

    persona.commit

    persona.instance_variable_get(:@nombre).should == 'Pepe'
    persona.nombre.should == 'Pepe'

  end

  it 'debe poder hacer un rollback' do
    persona = Persona.new
    persona.nombre = 'Jorge'

    AdviceTransaccion.new(persona).modificar_objecto

    persona.nombre.should == 'Jorge'

    persona.nombre = 'Pepe'
    persona.nombre.should == 'Pepe'

    persona.rollback
    persona.nombre.should == 'Jorge'

  end

  it 'debe modificar solo a un objeto' do

    persona = Persona.new
    otra_persona = Persona.new

    AdviceTransaccion.new(persona).modificar_objecto

    persona.nombre = 'Pepe'
    persona.nombre.should == 'Pepe'
    persona.instance_variable_get(:@nombre).should == nil

    otra_persona.nombre = 'Cacho'
    otra_persona.nombre.should == 'Cacho'
    otra_persona.instance_variable_get(:@nombre).should == 'Cacho'

  end

  it 'debe realizar el autocommit al ejecutar el set del atributo' do

    persona = Persona.new

    advice = AdviceTransaccion.new(persona)
    advice.autocommit = true
    advice.modificar_objecto

    persona.nombre = 'Pepe'
    persona.rollback
    persona.nombre.should == 'Pepe'
    persona.instance_variable_get(:@nombre).should == 'Pepe'

  end

  it 'debe realizar el autorollback al ejecutar el set del atributo y salga por error' do

    persona = Persona.new
    persona.nombre = 'Jorge'

    advice = AdviceTransaccion.new(persona)

    adviceAntes = AdviceAntes.new(Proc.new {raise 'ERROR EJECUTANDO ROLLBACK'})
    point_cut = JoinPointMetodosAccessors.new(persona.singleton_class).y(JoinPointMetodosEspecificos.new(Persona.instance_method(:nombre=)))
    MotorDeAspectos.new.aspecto(point_cut,adviceAntes,persona.singleton_class)

    advice.autocommit = true
    advice.modificar_objecto


    persona.nombre = 'Pepe'
    persona.commit
    persona.nombre.should == 'Jorge'

  end

end
