require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if num_buckets == count
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end


  private

  def [](key)
    hashed_key = key.hash
    @store[hashed_key % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store = Array.new(num_buckets * 2) { Array.new }
    (0..num_buckets - 1).each do |bucket_i|
      until self[bucket_i].empty?
        num = self[bucket_i].last
        store[num % (num_buckets * 2)] << self[bucket_i].pop
      end
    end
    @store = store
  end
end
