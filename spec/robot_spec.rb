require "robot"
require "tabletop"

describe Robot do
  let(:units) { { x: 5, y: 5 } }
  let(:tabletop) { Tabletop.new(x_unit: units[:x], y_unit: units[:y]) }

  subject(:robot) { Robot.new }

  context '.place' do
    context 'when valid' do
      it 'should assign x_position, y_position, and direction' do
        expect(robot.place(tabletop, 0, 0, 'NORTH')).to be_nil
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 0
        expect(robot.direction).to eq 'NORTH'
      end
    end

    context 'when invalid' do
      context 'with not valid x_position' do
        it 'should not assign x_position, y_position, and direction' do
          expect(robot.place(tabletop, units[:x] + 1, 0, 'NORTH')).to be_nil
          expect(robot.x_position).to be_nil
          expect(robot.y_position).to be_nil
          expect(robot.direction).to be_nil
        end
      end

      context 'with not valid y_position' do
        it 'should not assign x_position, y_position, and direction' do
          expect(robot.place(tabletop, 0, units[:y] + 1, 'NORTH')).to be_nil
          expect(robot.x_position).to be_nil
          expect(robot.y_position).to be_nil
          expect(robot.direction).to be_nil
        end
      end

      context 'with not valid direction' do
        it 'should not assign x_position, y_position, and direction' do
          expect(robot.place(tabletop, 0, 0, 'NORTHEAST')).to be_nil
          expect(robot.x_position).to be_nil
          expect(robot.y_position).to be_nil
          expect(robot.direction).to be_nil
        end
      end
    end
  end

  context '.move' do
    context 'when valid' do
      before { robot.place(tabletop, 0, 0, 'NORTH') }

      it 'should assign x_position, y_position, and direction' do
        expect(robot.move).to be_nil
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 1
        expect(robot.direction).to eq 'NORTH'
      end
    end

    context 'when invalid' do
      it 'should not assign x_position, y_position, and direction' do
        expect(robot.move).to be_nil
        expect(robot.x_position).to be_nil
        expect(robot.y_position).to be_nil
        expect(robot.direction).to be_nil
      end
    end
  end

  context '.left' do
    context 'when valid' do
      before { robot.place(tabletop, 0, 0, 'NORTH') }

      it 'should assign x_position, y_position, and direction' do
        expect(robot.left).to be_nil
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 0
        expect(robot.direction).to eq 'WEST'
      end
    end

    context 'when invalid' do
      it 'should not assign x_position, y_position, and direction' do
        expect(robot.left).to be_nil
        expect(robot.x_position).to be_nil
        expect(robot.y_position).to be_nil
        expect(robot.direction).to be_nil
      end
    end
  end

  context '.right' do
    context 'when valid' do
      before { robot.place(tabletop, 0, 0, 'NORTH') }

      it 'should assign x_position, y_position, and direction' do
        expect(robot.right).to be_nil
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 0
        expect(robot.direction).to eq 'EAST'
      end
    end

    context 'when invalid' do
      it 'should not assign x_position, y_position, and direction' do
        expect(robot.right).to be_nil
        expect(robot.x_position).to be_nil
        expect(robot.y_position).to be_nil
        expect(robot.direction).to be_nil
      end
    end
  end

  context '.report' do
    context 'when valid' do
      before { robot.place(tabletop, 0, 0, 'NORTH') }

      it 'should not assign x_position, y_position, and direction, and get output' do
        expect(robot.report).to eq "Output: 0,0,NORTH"
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 0
        expect(robot.direction).to eq 'NORTH'
      end
    end

    context 'when invalid' do
      it 'should not assign x_position, y_position, and direction' do
        expect(robot.report).to be_nil
        expect(robot.x_position).to be_nil
        expect(robot.y_position).to be_nil
        expect(robot.direction).to be_nil
      end
    end
  end
end
