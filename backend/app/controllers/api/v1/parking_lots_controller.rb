# frozen_string_literal: true

module Api
  module V1
    class ParkingLotsController < ApiController
      before_action :doorkeeper_authorize!
      before_action :current_user
      respond_to    :json
      
      before_action :set_parking_lot, only: %i[show edit update destroy]

      # GET /parking_lots or /parking_lots.json
      def index
        @parking_lots = ParkingLot.all
        render json: @parking_lots
      end

      # GET /parking_lots/1 or /parking_lots/1.json
      def show
        render json: @parking_lot
      end

      # GET /parking_lots/new
      def new
        render json: @parking_lot = ParkingLot.new
      end

      # GET /parking_lots/1/edit
      def edit
        render json: @parking_lot
      end

      # POST /parking_lots or /parking_lots.json
      def create
        @parking_lot = ParkingLot.new(parking_lot_params)

        respond_to do |format|
          if @parking_lot.save
            format.html { redirect_to api_v1_parking_lot_url(@parking_lot), notice: 'ParkingLot was successfully created.' }
            format.json { render :show, status: :created, location: @parking_lot }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @parking_lot.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /parking_lots/1 or /parking_lots/1.json
      def update
        respond_to do |format|
          if @parking_lot.update(parking_lot_params)
            format.html { redirect_to api_v1_parking_lot_url(@parking_lot), notice: 'ParkingLot was successfully updated.' }
            format.json { render :show, status: :ok, location: @parking_lot }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @parking_lot.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /parking_lots/1 or /parking_lots/1.json
      def destroy
        @parking_lot.destroy

        respond_to do |format|
          format.html { redirect_to api_v1_parking_lots_url, notice: 'ParkingLot was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      # POST /api/v1/parking_lots/:parking_lot_id/park
      def park
        if @current_user.nil?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        else
          initialized_info = ParkingManager::InitializeParkingInfo.call({parking_info: parking_params})
          if initialized_info.success?
            result = ParkingManager::ParkVehicle.call(initialized_info.prepared_params)
            if initialized_info.success?
              ticket = result.ticket.attributes
              ticket["ticket_id"] = ticket["id"]
              render json: ticket, status: :ok
            else
              render json: { error: result.message }, status: :unprocessable_entity
            end
          else
            render json: { error: initialized_info.message }, status: :bad_request
          end
        end
      end

       # POST /api/v1/parking_lots/:parking_lot_id/unpark
       def unpark
        if @current_user.nil?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        else
          result = ParkingManager::UnparkVehicle.call({ticket_id: params[:ticket_id]})
          if result.success?
            render json: result.invoice, status: :ok
          else
            render json: { error: result.message }, status: :unprocessable_entity
          end
        end
      end

      # POST /api/v1/parking_lots/:parking_lot_id/create_parking_slots
      def create_parking_slots
        if @current_user.nil?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        else
          result = ParkingManager::CreateParkingSlots.call(upload_parking_slots_params)
          if result.success?
            render json: result.parking_lot, status: :ok
          else
            render json: { error: result.message }, status: :unprocessable_entity
          end
        end
      end

      # POST /api/v1/parking_lots/:parking_lot_id/add_accessways
      def add_accessways
        if @current_user.nil?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        else
          result = ParkingManager::AddAccesswaysWithSlotsDistance.call(upload_accessways_and_distance_params)
          if result.success?
            render json: result.parking_lot, status: :ok
          else
            render json: { error: result.message }, status: :unprocessable_entity
          end
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_parking_lot
        @parking_lot = ParkingLot.find_by_id(params[:id])
        render json: { error: 'ParkingLot not found' }, status: :not_found if @parking_lot.nil?
      end

      # Only allow a list of trusted parameters through.
      def parking_lot_params
        params.require(:parking_lot).permit(:name, :flat_rate, :whole_day_flat_rate)
      end

      def parking_params
        params.require(:parking_info).permit(:type, :plate_no, :parking_lot_id, :accessway_id)
      end

      def upload_parking_slots_params
        params.permit(:parking_lot_id, :parking_slots_file)
      end

      def upload_accessways_and_distance_params
        params.permit(:parking_lot_id, :accessways_and_distance_file)
      end
    end
  end
end
