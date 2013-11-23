require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL que describe los metodos especificos' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe hacer algo despues si le pasamos como parametro un metodo' do


    Aspecto.aplicar do
      si coincide el nombre de los metodos con [Persona.instance_method(:hacer_algo),Persona.instance_method(:nombre)]
      entonces ejecutar reemplazando el original con el proc { 'soy metodo hacer algo o hacer nombre' }
    end

    Persona.new.nombre.should ==  'soy metodo hacer algo o hacer nombre'
    Persona.new.hacer_algo.should ==  'soy metodo hacer algo o hacer nombre'

  end

  it 'debe hacer nada si ejecutamos un metodo que no le hayamos pasado como parametro' do

    Aspecto.aplicar do
      si coincide el nombre de los metodos con [Persona.instance_method(:hacer_algo),Persona.instance_method(:nombre)]
      entonces ejecutar reemplazando el original con el proc { 'soy metodo hacer algo o hacer nombre' }
    end

    Persona.new.apelido.should_not ==  'soy metodo hacer algo o hacer nombre'

  end

end