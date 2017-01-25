require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
        when "Aged Brie"
          item.quality = item.quality + 1 unless item.quality >= 50
        when "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in > 10 && item.quality < 50
            item.quality += 1
          elsif item.sell_in > 6 && item.quality < 50
            item.quality += 2
          elsif item.sell_in > 0 && item.quality < 50
             item.quality += 3
          else item.quality = 0
          end
        when "Sulfuras, Hand of Ragnaros"; nil
        when "Conjured"
          if item.sell_in > 0
            item.quality -= 2
          else item.quality -= 4
          end
        else
          if item.sell_in > 0
            item.quality -= 1
          else
            item.quality -= 2
          end
        end

      ensure_quality_is_not_negative(item)

      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
    end
  end

  private

  def ensure_quality_is_not_negative(item)
    item.quality = 0  if item.quality < 0
  end
end
