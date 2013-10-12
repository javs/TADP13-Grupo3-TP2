require 'rspec'

require_relative '../src/join_point'
require_relative 'fixture'

describe JoinPointMetodosEspecificos do

  it 'debe encontrar metodo especifico' do
    j = JoinPointMetodosEspecificos.new(Persona.instance_method(:hacer_algo),Persona.instance_method(:hacer_algo_de_una_forma))
    j.filtra_metodo?(Persona,Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(Persona,Persona.instance_method(:hacer_algo_de_una_forma)).should == true
  end

  it 'debe rechazar un metodo que no pertenezca' do
    j = JoinPointMetodosEspecificos.new(String.instance_method(:equal?),String.instance_method(:to_s))
    j.filtra_metodo?(Persona,Persona.instance_method(:hacer_algo)).should == false
    j.filtra_metodo?(String,String.instance_method(:sub)).should == false
  end

end
