class Api::V1::EmployeesController < ApiController
  before_action :set_employee, only: [:show]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    employees = Employee.select(:id, :name, :department, :gender)
    render json: employees
  end

  def show
    render json: @employee
  end

  def update
    if @employee.update_attributes(employee_params)
      head :no_content
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end
end