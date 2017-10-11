class TeachersController < ApplicationController
  

  @@aggVotes = 0

  def new
    @placeholder_course = '186'
  end

  def create
    # Hint: params??
    @full_name = params[:full_name]
    @course = params[:course_name]
    @grade_level = params[:grade_level]
    render 'show'
  end

  def feedback(x) #-1 for too slow, 1 for too fast
    @@aggVotes += x
    puts x, @@aggVotes
  end

  # def self.gFeedback(x)
  #   puts x
  # end
  def show
    @output = @@aggVotes
    respond_to do |format|
      format.js
    end
  end

end
