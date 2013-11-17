require_relative '../src/dsl'
require_relative 'fixture'

describe Aspecto do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe aplicar advice si es de la jerarquia de Persona' do

    Aspecto.aplicar do

      si pertenece a la jerarquia de Persona
      y coincide el nombre del metodo con /hacer/
      entonces ejecutar reemplazando el original con proc { 'soy de clase Persona' }

    end
    Linyera.new.hacer_algo.should == 'soy de clase Persona'
    Persona.new.hacer_algo.should == 'soy de clase Persona'
    OtraPersona.new.hacer_algo.should == 'soy de clase Persona'
  end

  it 'no debe aplicar advice si no es de la jerarquia de Linyera' do

    Aspecto.aplicar do

      si pertenece a la jerarquia de Linyera
      entonces ejecutar reemplazando el original con proc { 'soy de clase Linyera' }

    end
    Linyera.new.vagar.should == 'soy de clase Linyera'
    Persona.new.hacer_algo.should_not == 'soy de clase Linyera'
  end

end