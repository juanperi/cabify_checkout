require 'dry-configurable'
require 'model/in_memory_repository'
require 'model/item'

class Checkout
  extend Dry::Configurable
  setting :repository

  def initialize
    @items = []
  end

  def scan(item)
    @items << repository.find(item)
  end

  def total
    @items.reduce(0) { |partial, item| partial + item.price }
  end

  private

  def repository
    Checkout.config.repository
  end
end