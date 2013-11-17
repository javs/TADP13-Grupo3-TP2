require 'rspec'
require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para clases' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe aplicar el aspecto para nombres de clases usando regexes' do
    Aspecto.aplicar do
      si coincide el nombre de la clase con /Persona/
      entonces ejecutar en lugar del original el proc { 'me arrepiento' }
    end

    persona_modificada = PersonaMala.new
    persona_modificada.hacer_algo_malo.should == 'me arrepiento'
    persona_modificada.robar('auto').should == 'me arrepiento'

    persona_modificada = OtraPersona.new
    persona_modificada.hacer_algo.should == 'me arrepiento'

    persona_no_modificada = Linyera.new
    persona_no_modificada.vagar.should_not == 'me arrepiento'
  end

  it 'debe aplicar el aspecto para clases especificas' do
    Aspecto.aplicar do
      si coincide el nombre de la clase con Linyera
      entonces ejecutar en lugar del original el proc { 'conseguir trabajo' }
    end

    persona_no_modificada = PersonaMala.new
    persona_no_modificada.hacer_algo_malo.should_not == 'conseguir trabajo'

    persona_modificada = Linyera.new
    persona_modificada.vagar.should == 'conseguir trabajo'
  end
end