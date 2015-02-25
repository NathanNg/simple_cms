class SubjectsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
    @count = Subject.count
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject =Subject.new({:name => 'Default'})
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    #Instantiate a new object
    if @subject.save #save the object
      #if save succeeds, redirect to index page
      flash[:notice] = "The subject created succesfully"
      redirect_to(:action => 'index')
    else
      #if save fails, redisplay the form
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #find the subject
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)
      #return true/false
      #if update succeeds, redirect to index page
      flash[:notice] = "The subject updated succesfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #if update fails, redisplay the form
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "The subject destroyed '#{subject.name}' succesfully"
    redirect_to(:action => 'index')
  end

  private

  def subject_params
    #same as using "params[:subject]", except that it:
    #-raises an error if :subject is not present
    #-allows listed attributes to be mass-assigned
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end
end
