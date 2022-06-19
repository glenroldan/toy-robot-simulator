require 'tabletop'

describe Tabletop do
  subject(:tabletop) { Tabletop.new(x_unit: 5, y_unit: 5) }

  context '.get_direction' do
    it 'should turn left and right' do
      aggregate_failures 'get_direction to left' do
        expect(tabletop.get_direction('NORTH', :facing_left)).to eq 'WEST'
        expect(tabletop.get_direction('WEST', :facing_left)).to eq 'SOUTH'
        expect(tabletop.get_direction('SOUTH', :facing_left)).to eq 'EAST'
        expect(tabletop.get_direction('EAST', :facing_left)).to eq 'NORTH'
      end

      aggregate_failures 'get_direction to right' do
        expect(tabletop.get_direction('NORTH', :facing_right)).to eq 'EAST'
        expect(tabletop.get_direction('EAST', :facing_right)).to eq 'SOUTH'
        expect(tabletop.get_direction('SOUTH', :facing_right)).to eq 'WEST'
        expect(tabletop.get_direction('WEST', :facing_right)).to eq 'NORTH'
      end

      aggregate_failures 'get nil' do
        expect(tabletop.get_direction('NORTHEASH', :facing_left)).to be_nil
        expect(tabletop.get_direction('NORTHEASH', :facing_right)).to be_nil
      end
    end
  end

  context '.get_coordinates' do
    it 'should get_coordinates' do
      aggregate_failures 'get_coordinates' do
        expect(tabletop.get_coordinates('NORTH', 0, 0)).to eq [0, 1]
        expect(tabletop.get_coordinates('EAST', 0, 0)).to eq [1, 0]
        expect(tabletop.get_coordinates('SOUTH', 0, 0)).to eq [0, 0]
        expect(tabletop.get_coordinates('WEST', 0, 0)).to eq [0, 0]
      end

      aggregate_failures 'no changes with x and y' do
        expect(tabletop.get_coordinates('NORTH', -1, -1)).to eq [-1, -1]
        expect(tabletop.get_coordinates('SOUTHEAST', 0, 0)).to be_nil
      end
    end
  end

  context '.valid_position?' do
    context 'when valid' do
      it 'should return true' do
        expect(tabletop.valid_position?(0, 0, 'NORTH')).to be_truthy
        expect(tabletop.valid_position?(0, 0, 'EAST')).to be_truthy
        expect(tabletop.valid_position?(0, 0, 'SOUTH')).to be_truthy
        expect(tabletop.valid_position?(0, 0, 'WEST')).to be_truthy
      end
    end

    context 'when invalid' do
      it 'should return false' do
        expect(tabletop.valid_position?(-1, -1, 'NORTH')).to be_falsy
        expect(tabletop.valid_position?(0, -1, 'NORTH')).to be_falsy
        expect(tabletop.valid_position?(0, 0, 'NORTHEAST')).to be_falsy
        expect(tabletop.valid_position?(0, 0, 'SOUTHEAST')).to be_falsy
      end
    end
  end
end
