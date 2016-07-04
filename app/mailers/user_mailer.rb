class UserMailer < ApplicationMailer
  default from: "Shed@Sharing.com"

  def schedule_tool_pickup(rental)
    @rental = rental
    @renter = @rental.renter

    mail(to: @renter.email, subject: "Your rental has been confirmed")
  end
end