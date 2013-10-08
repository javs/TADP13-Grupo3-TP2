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

    point_cut =
        JoinPointAridadMetodo.new(0).o(
            JoinPointNombreClase.new(/^Persona/))

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
    point_cut.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == true
    point_cut.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == true

    point_cut.filtra_metodo?(Persona, OtraPersona.instance_method(:hacer_algo_de_una_forma)).should == true
    point_cut.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo_de_una_forma)).should == false
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:hacer_algo_de_una_forma)).should == false


    point_cut =
        JoinPointClasesEspecificas.new(Linyera,Persona).o(
            JoinPointAridadMetodo.new(1)).o(
            JoinPointNombreMetodo.new(/de_/))

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
    point_cut.filtra_metodo?(Persona, Persona.method(:de_clase)).should == true
    point_cut.filtra_metodo?(OtraPersona, OtraPersona.method(:de_clase)).should == true
    point_cut.filtra_metodo?(String, String.instance_method(:concat)).should == true

    point_cut.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
    point_cut.filtra_metodo?(OtraPersona, PersonaMala.instance_method(:hacer_algo)).should == false
    point_cut.filtra_metodo?(String, String.instance_method(:to_s)).should == false

  end

  it 'debe permitir operar con el y' do
    point_cut =
        JoinPointClasesEspecificas.new(Linyera).y(
            JoinPointNombreMetodo.new(/v\w{4}/))

    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == true
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:hacer_algo)).should == false
    point_cut.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false

    point_cut =
        JoinPointJerarquiaDeClase.new(Persona).y(
            JoinPointAridadMetodo.new(1))

    point_cut.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo_de_una_forma)).should == true
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:hacer_algo_de_una_forma)).should == true
    point_cut.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == false
    point_cut.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == false
    point_cut.filtra_metodo?(String, String.instance_method(:concat)).should == false

    point_cut =
        JoinPointClasesEspecificas.new(Persona,Linyera).y(
          JoinPointNombreMetodo.new(/^hacer/)).y(
            JoinPointAridadMetodo.new(0))

    point_cut.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo_de_una_forma)).should == false
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:hacer_algo_de_una_forma)).should == false

    point_cut.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:hacer_algo)).should == true
    point_cut.filtra_metodo?(OtraPersona, OtraPersona.instance_method(:hacer_algo)).should == false

    point_cut.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo_malo)).should == false
    point_cut.filtra_metodo?(Linyera, Linyera.instance_method(:vagar)).should == false
    point_cut.filtra_metodo?(String, String.instance_method(:concat)).should == false
  end

end