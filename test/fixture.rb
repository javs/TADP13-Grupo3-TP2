class Persona

  def self.de_clase
    puts 'Este es un metodo de clase definido en Persona'
  end

  def hacer_algo
    puts 'Haciendo algo'
  end

end

class PersonaMala < Persona

  def hacer_algo_malo
    puts 'Algo malo'
  end

end

class OtraPersona < Persona

  def hacer_algo
    puts 'Haciendo algo como otra persona'
  end

end