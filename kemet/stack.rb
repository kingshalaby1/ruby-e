
require 'concurrent'
require "ostruct"
class Stack

  include Concurrent::Async
  def initialize()
    @state = Array.new
    @cache = OpenStruct.new("max" => 0, "count" => 0, "sum" => 0)
  end
  def push(element)
    raise ArgumentError.new(" only positive integers allowed") unless element.is_a?(Integer) && element > 0
    @state.push(element)
    async.reconcile(:push, element)
  end

  def pop()
    element = @state.pop
    async.reconcile(:push, element)
    element
  end

  def max()
    @cache.max
  end

  def reconcile(operation, el)
    case operation
    when :push
      max = @cache.max < el ? el : @cache.max
      count = @cache.count + 1
      sum = @cache.sum + el
      @cache = OpenStruct.new("max" => max, "count" => count, "sum" => sum)
    when :pop
      max = @cache.max == el ? @state.max() : @cache.max
      count = @cache.max - 1
      sum = @cache.sum - el
      @cache = OpenStruct.new("max" => max, "count" => count, "sum" => sum)

    end

  end

end

class Extras < Stack
  def mean()
    @cache.sum / @cache.count
  end

end
=begin
pro: it's fast...
  metadata is cached and reconciled after every write operation

con: eventually consistent
  reconciliation happens asynchronously
  we can apply some lock on cached stats, but then we will loose the performance advantage
=end
