require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para los diferentes tipos de advice' do

  after(:each) do
    Class.olvidar_aspectos_conocidos
    load 'fixture.rb'
  end

  it 'debe hacer algo despues' do

    Aspecto.aplicar do

     si coincide el nombre de la clase con /^Linyera$/
     entonces ejecutar despues del original el proc { 'despues de vagar' }

    end

    linyera = Linyera.new
    linyera.vagar.should == 'despues de vagar'
    expect { linyera.comprar_ferrari }.to raise_error(Exception)

  end

  it 'debe hacer algo antes' do

    Aspecto.aplicar do

      si coincide el nombre de la clase con /^Linyera$/
      entonces ejecutar antes del original el proc { |clase, simbolo, simbolo_original, instancia, *args|
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
      entonces ejecutar reemplazando el original con el proc { 'en lugar de vagar' }

    end

    Linyera.new.vagar.should == 'en lugar de vagar'

  end

  it 'debe hacer algo si hay error' do

    Aspecto.aplicar do

      si coincide el nombre del metodo con /^comprar_ferrari$/
      entonces ejecutar en caso de error el proc { 'no puede comprar ferrari' }

    end

    Linyera.new.comprar_ferrari.should == 'no puede comprar ferrari'

  end

end