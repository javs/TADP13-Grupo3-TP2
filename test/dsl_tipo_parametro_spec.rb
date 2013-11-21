require_relative '../src/dsl'
require_relative 'fixture'

describe 'DSL para tipo de parametros' do

  class Persona

    attr_accessor :nombre, :apelido

    def self.de_clase
      puts 'Este es un metodo de clase definido en Persona'
    end

    def hacer_algo
      puts 'Haciendo algo'
    end

    def hacer_algo_de_una_forma(forma)
      puts "Haciendo algo de la forma: #{forma}"
    end

    def devolver_random
      rand(1000000)
    end
  end

  class PersonaMala < Persona

    def hacer_algo_malo
      puts 'Algo malo'
    end

    def robar(objectos={})
      puts 'estoy robando objetos'
    end

  end

  class OtraPersona < Persona

    def hacer_algo
      puts 'Haciendo algo como otra persona'
    end

    def donar_plata(platita=0)
      puts 'estoy donando plata'
    end

  end

  it 'debe reemplazar si un metodo tiene parametros opcionales' do

    Aspecto.aplicar do

      si el tipo de parametro es :opt
      entonces ejecutar reemplazando el original con el proc { 'Inspector de billeteras' }

    end

    OtraPersona.new.donar_plata(100).should == 'Inspector de billeteras'
    Persona.new.hacer_algo.should == 'Haciendo algo'

    Aspecto.aplicar do

      si el tipo de parametro es :req
      entonces ejecutar reemplazando el original con el proc { 'No hagas las cosas como te dicen' }

    end
    Persona.new.hacer_algo_de_una_forma('Max Power Style').should == 'No hagas las cosas como te dicen'
    OtraPersona.new.donar_plata(90).should_not == 'No hagas las cosas como te dicen'


  end


end