require 'rspec'

require_relative '../src/join_point'
require_relative 'fixture'

describe JoinPointMetodosAccessors do

  it 'debe soportar un metodo accessor' do
    j = JoinPointMetodosAccessors.new(Persona)
    j.filtra_metodo?(Persona,Persona.instance_method(:nombre=)).should == true
    j.filtra_metodo?(Persona,Persona.instance_method(:nombre)).should == true
  end

  it 'debe rechazar un metodo no accessor' do
    j = JoinPointMetodosAccessors.new(String)
    j.filtra_metodo?(String,String.instance_method(:to_s)).should == false
    j.filtra_metodo?(Persona,Persona.instance_method(:hacer_algo)).should == false
  end
end
