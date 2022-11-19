class QuestionsController < PermissionsController
  before_action :authenticate_user!
  before_action :only_teacher, only: %i[create update destroy]
  before_action :set_question, only: %i[show update destroy]

  def index
    @test = Test.find(params[:test_id])
    @questions = @test.questions.all
    if @questions
      render json: { success: true, questions: @questions }
    else
      render json: { success: false, error: '[]' }
    end
  end

  def show
    if @question
      render json: { success: true, question: @question }
    else
      render json: { success: false, error: '[]' }
    end
  end

  def create
    @question = Question.create(question_params.merge(test_id: params[:test_id]))
    if @question.save
      render json: { success: true, message: "Question Created succefully", question: @question }, status: :created
    else
      render json: { success: false, error: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: { success: true, message: "Question Updated succefully", question: @question }, status: :ok
    else
      render json: { success: false, error: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      render json: { success: true, message: "Question Deleted succefully" }, status: :ok
    else
      render json: { success: false, error: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @test = Test.find(params[:test_id])
    # p "her is the test #{@test.id}"
    @question = @test.questions.find(params[:id])
  end

  def question_params
    params.permit(:title, :description)
  end
end
