require 'spec_helper'

describe "Indenting" do
  it "indents the fields of a defrecord" do
    assert_correct_indenting <<-EOF
      defrecord Test,
        field1: nil,
        field2: nil
    EOF
  end
end
