require 'rspec'

require_relative '../src/cache'

describe StatelessCache do

  before do
    class Perro

      attr_accessor :nombre, :edad

      def self.de_clase
        puts 'Este es un metodo de clase definido en Perro'
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
  end

  after do
    Object.send :remove_const, :Perro
  end

  it 'debe cachear la invocacion de metodos' do
    StatelessCache.advice.modificar(Perro, Perro.instance_method(:devolver_random))
    perro = Perro.new
    StatelessCache.cache.length.should == 0
    cacheado = perro.devolver_random
    StatelessCache.cache.length.should == 1
    cacheado.should == perro.devolver_random
    StatelessCache.cache.length.should == 1
    otroPerro = Perro.new
    cacheado.should == otroPerro.devolver_random
    StatelessCache.cache.length.should == 1
  end

end

describe StatefulCache do

  before do
    class Perro

      attr_accessor :nombre, :edad

      def self.de_clase
        puts 'Este es un metodo de clase definido en Perro'
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
  end

  after do
    Object.send :remove_const, :Perro
  end

  it 'debe cachear la invocacion con estado' do
    StatefulCache.advice.modificar(Perro,Perro.instance_method(:hacer_algo))
    perro = Perro.new
    perro.nombre = 'Juan'
    perro.edad = 7
    otro_perro = Perro.new
    otro_perro.nombre = 'Juan'
    otro_perro.edad = 7
    StatefulCache.cache.length.should == 0
    cacheado = perro.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == perro.hacer_algo
    StatefulCache.cache.length.should == 1
    cacheado.should == otro_perro.hacer_algo
    StatefulCache.cache.length.should == 1
    otro_perro.nombre = 'Cacho'
    otro_perro.edad = 8
    cacheado.should == otro_perro.hacer_algo
    StatefulCache.cache.length.should == 2
  end

end