require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para la aridad de los metodos' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe aplicar advice si la aridad del metodo coincide' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /hacer_algo/
      y la aridad es 1
      entonces ejecutar reemplazando el original con el proc { 'la aridad es 1' }

    end

    Linyera.new.hacer_algo_de_una_forma('nueva').should == 'la aridad es 1'
    Persona.new.hacer_algo_de_una_forma('normal').should == 'la aridad es 1'
  end

  it 'no debe aplicar advice si la aridad del metodo no coincide' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /hacer_algo/
      y la aridad es 1
      entonces ejecutar reemplazando el original con el proc { 'la aridad es 1' }

    end

    Linyera.new.hacer_algo.should_not == 'la aridad es 1'
    PersonaMala.new.hacer_algo_malo.should_not == 'la aridad es 1'

  end

end