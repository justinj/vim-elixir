require 'spec_helper'

describe "Indenting" do
  context "documentation" do
    it "with end keyword" do
      assert_correct_indenting <<-EOF
        defmodule Test do
          @doc """
          end
          """
        end
      EOF
    end

    it "something" do
      assert_correct_indenting <<-EOF
        defmodule HashDict do
          @moduledoc """
          A key-value store.

          The `HashDict` is meant to work well with both small and
          """
        end
      EOF
    end
  end
end
