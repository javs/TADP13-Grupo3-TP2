require 'rspec'

require_relative '../src/join_point'
require_relative '../test/fixture'

describe JoinPointExpresionRegular do

  before :each do
    @clases = Array.new
  end

  it 'debe matchear con una regex un nombre de clase' do
    j = JoinPointNombreClase.new(/Persona/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == true

  end

  it 'debe matchear una regex con un nombre de metodo' do
    j = JoinPointNombreMetodo.new(/algo_malo/)
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == true
  end

end