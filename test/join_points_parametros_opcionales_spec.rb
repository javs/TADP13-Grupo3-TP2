require 'rspec'

require_relative '../src/join_point'
require_relative '../test/fixture'

describe 'JoinPointParametrosOpcionales' do

  before :each do
    @clases = Array.new
  end

  it 'debe saber si un metodo tiene parametros opcionales' do
    j = JoinPointParametrosOpcionales.new
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:donar_plata)).should == true
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:robar)).should == true
  end
end