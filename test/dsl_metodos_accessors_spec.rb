require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL que describe los metodos accessors' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe hacer algo despues si le pasamos como parametro un metodo accessor' do


    Aspecto.aplicar do

      si es un accessor de Persona
      entonces ejecutar despues del original el proc { 'soy un metodo accessor' }
    end

    Persona.new.nombre.should ==  'soy un metodo accessor'
    Persona.new.apellido.should ==  'soy un metodo accessor'

  end

  it 'debe hacer nada si le pasamos como parametro un metodo no accessor' do

    Aspecto.aplicar do

      si es un accessor de Linyera
      entonces ejecutar despues del original el proc { 'soy un metodo accessor' }
    end

    Linyera.new.to_s.should_not ==  'soy un metodo accessor'
    Persona.new.nombre.should_not ==  'soy un metodo accessor'

  end

end