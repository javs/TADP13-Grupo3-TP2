require 'rspec'

require_relative '../src/join_point'
require_relative '../test/fixture'

describe JoinPointNombreParametros do

  before :each do
    @clases = Array.new
  end

  it 'debe matchear con una regex un parametro' do
    j = JoinPointNombreParametros.new(/orm/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo_de_una_forma)).should == true
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false

  end
end