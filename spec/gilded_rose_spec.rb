require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end
    context "regular items" do

      it "quality decreases by one" do
        items = [Item.new("foo", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "quality decreases by two after sell_in date" do
        items = [Item.new("foo", 0, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "quality never negative" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it "sell-in decreases by one" do
        items = [Item.new("foo", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
      end
    end

    context "Aged Brie" do
      it "sell_in decreases by one" do
        items = [Item.new("Aged Brie", 2, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 1
      end

      it "quality increases by one" do
        items = [Item.new("Aged Brie", 2, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 3
      end

      it "sell-in decreases by one" do
        items = [Item.new("Aged Brie", 2, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 1
      end

      it "has maximum quality of 50" do
        items = [Item.new("Aged Brie", 2, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do

      it "sell_in decreases by 1" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 11
      end

      it "quality increases by 1 if more than 10 days to the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 3
      end

      it "quality increases by 2 if between 6 and 10 days to the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 4
      end

      it "quality increases by 3 if 5 or less days to the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 5
      end

      it "quality drops to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it "quality never negative" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "quality never decreases" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 2
      end

      it "sell-in never decreases" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 2)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 2
      end
    end

    context "Conjured items" do
      it "quality decreases by 2 if before sell_in date" do
          items = [Item.new("Conjured", 2, 2)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 0
      end

      it "quality decreases by 4 if after sell_in date" do
          items = [Item.new("Conjured", 0, 5)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 1
      end

      it "quality never negative" do
        items = [Item.new("Conjured", 1, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end
  end

end
