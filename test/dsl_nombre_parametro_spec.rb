require_relative '../src/dsl'
require_relative 'fixture'

describe JoinPointNombreParametros do

  after(:each) do
    Class.class_variable_set(:@@aspectos,[])
    load 'fixture.rb'
  end

  before(:each) do
    class NombreParametro

      attr_accessor :una_variable

      def initialize(un_numero)
        @una_variable = un_numero
      end

      def metodo_con_parametro_de_nombre(un_nombre)
        @una_variable
      end

      def +(un_numero)
        @una_variable = @una_variable + un_numero
        @una_variable
      end

    end
  end

  it 'debe hacer algo despues si coincide el nombre del parametro' do

    Aspecto.aplicar do

     si coincide el nombre del parametro con /^un_nombre$/
     entonces ejecutar despues del original Proc.new { |clase, simbolo, simbolo_original, instancia, *args|
        instancia + 4
     }

     si coincide el nombre de la clase con /^NombreParametro$/
     y coincide el nombre del metodo con /^metodo_con_parametro_de_nombre$/
     entonces ejecutar despues del original Proc.new { |clase, simbolo, simbolo_original, instancia, *args|
       instancia + 3
     }

    end

    objeto = NombreParametro.new(3)
    objeto.una_variable.should == 3
    objeto.metodo_con_parametro_de_nombre(:no_me_importa).should == 10
    objeto.una_variable.should == 10

  end

  it 'no debe hacer algo despues si no coincide el nombre del parametro' do

    Aspecto.aplicar do

      si coincide el nombre del parametro con /^un_nomb$/
      entonces ejecutar despues del original Proc.new { |clase, simbolo, simbolo_original, instancia, *args|
        instancia + 4
      }

    end

    objeto = NombreParametro.new(3)
    objeto.una_variable.should == 3
    objeto.metodo_con_parametro_de_nombre(4).should == 3
    objeto.una_variable.should == 3

  end

end