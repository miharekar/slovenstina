require 'spec_helper'

describe Checker do
  it 'strips double spaces' do
    checker = Checker.new('This is a  double  space  test.')
    expect(checker.corrected).to eq 'This is a double space test.'
    expect(checker.space_count).to eq 3
  end

  it 'corrects s placing' do
    checker = Checker.new('S konjem ali z konjem?')
    expect(checker.corrected).to eq 'S konjem ali s konjem?'
    expect(checker.z_count).to eq 1
  end

  it 'corrects z placing' do
    checker = Checker.new('Kaj pa ti s dežnikom?')
    expect(checker.corrected).to eq 'Kaj pa ti z dežnikom?'
    expect(checker.s_count).to eq 1
  end

  it 'corrects k placing' do
    checker = Checker.new('Včeraj sem šel k kovaču.')
    expect(checker.corrected).to eq 'Včeraj sem šel h kovaču.'
    expect(checker.k_count).to eq 1
  end

  it 'corrects h placing' do
    checker = Checker.new('Pojdi h okulistu!')
    expect(checker.corrected).to eq 'Pojdi k okulistu!'
    expect(checker.h_count).to eq 1
  end
end
