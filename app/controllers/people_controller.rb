class PeopleController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    respond_to do |format|
      format.json { 
        render json: @people, :include => [:roles]
      }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    respond_to do |format|
      format.json {
        render json: @person, :include => [:roles]
      }
    end
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json {
          render :json => @person, :include=>[:roles]
          # Don't use this, due to this View no Role Data NOde
          # render :show, status: :ok, location: @person, :include=>[:roles]
        }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # Make Nested Parameter to white list.
    # ref: http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
    # ref: https://github.com/rails/strong_parameters 
    # ref: http://stackoverflow.com/questions/18436741/rails-4-strong-parameters-nested-objects
    # ref: http://www.createdbypete.com/articles/working-with-nested-forms-and-a-many-to-many-association-in-rails-4/
    def person_params
      # 結構似乎跟送上來的不大一樣, 要稍作轉換, 還要吻合 Nested Attributes 架構
      # For each hash that "does not have an id" key a new record will be instantiated, unless the hash also contains a "_destroy" key that evaluates to "true".
      # 果資料沒有 id 欄位將自動轉成建立
      # ref: http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
      params[:person][:roles_attributes] = params[:roles]
      params.require(:person).permit(:label, :content, :roles_attributes => [:id, :role_id, :user_id])
    end
end
