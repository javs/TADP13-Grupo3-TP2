require 'test/unit'
require '../src/join_point'
require '../test/clases_a_aspectar'

class AspectosTest < Test::Unit::TestCase

  attr_accessor :clases

  def setup
    @clases = Array.new
  end

  def test_por_regex_en_nombre_clase
    joinpoint = JoinPointNombreClase.new /Persona/
    clases.push(Persona)
    clases.push(OtraPersona)
    clases.push(PersonaMala)
    assert_son_las_mismas_clases(clases, joinpoint)
  end

  def test_por_regex_en_nombre_metodo
    joinpoint = JoinPointNombreMetodo.new /algo_malo/
    clases.push(PersonaMala)
    assert_son_las_mismas_clases(clases, joinpoint)
  end

  def test_por_clases_especificas
    joinpoint = JoinPointClasesEspecificas.new(Persona,OtraPersona)
    clases.push(OtraPersona, Persona)
    assert_son_las_mismas_clases(clases, joinpoint)
  end

  def assert_son_las_mismas_clases(clases, joinpoint)
    assert_equal(clases.sort { |a,b| a.name.downcase <=> b.name.downcase }, joinpoint.clases.sort { |a,b| a.name.downcase <=> b.name.downcase })
  end

end