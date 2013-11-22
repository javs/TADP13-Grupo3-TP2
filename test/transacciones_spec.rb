require 'rspec'

require_relative '../src/transacciones'
require_relative '../test/fixture'

describe AdviceTransaccion do

  before(:all) do
    class Mascota
      attr_accessor :nombre
    end
  end

  it 'debe trabajar con copias de los atributos' do

    perro = Mascota.new

    AdviceTransaccion.new(perro).modificar_objecto

    perro.nombre = 'Pepe'
    perro.nombre.should == 'Pepe'
    perro.instance_variable_get(:@nombre).should == nil

  end

  it 'debe poder hacer un commit' do

    perro = Mascota.new

    AdviceTransaccion.new(perro).modificar_objecto

    perro.nombre = 'Pepe'
    perro.nombre.should == 'Pepe'
    perro.instance_variable_get(:@nombre).should == nil

    perro.commit

    perro.nombre.should == 'Pepe'
    perro.instance_variable_get(:@nombre).should == 'Pepe'

  end

  it 'debe poder hacer un rollback' do
    perro = Mascota.new
    perro.nombre = 'Jorge'

    AdviceTransaccion.new(perro).modificar_objecto

    perro.nombre.should == 'Jorge'

    perro.nombre = 'Pepe'
    perro.nombre.should == 'Pepe'

    perro.rollback
    perro.nombre.should == 'Jorge'

  end

  it 'debe modificar solo a un objeto' do

    perro = Mascota.new
    otro_perro = Mascota.new

    AdviceTransaccion.new(perro).modificar_objecto

    perro.nombre = 'Pepe'
    perro.nombre.should == 'Pepe'
    perro.instance_variable_get(:@nombre).should == nil

    otro_perro.nombre = 'Cacho'
    otro_perro.nombre.should == 'Cacho'
    otro_perro.instance_variable_get(:@nombre).should == 'Cacho'

  end

  it 'debe realizar el autocommit al ejecutar el set del atributo' do

    perro = Mascota.new

    advice = AdviceTransaccion.new(perro)
    advice.autocommit = true
    advice.modificar_objecto

    perro.nombre = 'Pepe'
    perro.rollback
    perro.nombre.should == 'Pepe'
    perro.instance_variable_get(:@nombre).should == 'Pepe'

  end

  it 'debe realizar el autorollback al ejecutar el set del atributo y salga por error' do

    perro = Mascota.new
    perro.nombre = 'Jorge'

    advice = AdviceTransaccion.new(perro)

    advice.autocommit = true
    advice.modificar_objecto

    sym = '____nombre=____'
    proc = Proc.new { |a| raise 'errror' }
    perro.define_singleton_method sym, proc

    perro.nombre = 'Pepe'
    perro.commit
    perro.nombre.should == 'Jorge'

  end

end
