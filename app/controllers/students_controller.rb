class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :student_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_student

    def index
        render json: Student.all, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age)
    end

    def student_not_found
        render json: { error: "Student not found" }, status: :not_found
    end

    def invalid_student(invalid)
        render json: { errors: invalid.errors.full_messages }, status: :unprocessable_entity
    end

end
