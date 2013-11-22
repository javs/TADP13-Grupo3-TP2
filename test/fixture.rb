class Persona

  attr_accessor :nombre, :apelido, :edad

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

class Linyera < Persona
  def vagar
    puts 'zzzz'
  end

  def comprar_ferrari
    raise 'No puede comprar ferrari'
  end

end