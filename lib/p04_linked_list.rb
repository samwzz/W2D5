class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev.next = @next
    @next.prev = prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @sentinel = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next.nil? && @sentinel.prev.nil?
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if empty?
      @sentinel.next = new_link
      new_link.prev = @sentinel
    else
      last.next = new_link
      new_link.prev = last
    end
    @sentinel.prev = new_link
    new_link.next = @sentinel
  end

  def update(key, val)
    each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    each do |link|
      link.remove if link.key == key
    end
  end

  def each(&prc)
    finder = first
    until finder == @sentinel || finder.nil?
      prc.call(finder)
      finder = finder.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
