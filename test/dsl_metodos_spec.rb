require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para los metodos' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe aplicar el aspecto para nombres de clases usando regexes' do

    Aspecto.aplicar do
      si coincide el nombre del metodo con /hacer/
      entonces ejecutar reemplazando el original con el proc { 'soy un metodo que contiene hacer' }
    end

    Persona.new.hacer_algo.should == 'soy un metodo que contiene hacer'
    PersonaMala.new.hacer_algo_malo.should == 'soy un metodo que contiene hacer'
    Linyera.new.vagar.should_not == 'soy un metodo que contiene hacer'

  end

  it 'debe aplicar el aspecto para metodos especificos' do

    Aspecto.aplicar do
      si coincide el metodo con [Persona.instance_method(:hacer_algo),Persona.instance_method(:nombre)]
      o coincide el metodo con Persona.instance_method(:apellido)
      entonces ejecutar reemplazando el original con el proc { 'soy metodo hacer algo, nombre o apellido' }
    end

    Persona.new.nombre.should ==  'soy metodo hacer algo, nombre o apellido'
    Persona.new.hacer_algo.should ==  'soy metodo hacer algo, nombre o apellido'
    Persona.new.apellido.should ==  'soy metodo hacer algo, nombre o apellido'

  end

end