RSpec.describe Smush do
  require "smush"

  let!(:unsmushed) {
    {
      name: "John Doe",
      friends: [
        {
          name: "Jane Deer",
          age: 23
        },
        {
          name: "Bob Smith",
          age: 32
        }
      ],
      favorite_food: "Chicken Cobb Salad"
    }
  }

  let!(:smushed) {
    [
      {
        key: [:name],
        value: "John Doe"
      },
      {
        key: [:friends, 0, :name],
        value: "Jane Deer"
      },
      {
        key: [:friends, 0, :age],
        value: 23
      },
      {
        key: [:friends, 1, :name],
        value: "Bob Smith"
      },
      {
        key: [:friends, 1, :age],
        value: 32
      },
      {
        key: [:favorite_food],
        value: "Chicken Cobb Salad"
      }
    ]
  }

  it "Smushes a hash" do
    val = Smush.smush(unsmushed)
    expect(val).not_to be_nil
    expect(val.size).to eq(6)
    expect(val).to include(*smushed)
  end

  it "Unsmushes an array" do
    val = Smush.unsmush(smushed)
    expect(val).not_to be_nil
    expect(val).to eq(unsmushed)
  end
end
