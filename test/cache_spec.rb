require 'rspec'

require_relative '../src/cache'
require_relative '../src/join_point'
require_relative '../src/motor_de_aspectos'

describe StatelessCache do

  after(:each) do
    StatefulCache.clear_cache
    StatelessCache.clear_cache
  end

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

    @motor = MotorDeAspectos.new
    @point_cut = JoinPointClasesEspecificas.new(Perro)
  end

  after do
    Object.send :remove_const, :Perro
    @motor = nil
    @point_cut = nil
  end

  it 'debe cachear la invocacion de metodos' do
    @motor.aspecto(@point_cut.y(JoinPointNombreMetodo.new(/devolver_random/)),
                   StatelessCache.advice)
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

  after(:each) do
    StatefulCache.clear_cache
    StatelessCache.clear_cache
  end

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

    @motor = MotorDeAspectos.new
    @point_cut = JoinPointClasesEspecificas.new(Perro)
  end

  after do
    Object.send :remove_const, :Perro
    @motor = nil
    @point_cut = nil
  end

  it 'debe cachear la invocacion con estado' do
    @motor.aspecto(@point_cut.y(JoinPointNombreMetodo.new(/hacer_algo/)),
                   StatefulCache.advice)
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