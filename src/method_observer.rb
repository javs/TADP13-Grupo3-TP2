module MethodObserver
  @@aspectos = []
  @@no_procesar = false

  def singleton_method_added(name)
    return if name == :singleton_method_added

    reaplicar_aspecto!(name, self.method(name))
  end

  def method_added(name)
    return if name == :method_added

    reaplicar_aspecto!(name, self.instance_method(name))
  end

  def reaplicar_aspecto!(name, metodo)
    return if @@no_procesar

    @@aspectos.each do |aspecto|
      aspecto[1].modificar(self, metodo) if aspecto[0].filtra_metodo?(self, name)
    end
  end

  def __agregar_aspecto__(point_cut, advice)
    @@aspectos << [point_cut, advice]
  end

  def permitir_aplicar_aspectos_a_nuevos_metodos=(valor)
    @@no_procesar = !valor
  end

  def olvidar_aspectos_conocidos
    @@aspectos = []
  end
end