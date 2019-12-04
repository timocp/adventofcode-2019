class Day4Test < Minitest::Test
  def test_valid
    d = Day4.new
    assert d.valid?("111111")
    refute d.valid?("223450")
    refute d.valid?("123789")
  end
end
