require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Trucker builds ActiveRecord queries in Rails 3 syntax" do
  before(:each) do
    @model = Trucker::Model.new("muppets")
  end

  it "handles an unmodified .all()" do
    @model.construct_query.should == "LegacyMuppet.all"
  end

  it "handles limits" do
    @model.options[:limit] = 20
    @model.limit.should == ".limit(20)"
    @model.construct_query.should == "LegacyMuppet.limit(20)"
  end

  it "handles ordering" do
    @model.options[:offset] = 20
    @model.offset.should == ".offset(20)"
    @model.construct_query.should == "LegacyMuppet.offset(20)"
  end

  it "handles where()" do
    @model.options[:where] = ":username => 'fred'"
    @model.construct_query.should == "LegacyMuppet.where(:username => 'fred')"
  end

  it "handles find_by_sql()" do
    @model.options[:sql] = "id is not null"
    @model.construct_query.should == "LegacyMuppet.find_by_sql('id is not null')"
  end

  it "actually chains limit, order and where" # untested, but currently worky

  it "shows correct count with sql option" # doesn't work, uses same count as all

  it "shows correct migration message with sql option" # doesn't work, says "Migrating all"
end

describe Trucker::Migration do
  describe "#new" do
    it "handles sql" # DOES NOT WORK, FIX ME DAVE
  end
end

describe "Trucker can handle underscores" do
  Trucker::Model.new("muppets").base.should == "LegacyMuppet"
  Trucker::Model.new("muppet_balls").base.should == "LegacyMuppetBall"
end

