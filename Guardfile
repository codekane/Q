guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"

  watch(%r{^spec/specs/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { "spec" }
end
