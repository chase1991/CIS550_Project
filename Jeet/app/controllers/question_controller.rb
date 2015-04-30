class QuestionController < ApplicationController
  def index
     @question = Question.all

     if params[:category] != nil
        puts params[:city]
    
        case params[:city]
        when "Phoenix"
          @longitude = -112
          @latitude = 33.45
        when "Carnegie"
          @longitude = -80.1
          @latitude = 40.4
        when "Pittsburgh"
          @longitude = -80
          @latitude = 40.4
        when "Bethel Park"
          @longitude = -80.03
          @latitude = 40.32
        when "Bethel Park"
          @longitude = -112
          @latitude = 33.45
        else
 
        end
        puts "longitude: " + @longitude.to_s
        sql = "
        select R1.restaurant_id, R1.name, R1.full_address, R1.star, R1.distance, R1.latitude, R1.longitude
        from
        (Select distinct R.restaurant_id,R.name, R.full_address, R.star, SQRT(POW(69.1 * (R.latitude - " + @latitude.to_s  + "), 2) + POW(69.1 * (" + @longitude.to_s + " - R.longitude) * COS(latitude / 57.3), 2)) AS distance, R.latitude, R.longitude
        From restaurants R
        Where R.city like '%" + params[:city] +
        "%') R1
        Inner join
        (Select * 
        From business_category BC 
        Where BC.category like '%" + params[:type][0, 5] + "%') RC1 on RC1.business_id = R1.restaurant_id
        Inner join
        (Select * 
        From business_category RC 
        Where RC.category like '%" + params[:category][0, 5] + "%') AS RC2 on RC1.business_id = RC2.business_id
        where R1.distance < " + params[:range][-4, 2] +
        " Order by R1.star DESC, distance ASC
        Limit 5"
        
        restaurants = Restaurant.find_by_sql(sql)
        
        flash[:latitude] = []
        restaurants.each do |r|
          flash[:latitude] << r.latitude
        end
        
        flash[:longitude] = []
          restaurants.each do |r|
        flash[:longitude] << r.longitude
        end
        
        flash[:name] = []
        restaurants.each do |r|
          flash[:name] << r.name
        end
        
        flash[:address] = []
        restaurants.each do |r|
          flash[:address] << r.full_address
        end
        
        flash[:star] = []
        restaurants.each do |r|
          flash[:star] << r.star.to_s + "/5.0"
        end
        
        flash[:distance] = []
        restaurants.each do |r|
          flash[:distance] << (r.distance.to_s[0, 5] + " Miles")
        end
        
        
        
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
