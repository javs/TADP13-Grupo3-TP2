require 'rspec'

require_relative '../src/join_point'
require_relative 'fixture'

describe JoinPointClasesEspecificas do

  it 'debe soportar una clase especifica' do
    j = JoinPointClasesEspecificas.new(String)

    j.filtra_metodo?(String, String.instance_method(:to_s)).should == true
  end

  it 'debe rechazar metodos de clases que no se le hayan pasado' do
    j = JoinPointClasesEspecificas.new(Persona)

    j.filtra_metodo?(PersonaMala, PersonaMala.instance_method(:hacer_algo)).should == false
  end

  it 'debe soportar multiples clases' do
    j = JoinPointClasesEspecificas.new(String, Object)

    j.filtra_metodo?(String, String.instance_method(:to_s)).should == true
    j.filtra_metodo?(Object, String.instance_method(:to_s)).should == true

    j.filtra_metodo?(Class, String.instance_method(:to_s)).should == false
  end

  it 'debe aceptar distintos tipos de metodos' do
    j = JoinPointClasesEspecificas.new(Persona)

    j.filtra_metodo?(Persona, Persona.instance_method(:hacer_algo)).should == true
    j.filtra_metodo?(Persona, Persona.method(:de_clase)).should == true
  end

  it 'debe aceptar metodos heredados' do
    j = JoinPointClasesEspecificas.new(Persona)

    j.filtra_metodo?(Persona, Persona.instance_method(:to_s)).should == true
  end
end