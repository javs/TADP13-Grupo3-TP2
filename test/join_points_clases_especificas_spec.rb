require 'rspec'

require_relative '../src/join_point'
require_relative '../test/fixture'

describe JoinPointClasesEspecificas do

  it 'soportar una clase especifica' do
    j = JoinPointClasesEspecificas.new(String)

    j.filtra_metodo?(String, :to_s).should == true
  end

  it 'debe rechazar metodos de clases que no se le hayan pasado' do
    j = JoinPointClasesEspecificas.new(Persona)

    j.filtra_metodo?(PersonaMala, :hacer_algo).should == false
  end

  it 'debe soportar multiples clases' do
    j = JoinPointClasesEspecificas.new(String, Object)

    j.filtra_metodo?(String, :to_s).should == true
    j.filtra_metodo?(Object, :to_s).should == true

    j.filtra_metodo?(Class, :to_s).should == false
  end
end