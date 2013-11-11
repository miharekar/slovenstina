class Checker
  attr_reader :corrected, :original, :highlighted

  CHECKS = [:space, :ellipsis, :z, :s, :h, :k, :capitals]
  REPLACEMENTS = { space: ' ', ellipsis: '…', z: 's', s: 'z', h: 'k', k: 'h' }
  SPACE_REGEX = /  +/
  ELLIPSIS_REGEX = /\.{2,}/
  Z_REGEX = /(?<=\s)z(?=\s[cčfhkpsšt])|^z(?=\s[cčfhkpsšt])/i
  S_REGEX = /(?<=\s)s(?=\s[^cčfhkpsšt])|^s(?=\s[^cčfhkpsšt])/i
  K_REGEX = /(?<=\s)k(?=\s[kg])|^k(?=\s[kg])/i
  H_REGEX = /(?<=\s)h(?=\s[^kg])|^h(?=\s[^kg])/i
  CAPITALS_REGEX = /(?<=[.?!] )([a-zčšž])|^([a-zčšž])/

  def initialize text
    @original = text.strip
    @corrected = correct_text
    @highlighted = correct_text '<mark>', '</mark>'
  end

  def total_count
    CHECKS.map{ |c| send("#{c}_count") }.sum
  end

  def total_percent
    total_count.to_f / original.size.to_f * 100
  end

  CHECKS.each do |check|
    define_method "#{check}_count" do
      @original.scan(regex_from_symbol(check)).size
    end

    define_method "#{check}_percent" do
      send("#{check}_count").to_f / original.size.to_f * 100
    end
  end

  private
  def regex_from_symbol symbol
    self.class.const_get("#{symbol.upcase}_REGEX")
  end

  def correct_text before = '', after = ''
    corrected = @original
    REPLACEMENTS.each do |key, value|
      corrected = corrected.gsub(regex_from_symbol(key), "#{before}#{value}#{after}")
    end
    corrected.gsub(CAPITALS_REGEX){ |s| "#{before}#{s.upcase}#{after}" }
  end
end
