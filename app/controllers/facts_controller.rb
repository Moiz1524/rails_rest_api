class FactsController < ApplicationController
  before_action :find_fact, :only => [:show, :edit, :update, :destroy]

  # GET /facts
  def index
    @facts = Fact.all
    render json: @facts, status: 200
  end

  # GET /facts/new
  def new
    @fact = Fact.new
  end

  # POST /facts
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      render json: @fact, status: 200
    else
      render error: { message: 'Unable to create Fact.' }, status: 400
      puts @fact.errors.full_messages
    end
  end

  # GET /facts/:id/edit
  def edit
  end

  # PATCH /facts/:id
  def update
    if @fact.update_attributes(fact_params)
      render json: { message: 'Fact updated successfully.' }, status: 200
    else
      render error: { message: 'Unable to update Fact.' }, status: 400
    end
  end

  # GET /facts/:id
  def show
    render json: @fact
  end

  # DELETE /facts/:id
  def destroy
    if @fact.destroy
      render json: { :message => 'Fact destroyed successfully.' }, status: 200
    else
      render error: { :message => 'Unable to destroy Fact.' }, status: 400
    end
  end

  private

  def find_fact
    @fact = Fact.find(params[:id])
  end

  # Mass assignment or strong parameters
  def fact_params
    params.require(:fact).permit(:fact, :likes, :user_id)
  end
end
