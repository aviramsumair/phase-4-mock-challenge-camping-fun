class SignupsController < ApplicationController

    #POST /signups
    def create
        signup = Signup.new(signup_params)
        if signup.save
            render json: signup.activity, status: :created
        else
            render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
        end
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end
end