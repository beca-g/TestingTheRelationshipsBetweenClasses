require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  let(:new_diary) { SecretDiary.new(diary) }
  let(:diary) { double :diary }
  context "when locked" do
    it "refuses to be read" do
      expect(new_diary.read).to eq "Go away!"
    end
  
    it "refuses to be written" do
      expect(new_diary.write("new_message")).to eq "Go away!"
    end
  end

  context "when unlocked" do
    it "gets read" do
      allow(diary).to receive(:write).and_return "new message"
      allow(diary).to receive(:read).and_return "new message"
      new_diary.unlock
      new_diary.write("new message")
      expect(new_diary.read).to eq "new message"
    end

    it "gets written" do
      allow(diary).to receive(:write).and_return "new message"
      new_diary.unlock
      expect(new_diary.write("new message")).to be nil
    end
  end
end
