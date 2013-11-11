class Checker
  attr_reader :corrected, :original

  def initialize text
    @original = text.strip
  end

  def total_count
    regexes.map{ |k, v| send("#{k}_count") }.sum
  end

  def total_percent
    total_count.to_f / original.size.to_f * 100
  end

  [:space, :ellipsis, :z, :s, :h, :k, :capitals].each do |check|
    define_method "#{check}_count" do
      @original.scan(regexes[check]).size
    end

    define_method "#{check}_percent" do
      send("#{check}_count").to_f / original.size.to_f * 100
    end
  end

  def correct_text &block
    block = -> (c){ c } unless block
    corrected = @original
    { space: ' ', ellipsis: '…', z: 's', s: 'z', h: 'k', k: 'h' }.each do |key, value|
      corrected = corrected.gsub(regexes[key], block.call(value))
    end
    corrected.gsub(regexes[:capitals]){ |s| block.call(s.upcase) }
  end

  private
  def regexes
    {
      space: /  +/,
      ellipsis: /\.{2,}/,
      z: /(?<=\s)z(?=\s[cčfhkpsšt])|^z(?=\s[cčfhkpsšt])/i,
      s: /(?<=\s)s(?=\s[^cčfhkpsšt])|^s(?=\s[^cčfhkpsšt])/i,
      k: /(?<=\s)k(?=\s[kg])|^k(?=\s[kg])/i,
      h: /(?<=\s)h(?=\s[^kg])|^h(?=\s[^kg])/i,
      capitals: /(?<=[.?!] )([a-zčšž])|^([a-zčšž])/
    }
  end
end
