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


end