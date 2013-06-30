require 'spec_helper'

describe "Indenting" do
  context "documentation" do
    it "with end keyword" do
      input = <<-EOF
        defmodule Test do
          @doc """
          end
          """
        end
      EOF
      expected = input
      assert_indents_to input, expected
    end

    it "does not modify indentation in docstrings" do
      input = <<-EOF
        defmodule SomeModule do
          @moduledoc """
          A cool module

          # Examples
             iex> 1 + 2
             3
          """
      EOF
      expected = input
      assert_indents_to input, expected
    end
  end
end
