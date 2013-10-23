require 'rspec'

require_relative '../src/cache'
require_relative 'fixture'

describe StatelessCache do

  it 'debe cachear la invocacion de metodos' do
    StatelessCache.advice.modificar(Persona, Persona.instance_method(:devolver_random))
    persona = Persona.new
    StatelessCache.cache.length.should == 0
    cacheado = persona.devolver_random
    StatelessCache.cache.length.should == 1
    cacheado.should == persona.devolver_random
    StatelessCache.cache.length.should == 1
    otraPersona = Persona.new
    cacheado.should == persona.devolver_random
    StatelessCache.cache.length.should == 1
  end

end

describe StatefulCache do

  it 'debe cachear la invocacion con estado' do
    StatefulCache.advice.modificar(Persona,Persona.instance_method(:hacer_algo))
    persona = Persona.new
    persona.nombre = 'Juan'
    persona.apelido = 'Perez'
    otraPersona = Persona.new
    otraPersona.nombre = 'Juan'
    otraPersona.apelido = 'Perez'
    StatefulCache.cache.length.should == 0
    cacheado = persona.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == persona.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == otraPersona.hacer_algo
    StatefulCache.cache.length.should == 1
    otraPersona.nombre = 'Cacho'
    otraPersona.apelido = 'Perez'
    cacheado.should == otraPersona.hacer_algo
    StatefulCache.cache.length.should == 2
  end

end