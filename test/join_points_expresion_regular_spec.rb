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

    j = JoinPointNombreClase.new(/^Persona$/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true

  end

  it 'debe matchear una regex con un nombre de metodo' do
    j = JoinPointNombreMetodo.new(/algo_malo/)
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == true

    j = JoinPointNombreMetodo.new(/^hacer_[a-z]{4}$/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == true

    j = JoinPointNombreMetodo.new(/v\w+/)
    j.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
  end

  it 'debe rechazar una regex con un nombre de clase' do
    j = JoinPointNombreClase.new(/Persona/)
    j.filtra_metodo?(String, String.instance_method(:to_s)).should == false
    j.filtra_metodo?(Method, Method.instance_method(:clone)).should == false
    j.filtra_metodo?(Array, Array.instance_method(:each)).should == false

    j = JoinPointNombreClase.new(/^Persona$/)
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
  end

  it 'debe rechazar una regex con un nombre de metodo' do
    j = JoinPointNombreMetodo.new(/algo_malo/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false

    j = JoinPointNombreMetodo.new(/^hacer_[a-z]{4}$/)
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo_de_una_forma)).should == false

    j = JoinPointNombreMetodo.new(/v\w+/)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
  end

end