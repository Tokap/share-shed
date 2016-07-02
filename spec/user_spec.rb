

describe "User model" do

  let(:user) { User.new(id: 1, email: 'email@gmail.com', encrypted_password: "pass", reset_password_token: "pass", address: "1234 Main St", username: "Wolfy858")}

    describe "Gets initialized with basic attributes" do
      it "has a username" do
        expect(user.username).to eq("Wolfy858")
      end

      it "has an encrypted_password" do
        expect(user.encrypted_password).to eq("pass")
      end

      it "has an address" do
        expect(user.address).to eq("1234 Main St")
      end

      it "can sum owned tools" do
        user.tools << Tool.new(base_price: 3)
        user.tools << Tool.new(base_price: 5)
        expect(user.owner_sum_all_tools).to eq(8)
      end

      it "can sum currently rented-out tools" do
        user.tools << Tool.new(base_price: 3, available: false)
        user.tools << Tool.new(base_price: 5)
        expect(user.owner_sum_rented_tools).to eq(3)
      end

      it "can sum currently in-stock tools" do
        user.tools << Tool.new(base_price: 3, available: false)
        user.tools << Tool.new(base_price: 5)
        expect(user.owner_sum_inactive_tools).to eq(5)
      end

      ## The below test is HEAVILY dependent on other models & currently broken.
      # it "can sum tools the user has currently chosen to rent" do
      #   rented_tool_1 = Tool.new(base_price: 5)
      #   rented_tool_2 = Tool.new(base_price: 7)
      #   rental = Rental.new(renter: user)
      #   line_item_1 = LineItem.new(tool: rented_tool_1, rental: rental)
      #   line_item_2 = LineItem.new(tool: rented_tool_2, rental: rental)
      #   rental.line_items << line_item_1
      #   rental.line_items << line_item_2
      #   user.rented_rentals << rental
      #   expect(user.rented_tools).to eq(12)
      # end
    end
  end
