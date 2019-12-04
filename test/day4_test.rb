class Day4Test < Minitest::Test
  def test_valid
    d = Day4.new
    assert d.valid?("111111")
    refute d.valid?("223450")
    refute d.valid?("123789")
    assert d.valid?("123444")

    refute d.valid?("111111", strict: true)
    assert d.valid?("112233", strict: true)
    refute d.valid?("123444", strict: true)
    assert d.valid?("111122", strict: true)
    refute d.valid?("123333", strict: true)
  end
end
