describe "Rental model" do

  let(:rental) { Rental.new(id: 1, renter_id: 5, status: "pending", owner_id: 1, checkout_date: "2016-07-01 04:50:46", return_date: "2016-07-01 04:50:46", rental_price: 10)}

    describe "Gets initialized with basic attributes" do
      it "has an ID" do
        expect(rental.id).to eq(1)
      end

      it "has a rental price" do
        expect(rental.rental_price).to eq(10)
      end

      it "has a status" do
        expect(rental.status).to eq("pending")
      end

      it "has an owner id" do
        expect(rental.owner_id).to eq(1)
      end

      it "has a checkout date" do
        expect(rental.checkout_date).to eq("2016-07-01 04:50:46")
      end

      it "has a return date" do
        expect(rental.return_date).to eq("2016-07-01 04:50:46")
      end
    end
  end
