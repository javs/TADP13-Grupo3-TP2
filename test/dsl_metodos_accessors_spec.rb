require_relative '../src/dsl'
require_relative 'fixture'

describe JoinPointMetodosAccessors do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe hacer algo despues si le pasamos como parametro un metodo accessor' do


    Aspecto.aplicar do

    si coincide el nombre de la clase_accessor con Persona
    y coincide el nombre del metodo con /nombre/
     entonces ejecutar despues del original el proc { 'soy un metodo accessor'
    }
    end

    persona = Persona.new
    Persona.new.nombre.should ==  'soy un metodo accessor'

  end

  it 'debe hacer nada si le pasamos como parametro un metodo no accessor' do


    Aspecto.aplicar do

      si coincide el nombre de la clase_accessor con Persona
      y coincide el nombre del metodo con /to_s/
      entonces ejecutar despues del original el proc { 'soy un metodo accessor'
      }
    end

    persona = Persona.new
    Persona.new.to_s.should_not ==  'soy un metodo accessor'

  end
end