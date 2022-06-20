require 'simulator'

describe Simulator do
  context '.execute' do
    subject(:simulator) { Simulator.new }

    context 'when valid' do
      context 'with REPORT' do
        it 'should accepts command and returns nil' do
          expect(simulator.execute('REPORT')).to be_nil
        end
      end

      context 'with PLACE' do
        it 'should accepts command and returns nil' do
          expect(simulator.execute('PLACE 7,7,NORTH')).to be_nil
        end
      end

      context 'with LEFT' do
        it 'should accepts command and returns nil' do
          expect(simulator.execute('LEFT')).to be_nil
        end
      end

      context 'with RIGHT' do
        it 'should accepts command and returns nil' do
          expect(simulator.execute('RIGHT')).to be_nil
        end
      end

      context 'with MOVE' do
        it 'should accepts command and returns nil' do
          expect(simulator.execute('MOVE')).to be_nil
        end
      end

      it 'should ignores out of bounds x, y and/or f' do
        expect(simulator.execute('PLACE -1,-1,NORTH')).to be_nil
        expect(simulator.execute('PLACE 1,1,NORTHEAST')).to be_nil
      end
    end

    context 'when invalid' do
      context 'with invalid command' do
        it 'should returns an error message' do
          expect(simulator.execute('PUT')).to eq 'Invalid command, valid commands are ["PLACE", "LEFT", "RIGHT", "MOVE", "REPORT"]'
        end
      end

      context 'with invalid PLACE arguments' do
        it 'should returns an error message' do
          expect(simulator.execute('PLACE')).to eq 'Invalid PLACE arguments, requires X and Y position and facing direction'
        end
      end
    end
  end

  context '.start' do\
    subject(:simulator) { Simulator.new(input: commands) }

    let(:mock_stdout) { mock_stdout = StringIO.new }

    before do
      $stdout = mock_stdout
      simulator.start
    end

    context 'with other commands before EXIT' do
      let(:commands) { ['PLACE 1,2,NORTH', 'REPORT', 'EXIT'] }

      it 'should not be empty after EXIT' do
        expect(mock_stdout.string).to eq "Toy Robot Simulator!\ntype EXIT to quit\nOutput: 1,2,NORTH\n"
      end
    end

    context 'with EXIT command only' do
      let(:commands) { ['EXIT'] }

      it 'should be empty after EXIT' do
        expect(mock_stdout.string).to eq "Toy Robot Simulator!\ntype EXIT to quit\n"
      end
    end
  end
end
