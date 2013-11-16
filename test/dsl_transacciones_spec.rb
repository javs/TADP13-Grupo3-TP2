require_relative '../src/dsl'
require_relative 'fixture'

describe Aspecto do

  after(:each) do
    Class.class_variable_set(:@@aspectos,[])
    load 'fixture.rb'
  end

  it 'debe aplicarle transacciones a un objeto dado' do

    persona = Persona.new
    otra_persona = Persona.new

    Aspecto.aplicar do

      hacer transaccionable el objeto persona

    end

    persona.respond_to?(:commit).should == true
    persona.respond_to?(:rollback).should == true

    otra_persona.respond_to?(:commit).should == false
    otra_persona.respond_to?(:rollback).should == false

  end

end