class TestsController < PermissionsController
  before_action :authenticate_user!
  before_action :only_teacher, only: %i[update destroy create]
  before_action :set_test, only: %i[show update destroy]

  def index
    @tests = Test.all
    if @tests
      render json: { success: true, tests: @tests }, status: :ok
    else
      render json: { success: false, error: '[]' }
    end
  end

  def show
    if @test
      render json: { success: true, test: @test, questions: @test.questions }, status: :ok
    else
      render json: { success: false, error: '[]' }, status: :not_found
    end
  end

  def create
    @test = Test.new(test_params)
    # binding.pry
    if @test.save!
      render json: { success: true, message: "Test created successfully", test: @test }, status: :created
    else
      render json: { success: false, error: @test.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @test.update(test_params)
      render json: { success: true, message: "Test updated successfully", test: @test }, status: :ok
    else
      render json: { success: false, error: @test.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @test.destroy
      render json: { success: true, message: "Test deleted successfully", test: @test }, status: :ok
    else
      render json: { success: false, error: @test.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])
    @test.questions
  end

  def test_params
    params[:test].permit(:name, :description)
  end
end
