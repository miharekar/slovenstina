require 'rails_helper'

describe CheckerHelper do
  describe '.percentage_td' do
    it 'shows success when percentage is 0' do
      expect(percentage_td(0)).to eq '<td class="success">0.000%</td>'
    end

    it 'shows warning when percentage is between 0 and 1' do
      expect(percentage_td(0.5)).to eq '<td class="warning">0.500%</td>'
    end

    it 'shows danger when percentage is larger than 1' do
      expect(percentage_td(2)).to eq '<td class="danger">2.000%</td>'
    end
  end
end
