module MethodObserver
  @@aspectos = []
  @@no_procesar = false

  def singleton_method_added(name)
    return if name == :singleton_method_added

    reaplicar_aspecto(name, self.method(name))
  end

  def method_added(name)
    return if name == :method_added

    reaplicar_aspecto(name, self.instance_method(name))
  end

  def reaplicar_aspecto(name, metodo)
    return if @@no_procesar

    @@aspectos.each do |aspecto|
      if aspecto[0].filtra_metodo?(self, name)
        @@no_procesar = true
        aspecto[1].modificar(self, metodo)
        @@no_procesar = false
      end
    end
  end

  def __agregar_aspecto__(point_cut, advice)
    @@aspectos << [point_cut, advice]
  end
end