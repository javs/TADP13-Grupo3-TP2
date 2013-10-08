require 'rspec'
require_relative '../src/join_point'
require_relative 'fixture'

describe Operable do

  it 'debe permitir operar con el no' do
    point_cut = JoinPointClasesEspecificas.new(Linyera).no

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == false

    point_cut = point_cut.no

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
  end

  it 'debe permitir operar con el o' do
    point_cut =
        JoinPointClasesEspecificas.new(Linyera).o(
        JoinPointClasesEspecificas.new(PersonaMala))

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
    point_cut.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == true
  end
end