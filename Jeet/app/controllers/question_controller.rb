

class QuestionController < ApplicationController
  def search
    BingSearch.account_key = 'zAA9aG0iKmtlXNjQLdNVhsmcRaGf6GqX2ypJpQJAHvY'
    @result = BingSearch.composite("majorana", [:web, :image, :news])
  end

  def index
     @question = Question.all

     BingSearch.account_key = 'zAA9aG0iKmtlXNjQLdNVhsmcRaGf6GqX2ypJpQJAHvY'
     #BingSearch.web_only = true
     @rsp = BingSearch.web('Dyson').first

     #bing_image = Bing.new('zAA9aG0iKmtlXNjQLdNVhsmcRaGf6GqX2ypJpQJAHvY', 10, 'Image')
     #bing_results = bing_image.search("puffin")
     #@rsp = bing_results[0]["ImageTotal"]

     if params[:category] != nil 
     @latitude = 39.9
     @longtitude = 116

     

     #@rsp = bing.web("ruby")
     #@searchResult = rsp.web.results[0].title
     #@rsp = Geocoder.search("1 Twins Way, Minneapolis")
     #@rsp = Bing.new("zAA9aG0iKmtlXNjQLdNVhsmcRaGf6GqX2ypJpQJAHvY", 10, "Web")
     #@rsp = Binged::Client.new(:api_key => '40e5a6ee363c4dddb3fcaf4a23c9df5e')
     #@rsp = GoogleCustomSearch.search("Hank Aaron")
     #results = GoogleCustomSearchApi.search("poker")
     #@rsp = results["items"][0]["title"]
      flash[:latitude] = @latitude
      flash[:longtitude] = @longtitude
      redirect_to(:action => 'new')
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
