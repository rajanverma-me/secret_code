class ClearUserWorker
  include Sidekiq::Worker

  def perform(id)
    sc = SecretCode.find(id)
  	sc.temp_user = nil
  	sc.save!
  end
end
