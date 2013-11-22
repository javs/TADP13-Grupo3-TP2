class Persona

  attr_accessor :nombre, :apelido, :edad

  def self.de_clase
    puts 'Este es un metodo de clase definido en Persona'
  end

  def hacer_algo
    puts 'Haciendo algo'
  end

  def devolver(objeto)
    objeto
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

class Linyera < Persona
  def vagar
    puts 'zzzz'
  end

  def comprar_ferrari
    raise 'No puede comprar ferrari'
  end

end

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