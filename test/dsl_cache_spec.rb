require 'rspec'

require_relative '../src/cache'
require_relative '../src/join_point'
require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL CACHES' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
    StatefulCache.clear_cache
    StatelessCache.clear_cache
  end

  it 'debe cachear la invocacion de metodos' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /devolver_random/
      cachear sin usar estado

    end

    persona = Persona.new
    StatelessCache.cache.length.should == 0
    cacheado = persona.devolver_random
    StatelessCache.cache.length.should == 1
    cacheado.should == persona.devolver_random
    StatelessCache.cache.length.should == 1
    otraPersona = Persona.new
    cacheado.should == otraPersona.devolver_random
    StatelessCache.cache.length.should == 1
  end

  it 'debe cachear la invocacion con estado' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /hacer_algo/
      cachear usando estado

    end

    una_persona = Persona.new
    una_persona.nombre = 'Juan'
    una_persona.edad = 7
    otra_persona = Persona.new
    otra_persona.nombre = 'Juan'
    otra_persona.edad = 7
    StatefulCache.cache.length.should == 0
    cacheado = una_persona.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == una_persona.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == otra_persona.hacer_algo
    StatefulCache.cache.length.should == 1
    otra_persona.nombre = 'Cacho'
    otra_persona.edad = 8
    cacheado.should == otra_persona.hacer_algo
    StatefulCache.cache.length.should == 2

  end

end