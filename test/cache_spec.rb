require 'rspec'

require_relative '../src/cache'
require_relative 'fixture'

describe StatelessCache do

  it 'debe cachear la invocacion de metodos' do
    StatelessCache.advice.modificar(Persona, Persona.instance_method(:devolver_random))
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

describe StatefulCache do

  it 'debe cachear la invocacion con estado' do
    StatefulCache.advice.modificar(Persona,Persona.instance_method(:devolver_random))
    persona = Persona.new
    persona.nombre = 'Juan'
    persona.apelido = 'Perez'
    otraPersona = Persona.new
    otraPersona.nombre = 'Juan'
    otraPersona.apelido = 'Perez'
    cacheado = persona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == otraPersona.devolver_random
    cacheado.should == persona.devolver_random
    cacheado.should == otraPersona.devolver_random
    otraPersona.nombre = 'Cacho'
    otraPersona.apelido = 'Perez'
    cacheado.should == otraPersona.devolver_random
  end

end