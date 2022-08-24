require 'rails_helper'

Rspec.describe Route, type: :model do
  describe "relationships" do
    xit { should belong_to(:crag) }
  end
end