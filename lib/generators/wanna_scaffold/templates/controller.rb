class <%= controller_class_name %>Controller < ApplicationController
  def index
    @<%= table_name %> = <%= class_name %>.find :all
    
    respond_to do |format|
      format.html      
    end
  end
 
  def show
    @<%= file_name %> = <%= class_name %>.find params[:id]
 
    respond_to do |format|
      format.html
    end
  end
 
  def new
    @<%= file_name %> = <%= class_name %>.new
 
    respond_to do |format|
      format.html
    end
  end
 
  def edit
    @<%= file_name %> = <%= class_name %>.find params[:id]
  end
 
  def create
    @<%= file_name %> = <%= class_name %>.new params[:<%= file_name %>]
 
    respond_to do |format|
      if @<%= file_name %>.save
        flash[:success] = '<%= class_name %> was successfully created.'
        format.html { redirect_to(@<%= file_name %>) }        
      else
        format.html { render :action => "new" }
      end
    end
  end
 
  def update
    @<%= file_name %> = <%= class_name %>.find params[:id]
 
    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:success] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(@<%= file_name %>) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
 
  def destroy
    @<%= file_name %> = <%= class_name %>.find params[:id]
    @<%= file_name %>.destroy
    flash[:success] = '<%= class_name %> was successfully deleted.'
 
    respond_to do |format|
      format.html { redirect_to(<%= table_name %>_url) }
    end
  end
end