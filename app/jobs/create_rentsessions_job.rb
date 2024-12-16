class CreateRentsessionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    print "CreateRentsessionsJob"
  end
end
