class UserMailer < ApplicationMailer
  default from: "admin@ShedSharing.com"

  def schedule_tool_pickup(rental)
    @rental = rental
    @renter = @rental.renter

    mail(to: @renter.email, subject: "Your rental has been confirmed")
  end

  def alert_owner_of_new_request(rental)
    @rental = rental

    mail(to: @rental.owner.email, subject: "#{@rental.renter.username} wants to rent your tools")
  end
end
