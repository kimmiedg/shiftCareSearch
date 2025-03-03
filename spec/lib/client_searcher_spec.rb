require 'spec_helper'
require_relative '../../lib/client_searcher'

RSpec.describe ClientSearcher do
  let!(:client_data_file) { 'spec/client_data.json' }
  let!(:client_data) do
    [
      {
        "id": 1,
        "full_name": "John Doe",
        "email": "john.doe@gmail.com"
      },
      {
        "id": 2,
        "full_name": "Jane Smith",
        "email": "jane.smith@yahoo.com"
      },
      {
        "id": 3,
        "full_name": "Alex Johnson",
        "email": "jane.smith@yahoo.com"
      }   
    ]
  end

  describe 'search' do
    context 'when clients matches by full_name' do
      it 'must return matching clients by fullname' do
        res = described_class.new(client_data_file).search('fullname', 'John')
        
        expect(res.size).to eq(2)
        expect(res.map(&:full_name)).to eq(['John Doe', 'Alex Johnson'])
      end
    end
  end

  describe 'duplicate_mails' do
    context 'when clients have duplicate emails' do
      it 'must return duplicated clients' do
        res = described_class.new(client_data_file).duplicates('jane.smith@yahoo.com')

        expect(res.count).to eq(2)
        expect(res.map(&:email)).to eq(['jane.smith@yahoo.com'])
      end
    end
  end
end