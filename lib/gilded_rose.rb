require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
        when "Aged Brie"
          update_aged_brie_quality(item)
        when "Backstage passes to a TAFKAL80ETC concert"
          update_backstage_passes_quality(item)
        when "Sulfuras, Hand of Ragnaros"; nil
        when "Conjured"
          update_conjured_quality(item)
        else
          update_regular_item_quality(item)
        end
      ensure_quality_is_not_negative(item)
      reduce_sell_in(item)
    end
  end

  private
  def update_aged_brie_quality(item)
    item.quality = item.quality + 1 unless item.quality >= 50
  end

  def update_backstage_passes_quality(item)
    if item.sell_in > 10 && item.quality < 50
      item.quality += 1
    elsif item.sell_in > 6 && item.quality < 50
      item.quality += 2
    elsif item.sell_in > 0 && item.quality < 50
       item.quality += 3
    else item.quality = 0
    end
  end

  def update_conjured_quality(item)
    if item.sell_in > 0
      item.quality -= 2
    else item.quality -= 4
    end
  end

  def update_regular_item_quality(item)
    if item.sell_in > 0
      item.quality -= 1
    else
      item.quality -= 2
    end
  end

  def ensure_quality_is_not_negative(item)
    item.quality = 0  if item.quality < 0
  end

  def reduce_sell_in(item)
    item.sell_in = item.sell_in - 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  end
end
