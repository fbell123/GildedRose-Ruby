describe GildedRose do

  before(:each) do
    @brie = [Item.new('Aged Brie', 40, 15)]
    @rose1 = GildedRose.new(@brie)
    @tasty = [Item.new('Something tasty', 15, 20)]
    @rose2 = GildedRose.new(@tasty)
    @sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 5, 10)]
    @rose3 = GildedRose.new(@sulfuras)
    @backstage = [Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 25)]
    @rose4 = GildedRose.new(@backstage)
    @conjured = [Item.new('Conjured', 10, 20)]
    @rose5 = GildedRose.new(@conjured)
  end

  describe "#update_quality" do
    it "does not change the name" do
      @rose1.update_quality()
      expect(@brie[0].name).to eq "Aged Brie"
      @rose2.update_quality()
      expect(@tasty[0].name).to eq "Something tasty"
    end
    it 'decreases the item quality after each update' do
      @rose2.update_quality()
      expect(@tasty[0].quality).to eq 19
    end
    it 'decreases the item sell in after each update' do
      @rose2.update_quality()
      expect(@tasty[0].sell_in).to eq 14
    end
    it 'cannot decrease item quality futher than 0' do
      20.times{@rose2.update_quality()}
      expect(@tasty[0].quality).to eq 0
    end
    it 'item decreases quality at double speed after sell in drops below 0' do
      16.times{@rose2.update_quality()}
      expect(@tasty[0].quality).to eq 3
    end
    it 'has a maximum quality of 50' do
      39.times{@rose1.update_quality()}
      expect(@brie[0].quality).to eq 50
    end

    context 'Sulfuras tests' do
      it 'does not change the sell in after update' do
        @rose3.update_quality()
        expect(@sulfuras[0].sell_in).to eq 5
      end
      it 'does not change the quality after update' do
        @rose3.update_quality()
        expect(@sulfuras[0].quality).to eq 10
      end
    end

    context 'Aged Brie tests' do
      it 'increases the quality after an update' do
        @rose1.update_quality()
        expect(@brie[0].quality).to eq 16
      end
      it 'decreases the sell in after an update' do
        @rose1.update_quality()
        expect(@brie[0].sell_in).to eq 39
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'increases the quality by 1 after an update if the sell in date is greater than 10' do
        @rose4.update_quality()
        expect(@backstage[0].quality).to eq 26
      end
      it 'increases the quality by 2 after an update if the sell in date is less than 10 but greater than 5' do
        3.times{@rose4.update_quality()}
        expect(@backstage[0].quality).to eq 29
      end
      it 'increases the quality by 3 after an update if the sell in date is less than 5 but greater than 0' do
        8.times{@rose4.update_quality()}
        expect(@backstage[0].quality).to eq 40
      end
      it 'quality drops to 0 when sell by drops to 0' do
        13.times{@rose4.update_quality()}
        expect(@backstage[0].quality).to eq 0
      end
    end

    context 'Conjured items' do
      it 'quality decreases at double the rate of other items' do
        @rose5.update_quality();
        expect(@conjured[0].quality).to eq 18
      end
      it 'ages at a normal rate' do
        @rose5.update_quality();
        expect(@conjured[0].sell_in).to eq 9
      end
    end

  end

end
