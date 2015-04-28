class QuestionController < ApplicationController
  attr_accessor :lat, :long
  def index
     @question = Question.all
    @lat = 39.9
    @long = 116
     if params[:category] != nil 
        redirect_to(:action => 'new')
     end
  end
  
  def new
    @latitude = @lat 
    @longtitude = @long
    @question = Question.new
  end

  def show
  end

  def delete
  end

  def edit
  end
  
  def create
   @question = Question.new(question_params)
   if @question.save
    redirect_to(:action => 'index')
   else
    render('new')
   end
  end
  
  
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:category, :range, :type)
  end
  
end
