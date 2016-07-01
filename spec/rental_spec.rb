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

    describe "Is able to check own status" do
      it "can check pending status" do
        rental.status = "pending"
        expect(rental.pending?).to eq(true)

        rental.status = "returned"
        expect(rental.pending?).to eq(false)
      end

      it "can check scheduled status" do
        rental.status = "scheduled"
        expect(rental.scheduled?).to eq(true)

        rental.status = "returned"
        expect(rental.scheduled?).to eq(false)
      end

      it "can check in_progress status" do
        rental.status = "in progress"
        expect(rental.in_progress?).to eq(true)

        rental.status = "returned"
        expect(rental.in_progress?).to eq(false)
      end

      it "can check returned status" do
        rental.status = "returned"
        expect(rental.returned?).to eq(true)

        rental.status = "pending"
        expect(rental.returned?).to eq(false)
      end

      it "can check closed status" do
        rental.status = "closed"
        expect(rental.closed?).to eq(true)

        rental.status = "pending"
        expect(rental.closed?).to eq(false)
      end
    end

    describe "It holds extended association information" do
      it "can check its related line items" do
        rented_tool_1 = Tool.new(base_price: 5)
        rented_tool_2 = Tool.new(base_price: 7)
        li1 = LineItem.new(tool: rented_tool_1)
        li2 = LineItem.new(tool: rented_tool_2)
        rental.line_items << li1
        rental.line_items << li2
        expect(rental.line_items).to eq([li1, li2])
      end
    end
  end
