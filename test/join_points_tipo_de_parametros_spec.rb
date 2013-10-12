require 'rspec'

require_relative '../src/join_point'
require_relative '../test/fixture'

describe 'JoinPointParametrosOpcionales' do

  it 'debe saber si un metodo tiene parametros opcionales' do
    j = JoinPointTipoDeParametros.new(:opt)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:donar_plata)).should == true
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:robar)).should == true
  end

  it 'debe saber si un metodo tiene parametros obligatorios' do
    j = JoinPointTipoDeParametros.new(:req)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:donar_plata)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:robar)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_de_una_forma)).should == true
  end
end