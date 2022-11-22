class AnswersController < PermissionsController
  before_action :authenticate_user!
  before_action :only_teacher
  before_action :set_answer, only: %i[show update destroy]

  def index
    @answers = Answer.all
    if @answers
      render json: @answers, status: :ok
    else
      render json: { error: "Not found" }, status: 404
    end
  end

  def show
    if @answer
      render json: @answer, status: :ok
    else
      render json: { error: "Not found" }, status: 404
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    if @answer.save
      render json: { success: true, message: "Answer Created succefully", answer: @answer }, status: :created
    else
      render json: { success: false, error: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render json: { success: true, message: "Answer Updated succefully", answer: @answer }, status: :ok
    else
      render json: { success: false, error: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @answer.destroy
      render json: { success: true, message: "Answer Deleted succefully" }, status: :ok
    else
      render json: { success: false, error: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.permit(:name, :answer)
  end
end
