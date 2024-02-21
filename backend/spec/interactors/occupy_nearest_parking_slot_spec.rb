require 'rails_helper'

RSpec.describe ParkingManager::OccupyNearestParkingSlot do
  let!(:parking_lot) { FactoryBot.create(:parking_lot) } # This creates data like accessways parking slots and distances
  let!(:accessways) { parking_lot.accessways }

  let!(:full_slot_parking_lot) { FactoryBot.create(:full_slot_parking_lot) } # This creates data like accessways with full parking slots and distances
  let!(:full_slot_accessways) { full_slot_parking_lot.accessways }

  describe ".call" do
    context "when small vehicle is parking" do
      let!(:small_vehicle) { FactoryBot.create(:small_vehicle) }
      let!(:slot_types_sm_vehicle) { ParkingManager::VehicleParkingSlotTypes.call({vehicle: small_vehicle}) }

      context "when parking slots are available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: parking_lot, accessway: accessways[0], types: slot_types_sm_vehicle.types) }
        
        it "succeeds" do
          expect(context).to be_a_success
        end

        it "provides the parking_slot" do
          expect(context).to respond_to(:parking_slot)
          expect(slot_types_sm_vehicle.types).to include(context.parking_slot.class.name)
        end
      end

      context "when parking slots are not available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: full_slot_parking_lot, accessway: full_slot_accessways[0], types: slot_types_sm_vehicle.types) }
        
        it "fails" do
          expect(context).not_to be_a_success
          
        end

        it "provides the error message" do
          expect(context).to respond_to(:message)
          expect(context.message).to eq("No available parking slot")
        end
      end
      
    end

    context "when medium vehicle is parking" do
      let!(:medium_vehicle) { FactoryBot.create(:medium_vehicle) }
      let!(:slot_types_md_vehicle) { ParkingManager::VehicleParkingSlotTypes.call({vehicle: medium_vehicle}) }

      context "when parking slots are available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: parking_lot, accessway: accessways[0], types: slot_types_md_vehicle.types) }
        
        it "succeeds" do
          expect(context).to be_a_success
        end

        it "provides the parking_slot" do
          expect(context).to respond_to(:parking_slot)
          expect(slot_types_md_vehicle.types).to include(context.parking_slot.class.name)
        end
      end

      context "when parking slots are not available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: full_slot_parking_lot, accessway: full_slot_accessways[0], types: slot_types_md_vehicle.types) }
        
        it "fails" do
          expect(context).not_to be_a_success
          
        end

        it "provides the error message" do
          expect(context).to respond_to(:message)
          expect(context.message).to eq("No available parking slot")
        end
      end
      
    end

    context "when large vehicle is parking" do
      let!(:large_vehicle) { FactoryBot.create(:large_vehicle) }
      let!(:slot_types_lg_vehicle) { ParkingManager::VehicleParkingSlotTypes.call({vehicle: large_vehicle}) }

      context "when parking slots are available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: parking_lot, accessway: accessways[0], types: slot_types_lg_vehicle.types) }
        
        it "succeeds" do
          expect(context).to be_a_success
        end

        it "provides the parking_slot" do
          expect(context).to respond_to(:parking_slot)
          expect(slot_types_lg_vehicle.types).to include(context.parking_slot.class.name)
        end
      end

      context "when parking slots are not available" do
        subject(:context) { ParkingManager::OccupyNearestParkingSlot.call(parking_lot: full_slot_parking_lot, accessway: full_slot_accessways[0], types: slot_types_lg_vehicle.types) }
        
        it "fails" do
          expect(context).not_to be_a_success
          
        end

        it "provides the error message" do
          expect(context).to respond_to(:message)
          expect(context.message).to eq("No available parking slot")
        end
      end
      
    end
  end
end
