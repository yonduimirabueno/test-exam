# frozen_string_literal: true

#  id         :bigint           not null, primary key
#  plate_no   :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null

FactoryBot.define do
    factory :vehicle, class: Vehicle do
      plate_no { Faker::Lorem.characters(number: 6)  }
    end
    factory :small_vehicle, parent: :vehicle, class: Vehicles::SmallVehicle do
      plate_no { Faker::Lorem.characters(number: 6)  }
    end
    
    factory :medium_vehicle, parent: :vehicle, class: Vehicles::MediumVehicle do
      plate_no { Faker::Lorem.characters(number: 6)  }
    end

    factory :large_vehicle, parent: :vehicle, class: Vehicles::LargeVehicle do
      plate_no { Faker::Lorem.characters(number: 6)  }
    end
end
