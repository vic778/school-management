class QuestionsController < PermissionsController
  before_action :authenticate_user!
  before_action :only_teacher, only: %i[create update destroy]
  before_action :set_question, only: %i[show update destroy scope_questions]

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
      render json: { success: true, question: @question, answers: @question.answers }
    else
      render json: { success: false, error: '[]' }
    end
  end

  def scope_questions
    answer = @question.answers.find(params[:answer_id]).name
    correct_answer = @question.answers.find_by(answer: true).name
    # p "here is the answer #{answer}"
    # p "her is the question #{@question.title}"
    # p "here is the correct answer #{correct_answer.inspect}"
    if answer == @question.answers.find_by(answer: true).name
      render json: { success: true, message: "Congrats! You have choose the correct answer", question: @question, correct_answer: }, status: :ok
    else
      render json: { success: false, message: "OP! Sorry you have chosed the wrong asnwer. the correct answer is #{correct_answer}", question: @question, correct_answer: }
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
    # @question = @test.questions.find(params[:id])
    @question = @test.questions.includes(:answers).find(params[:id])
  end

  def question_params
    params.permit(:title, :description)
  end
end
