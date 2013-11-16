require 'rspec'
require_relative '../src/dsl'
require_relative 'fixture'

describe Aspecto do

  after(:each) do
    Class.class_variable_set(:@@aspectos,[])
    load 'fixture.rb'
  end

  it 'debe hacer algo despues' do

    Aspecto.aplicar do

     si coincide el nombre de la clase con /^Linyera$/
     y coincide el nombre del metodo con /^vagar$/
     entonces ejecutar despues del original Proc.new { puts 'despues de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo antes' do

    Aspecto.aplicar do

      si coincide el nombre de la clase con /^Linyera$/
      y coincide el nombre del metodo con /^vagar$/
      entonces ejecutar antes del original Proc.new { puts 'antes de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo en lugar de' do

    Aspecto.aplicar do

      si coincide el nombre de la clase con /^Linyera$/
      y coincide el nombre del metodo con /^vagar$/
      entonces ejecutar reemplazando el original con Proc.new { puts 'en lugar de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo si hay error' do

    Aspecto.aplicar do

      si coincide el nombre de la clase con /^Linyera$/
      y coincide el nombre del metodo con /^c$/
      o coincide el nombre del metodo con /^comprar_ferrari$/
      entonces ejecutar en caso de error Proc.new { puts 'no puede comprar ferrari' }

    end
    puts '--------------------------------'
    Linyera.new.comprar_ferrari
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe ejecutar si pertenece a persona' do

    Aspecto.aplicar do

      si pertenece a la jerarquia de Persona
      entonces ejecutar despues del original Proc.new { puts 'hago algo, luego existo' }

    end
    puts '--------------------------------'
    Linyera.new.hacer_algo
    puts '--------------------------------'
  end

  it 'sacarme' do
    # si clase /algo/                   # JoinPointNombreClase y especifica (llama a uno u otro dependiendo de si la clase es class u otra cosa)
    # si metodo /algo/                  # JoinPointNombreMetodo y especifico (similar al anterior)
    # si aridad 1                       # aridad
    # si jerarquia Persona              # jerarquia
    # si parametros opcionales          # tipo de parametros (:opt)
    # si parametros requeridos          # tipo de parametros (:req)
    # si accessors de Persona           # accessors
    # si parametro /algo/               # nombre de parametro
  end

end