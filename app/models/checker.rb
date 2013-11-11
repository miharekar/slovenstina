class Checker
  attr_reader :corrected, :original, :highlighted

  CHECKS = [:space, :ellipsis, :z, :s, :h, :k, :capitals]
  SPACE_REGEX = /  +/
  ELLIPSIS_REGEX = /\.{2,}/
  Z_REGEX = /(?<=\s)z(?=\s[cčfhkpsšt])|^z(?=\s[cčfhkpsšt])/i
  S_REGEX = /(?<=\s)s(?=\s[^cčfhkpsšt])|^s(?=\s[^cčfhkpsšt])/i
  K_REGEX = /(?<=\s)k(?=\s[kg])|^k(?=\s[kg])/i
  H_REGEX = /(?<=\s)h(?=\s[^kg])|^h(?=\s[^kg])/i
  CAPITALS_REGEX = /(?<=[.?!] )([a-zčšž])|^([a-zčšž])/

  def initialize text
    @original = text.strip
    correct_text
    highlight_text
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
    @corrected = @original
      .gsub(SPACE_REGEX, ' ')
      .gsub(ELLIPSIS_REGEX, '…')
      .gsub(Z_REGEX, 's')
      .gsub(S_REGEX, 'z')
      .gsub(H_REGEX, 'k')
      .gsub(K_REGEX, 'h')
      .gsub(CAPITALS_REGEX){ |s| s.upcase }
  end

  def highlight_text
    @highlighted = @original
      .gsub(SPACE_REGEX, '<mark> </mark>')
      .gsub(ELLIPSIS_REGEX, '<mark>…</mark>')
      .gsub(Z_REGEX, '<mark>s</mark>')
      .gsub(S_REGEX, '<mark>z</mark>')
      .gsub(H_REGEX, '<mark>k</mark>')
      .gsub(K_REGEX, '<mark>h</mark>')
      .gsub(CAPITALS_REGEX){ |s| "<mark>#{s.upcase}</mark>" }
      .gsub(/(?:\n\r?|\r\n?)/, '<br>')
  end
end
