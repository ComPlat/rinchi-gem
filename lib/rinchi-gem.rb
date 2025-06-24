# frozen_string_literal: true

begin
  require_relative "../ext/rinchi-gem/rinchi"
rescue LoadError
  require "rinchi"
end
require "rinchi-gem/version"
