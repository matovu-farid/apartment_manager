# frozen_string_literal: true

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rspec_rails'
end
