class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid_instructor

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def instructor_not_found
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def invalid_instructor(invalid)
        render json: { errors: invalid.errors.full_messages }, status: :unprocessable_entity
    end

end
