class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0
    self.each_with_index do | el, i|
      if el.is_a?(Fixnum)
        hash_value += (el.hash * (i + 1).hash)
      elsif el.is_a?(String)
        value = el.chars.map(&:chr).inject(:+)
        hash_value += (value.hash * (i + 1).hash)
      elsif el.is_a?(Array)
        hash_value += el.hash
      end
    end
    hash_value
  end
end

class String
  def hash
    hash_value = 0
    self.chars.each_with_index do |c, i|
      hash_value += (c.ord.hash * (i + 1).hash)
    end
    hash_value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    order_agnostic = self.to_a.sort
    order_agnostic.hash
  end
end
