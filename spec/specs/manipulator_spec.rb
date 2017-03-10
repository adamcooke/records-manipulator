require 'spec_helper'

describe "Records Manipulator" do

  it "should not break existing behaviour" do
    user = User.where(:first_name => "Rachel").first
    expect(user).to be_a(User)
    expect(user.manipulated?).to be false
  end

  it "should manipulate from the root model" do
    users = User.manipulate { |r| r.each(&:manipulate) }.where(:first_name => ['Joe', 'Alicia']).all
    expect(users.map(&:manipulated?)).to all be true
  end

  it "should manipulate once scoped" do
    users = User.where(:first_name => ['Alicia', 'Rachel']).manipulate { |r| r.each(&:manipulate) }.all
    expect(users.size).to eq 2
    expect(users.map(&:manipulated?)).to all be true
  end

end
