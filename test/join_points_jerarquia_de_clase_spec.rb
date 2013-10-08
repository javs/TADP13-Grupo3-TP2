require 'rspec'

require_relative '../src/join_point'
require_relative 'fixture'

describe JoinPointJerarquiaDeClase do

  it 'debe soportar metodos que pertenezcan a la jerarquia de una clase' do
    j = JoinPointJerarquiaDeClase.new(Persona)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true

    j = JoinPointJerarquiaDeClase.new(Object)
    j.filtra_metodo?(String, String.instance_method(:to_s)).should == true
    j.filtra_metodo?(Method, Method.instance_method(:clone)).should == true
    j.filtra_metodo?(Array, Array.instance_method(:each)).should == true
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true

  end

  it 'debe rechazar metodos que no pertenezcan a una jerarquia de una clase' do
    j = JoinPointJerarquiaDeClase.new(Linyera)
    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false

    j = JoinPointJerarquiaDeClase.new(String)
    j.filtra_metodo?(Object, Object.instance_method(:methods)).should == false
    j.filtra_metodo?(Method, Method.instance_method(:clone)).should == false
    j.filtra_metodo?(Array, Array.instance_method(:each)).should == false

  end

end