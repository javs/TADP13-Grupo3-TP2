module Operable
  def no
    OperadorNo.new(self)
  end

  def y(otro)
    OperadorY.new(self, otro)
  end

  def o(otro)
    OperadorO.new(self, otro)
  end
end

class OperadorUnario
  include Operable

  def initialize(op)
    @op = op
  end
end

class OperadorBinario
  include Operable

  def initialize(op_i, op_d)
    @op_i = op_i
    @op_d = op_d
  end
end

class OperadorNo < OperadorUnario
  def filtra_metodo?(a, b)
    ! @op.filtra_metodo?(a, b)
  end
end

class OperadorY < OperadorBinario
  def filtra_metodo?(a, b)
    @op_i.filtra_metodo?(a, b) and @op_d.filtra_metodo?(a, b)
  end
end

class OperadorO < OperadorBinario
  def filtra_metodo?(a, b)
    @op_i.filtra_metodo?(a, b) or @op_d.filtra_metodo?(a, b)
  end
end
