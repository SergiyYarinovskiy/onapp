describe Generator do
  describe '#ticket_random_code' do
    it 'returns random code' do
      expect(Generator.ticket_random_code) =~ code_matcher
    end
  end
end
