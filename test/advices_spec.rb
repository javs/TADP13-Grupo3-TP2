require 'rspec'

require_relative '../src/advice'
require_relative 'fixture'

describe Advice do

  it 'debe hacer algo' do

    AdviceAntes.new(Proc.new { |forma| puts "LOGEANDO ANTES DE LA FORMA: #{forma}" }).modificar(Persona, Persona.instance_method(:hacer_algo_de_una_forma))
    Persona.new.hacer_algo_de_una_forma("LOCA")
    puts "---------------------------------------------------------"

    AdviceDespues.new(Proc.new { puts "VENDER LO ROBADO" }).modificar(PersonaMala, PersonaMala.instance_method(:robar))
    PersonaMala.new.robar("string")
    puts "---------------------------------------------------------"

    AdviceError.new(Proc.new { puts "ERROR AL COMPRAR FERRARI" }).modificar(Linyera, Linyera.instance_method(:comprar_ferrari))
    Linyera.new.comprar_ferrari
    puts "---------------------------------------------------------"

    AdviceEnLugarDe.new(Proc.new { puts "EN LUGAR DE ROBAR, COMPRA" }).modificar(PersonaMala, PersonaMala.instance_method(:robar))
    PersonaMala.new.robar("string")
    puts "---------------------------------------------------------"

    Advice.new(Proc.new { puts "ANTES DE VAGAR" }, Proc.new { puts "DESPUES DE VAGAR" }, Proc.new { puts "ERROR AL VAGAR" }, Proc.new { puts "YA NO VAGA" }).modificar(Linyera, Linyera.instance_method(:vagar))
    Linyera.new.vagar

  end

end