require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  # i'm not validating Devise, just the new fields
  it { should respond_to(:name) }
end
