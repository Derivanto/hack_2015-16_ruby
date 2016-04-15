class Roman
  def self.const_missing(r_num)
    r_num.to_s.chars.each do |char|
      super unless "IVXLCDM".include? char
    end
    r_num = r_num.to_s.chars
    num, index = 0, 0
    while index < r_num.length
      case r_num[index]
      when 'I' then
        case r_num[index+1]
        when 'V' then num += 4; index +=1
        when 'X' then num += 9; index += 1
        else num += 1
        end
      when 'V' then num += 5
      when 'X' then
        case r_num[index+1]
        when 'L' then num += 40; index += 1
        when 'C' then num += 90; index += 1
        else num += 10
        end
      when 'L' then num += 50
      when 'C' then
        case r_num[index+1]
        when 'D' then num += 400; index += 1
        when 'M' then num += 900; index += 1
        else num += 100
        end
      when 'D' then num += 500
      when 'M' then num += 1000
      else super
      end
      index += 1
    end
    puts "#{num}"
  end
end

Roman::I
Roman::IV
Roman::IX
Roman::X
Roman::XIII
Roman::XLV
Roman::XCII
Roman::LIV
Roman::XXXI
Roman::MCMIV
Roman::MCMLIV
Roman::MCMXC
Roman::MMXIV
Roman::MMXIV