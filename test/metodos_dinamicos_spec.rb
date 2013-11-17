require 'rspec'

require_relative '../src/motor_de_aspectos'

describe 'Metodos agregados dinamicamente' do

  before(:each) do
    class UnaClaseSinMetodos

    end

    @motor = MotorDeAspectos.new
    @point_cut = JoinPointClasesEspecificas.new(UnaClaseSinMetodos)

    @advice = AdviceEnLugarDe.new(proc { 1969 })
  end

  it 'debe agregar advices a metodos de instancia nuevos' do
    @motor.aspecto(@point_cut, @advice)

    class UnaClaseSinMetodos
      def ahora_tiene_un_metodo
        'que devuelve algo que no es 1969'
      end
    end

    UnaClaseSinMetodos.new.ahora_tiene_un_metodo.should == 1969
  end

  after(:each) do
    Object.send :remove_const, :UnaClaseSinMetodos

    @motor = nil
    @point_cut = nil
    @advice = nil
  end
end