describe "Tool model" do

  let(:tool) { Tool.new(id: 1, base_price: 5, available: true, owner_id: 1, description: "It's a hammer...", model_number: "1234HM")}

    describe "Gets initialized with basic attributes" do
      it "has an ID" do
        expect(tool.id).to eq(1)
      end

      it "has a base price" do
        expect(tool.base_price).to eq(5)
      end

      it "has an availability" do
        expect(tool.available).to eq(true)
      end

      it "has an owner id" do
        expect(tool.owner_id).to eq(1)
      end

      it "has a description" do
        expect(tool.description).to eq("It's a hammer...")
      end

      it "has a model number" do
        expect(tool.model_number).to eq("1234HM")
      end
    end
  end
