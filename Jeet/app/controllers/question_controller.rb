

class QuestionController < ApplicationController
  def search
    param1 = params[:param1]
    param2 = params[:param2]
    BingSearch.account_key = 'zAA9aG0iKmtlXNjQLdNVhsmcRaGf6GqX2ypJpQJAHvY'
    keywords = "" << params[:param1] << " " << params[:param2]
    @result = BingSearch.composite(keywords, [:web, :image, :news])
    
    sql = "SELECT R1.name, R1.full_address, R1.city, BC1.category, R1.star,SeniorUser.user_id, RE3.business_id
    From 
    (
    Select distinct RE1.user_id
    From reviews RE1
    Where RE1.business_id = '" + params[:param3] + "'
    limit 3
    ) as SeniorUser
    Inner join reviews RE3
    Inner join
    (Select R.restaurant_id,R.name, R.full_address, R.city, R.star
    From restaurants R
    ) as R1
    Inner join 
    ( Select *
    From business_category BC
    Where BC.category Like '%" + params[:param4] + "%'
    ) as BC1
    where SeniorUser.user_id = RE3.user_id and RE3.business_id = R1.restaurant_id and R1.restaurant_id = BC1.business_id
    order by R1.star DESC,SeniorUser.user_id
    limit 5"
    restaurants = Restaurant.find_by_sql(sql)
    
    flash[:name2] = []
    restaurants.each do |r|
      flash[:name2] << r.name
    end
    
    flash[:address2] = []
    restaurants.each do |r|
      flash[:address2] << r.full_address
    end
    
    flash[:category2] = []
    restaurants.each do |r|
      flash[:category2] << r.category
    end
    
    flash[:star2] = []
    restaurants.each do |r|
      flash[:star2] << r.star.to_s + "/5.0"
    end
    
  end

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
        when "Charlotte"
          @longitude = -80.8
          @latitude = 35.26
        when "Las Vegas"
          @longitude = -114.97
          @latitude = 35.927
        when "Madison"
          @longitude = -89.42
          @latitude = 43.07
        when "Homestead"
          @longitude = -79.9
          @latitude = 40.39
          
        else
 
        end
        puts "longitude: " + @longitude.to_s

        sql = "
        select R1.restaurant_id, R1.name, R1.full_address, R1.star, R1.distance, R1.latitude, R1.longitude, RC1.category
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
        flash[:longitude] = []
        flash[:name] = []
        flash[:address] = []
        flash[:star] = []
        flash[:distance] = []
        flash[:category] = []
        flash[:id] = []
        restaurants.each do |r|
          flash[:latitude] << r.latitude
          flash[:longitude] << r.longitude
          flash[:name] << r.name
          flash[:address] << r.full_address
          flash[:star] << r.star.to_s + "/5.0"
          flash[:distance] << (r.distance.to_s[0, 5] + " Miles")
          flash[:category] << r.category
          flash[:id] << r.restaurant_id
        end
        
        if (!flash[:name].any?) 
          redirect_to(:action => "error")
        else 
          redirect_to(:action => 'new')
        end
     end
  end
  
  def new
    @question = Question.new
  end
  
  def error 
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
