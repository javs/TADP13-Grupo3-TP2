require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para tipo de parametros' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe reemplazar si un metodo tiene parametros opcionales' do

    Aspecto.aplicar do

      si el tipo de parametro es opcional
      y pertenece a la jerarquia de Persona
      entonces ejecutar reemplazando el original con el proc { 'Inspector de billeteras' }

    end

    OtraPersona.new.donar_plata(100).should == 'Inspector de billeteras'
    OtraPersona.new.devolver('Un String').should == 'Un String'

  end


  it 'debe reemplazar si un metodo tiene parametros requeridos' do
    Aspecto.aplicar do

      si el tipo de parametro es requerido
      y pertenece a la jerarquia de Persona
      entonces ejecutar reemplazando el original con el proc { 'No hagas las cosas como te dicen' }

    end
    Persona.new.hacer_algo_de_una_forma('Max Power Style').should == 'No hagas las cosas como te dicen'
    OtraPersona.new.donar_plata(90).should_not == 'No hagas las cosas como te dicen'
  end



end