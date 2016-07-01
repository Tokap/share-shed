

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
    end
  end
