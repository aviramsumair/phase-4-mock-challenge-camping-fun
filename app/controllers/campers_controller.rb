class CampersController < ApplicationController
    
    #GET /campers
    def index
        campers = Camper.all
        render json: campers, each_serializer: CamperNoActivitiesSerializer
    end

    #GET /campers/:id
    def show
        camper = Camper.find_by(id: params[:id])
        if camper
            #render json: camper.to_json(except: [:created_at, :updated_at], include: [activities: {except: [:created_at, :updated_at]}]) 
            render json: camper
        else
            render json: {"error": "Camper not found"}, status: :not_found
        end
    end  
    
    #POST /campers
    def create
        camper = Camper.new(camper_params)
        if camper.save
            render json: camper, serializer: CamperNoActivitiesSerializer, status: :created
        else
            render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
        end
    end

    private

    def camper_params
        params.permit(:name, :age)
    end
end