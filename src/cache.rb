require_relative '../src/advice'

class AbstractCache

  @@cache = Array.new

  def self.cache
    @@cache
  end

  def self.advice
    cachearODevolverCacheado = Proc.new {
        |clase, simbolo, simboloOriginal, instancia, *args|
      invocacion = InvocacionCacheada.new(clase, simbolo, args)
      invocacion_cacheada = CacheSinEstado.cache.detect {|cached| cached.eql? invocacion}
      unless invocacion_cacheada.nil?
        next invocacion_cacheada.resultado
      else
        resultado = instancia.send simboloOriginal, *args
        invocacion.resultado = resultado
        CacheSinEstado.cache << invocacion
      end
      resultado
    }
    AdviceEnLugarDe.new(cachearODevolverCacheado)
  end



  InvocacionCacheada = Struct.new(:clase, :simbolo, :args, :resultado) do
    def eql?(other)
      (clase.eql? other.clase) and (simbolo.eql? other.simbolo) and (args.eql? other.args)
    end
  end

end

class CacheSinEstado < AbstractCache

  def eql?(oneInvocation,anotherInvocation)

  end

end

class CacheConEstado < AbstractCache

  def eql?(oneInvocation,anotherInvocation)

  end

end