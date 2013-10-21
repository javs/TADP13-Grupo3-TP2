require 'rspec'

require_relative '../src/cache'
require_relative 'fixture'

describe CacheSinEstado do

  it 'debe cachear la invocacion de metodos' do
    CacheSinEstado.advice.modificar(Persona, Persona.instance_method(:devolver_random))
    persona = Persona.new
    cacheado = persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == persona.devolver_random
  end

end