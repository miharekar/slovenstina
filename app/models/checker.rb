class Checker
  attr_reader :corrected, :original

  CHECKS = [:space, :z, :s, :h, :k, :capitals]
  SPACE_REGEX = /  +/
  Z_REGEX = /(?<=\s)z(?=\s[cčfhkpsšt])/i
  S_REGEX = /(?<=\s)s(?=\s[^cčfhkpsšt])/i
  K_REGEX = /(?<=\s)k(?=\s[kg])/i
  H_REGEX = /(?<=\s)h(?=\s[^kg])/i
  CAPITALS_REGEX = /(?<=[.?!] )([a-zčšž])|^([a-zčšž])/

  def initialize text
    @original = text.strip
    correct_text
  end

  def total_count
    CHECKS.map{ |c| send("#{c}_count") }.sum
  end

  def total_percent
    total_count.to_f / original.size.to_f * 100
  end

  CHECKS.each do |check|
    define_method "#{check}_count" do
      regex = self.class.const_get("#{check.upcase}_REGEX")
      @original.scan(regex).size
    end

    define_method "#{check}_percent" do
      send("#{check}_count").to_f / original.size.to_f * 100
    end
  end

  private
  def correct_text
    @corrected = @original.gsub(SPACE_REGEX, ' ')
    .gsub(Z_REGEX, 's')
    .gsub(S_REGEX, 'z')
    .gsub(H_REGEX, 'k')
    .gsub(K_REGEX, 'h')
    .gsub(CAPITALS_REGEX){ |s| s.upcase }
  end
end
