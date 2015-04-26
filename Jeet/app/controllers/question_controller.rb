class QuestionController < ApplicationController

  def index
     @question = Question.all
     if params[:category] != nil 
        
     end
  end
  
  def new
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
