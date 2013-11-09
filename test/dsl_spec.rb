require 'rspec'
require_relative '../src/dsl'
require_relative 'fixture'

describe Configuracion do

  it 'debe hacer algo despues' do

    Configuracion.aspecto do

     si coincide el nombre de la clase con /^Linyera$/
     y coincide el nombre del metodo con /^vagar$/
     entonces ejecutar despues del original Proc.new { puts 'despues de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo antes' do

    Configuracion.aspecto do

      si coincide el nombre de la clase con /^Linyera$/
      y coincide el nombre del metodo con /^vagar$/
      entonces ejecutar antes del original Proc.new { puts 'antes de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo en lugar de' do

    Configuracion.aspecto do

      si coincide el nombre de la clase con /^Linyera$/
      y coincide el nombre del metodo con /^vagar$/
      entonces ejecutar reemplazando el original con Proc.new { puts 'en lugar de vagar' }

    end
    puts '--------------------------------'
    Linyera.new.vagar
    puts '--------------------------------'
  end

  it 'debe hacer algo si hay error' do

    Configuracion.aspecto do

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

end