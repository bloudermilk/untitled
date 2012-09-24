require "spec_helper"

describe Untitled::Command do
  describe ".run" do
    it "should instantiate the proper command with the arguments specified" do
      new = double
      new.stub(:run)
      Untitled::Command::New.should_receive(:new).with(["foo"]).and_return(new)
      Untitled::Command.run("new", ["foo"])
    end

    it "should run the passed command" do
      new = double
      new.should_receive(:run)
      Untitled::Command::New.stub(:new).and_return(new)
      Untitled::Command.run("new", [])
    end
  end
end
