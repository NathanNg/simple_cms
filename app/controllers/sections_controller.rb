class SectionsController < ApplicationController

layout 'admin'

before_action :confirm_logged_in
before_action :find_page

  def index
    #@sections = Section.where(:page_id => @page.id).sorted
    #@sections = Section.sorted
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id})
    @section_count = Section.count + 1
    @pages = @page.subject.pages.sorted
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to(:action => 'index', :page_id => @page.id)
    else
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end

  def edit
    @section_count = Section.count
    @pages = Page.order('position ASC')
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      redirect_to(:action => 'show',:id => @section.id, :page_id => @page.id)
    else
      @section_count = Section.count
      @pages = Page.order('position ASC')
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id]).destroy
    redirect_to(:action => 'index', :page_id => @page.id)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content, :content_type)
  end

  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
    else
      'no params'
    end
  end

end
