require 'rspec'

require_relative '../src/join_point'
require_relative 'fixture'

describe JoinPointAridadMetodo do

  it 'debe soportar metodos con aridad especifica' do
    j = JoinPointAridadMetodo.new(2)
    j.filtra_metodo?(String, String.method(:alias_method)).should == true

    j = JoinPointAridadMetodo.new(1)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo_de_una_forma)).should == true

    j = JoinPointAridadMetodo.new(0)
    j.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
  end

  it 'debe rechazar metodos que no tengan un aridad especifica' do
    j = JoinPointAridadMetodo.new(2)
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo)).should == false

    j = JoinPointAridadMetodo.new(0)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo_de_una_forma)).should == false
  end

end