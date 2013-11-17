require_relative '../src/dsl'
require_relative 'fixture'

describe Aspecto do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe hacer algo despues' do

    Aspecto.aplicar do

     si coincide el nombre de la clase con /^Linyera$/
     entonces ejecutar despues del original proc { 'despues de vagar' }

    end

    linyera = Linyera.new
    linyera.vagar.should == 'despues de vagar'
    expect { linyera.comprar_ferrari }.to raise_error(Exception)

  end

  it 'debe hacer algo antes' do

    Aspecto.aplicar do

      si coincide el nombre de la clase con /^Linyera$/
      entonces ejecutar antes del original proc { |clase, simbolo, simbolo_original, instancia, *args|
        instancia.instance_variable_set(:@variable,1)
      }

    end

    linyera = Linyera.new
    expect { linyera.comprar_ferrari }.to raise_error(Exception)
    linyera.instance_variable_get(:@variable).should == 1

  end

  it 'debe hacer algo en lugar de' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /^vagar$/
      entonces ejecutar reemplazando el original con proc { 'en lugar de vagar' }

    end

    Linyera.new.vagar.should == 'en lugar de vagar'

  end

  it 'debe hacer algo si hay error' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /^comprar_ferrari$/
      entonces ejecutar en caso de error proc { 'no puede comprar ferrari' }

    end

    Linyera.new.comprar_ferrari.should == 'no puede comprar ferrari'

  end

  it 'sacarme cuando este terminado el DSL' do
    true.should == false
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