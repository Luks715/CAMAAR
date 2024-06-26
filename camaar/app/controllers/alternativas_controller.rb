class AlternativasController < ApplicationController
  before_action :set_alternativa, only: [:show, :edit, :update, :destroy]

  # GET /alternativas
  def index
    @alternativas = Alternativa.all
  end

  # GET /alternativas/1
  def show
  end

  # GET /alternativas/new
  def new
    @alternativa = Alternativa.new
  end

  # GET /alternativas/1/edit
  def edit
  end

  # POST /alternativas
  def create
    @alternativa = Alternativa.new(alternativa_params)

    if @alternativa.save
      redirect_to @alternativa, notice: 'Alternativa was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /alternativas/1
  def update
    if @alternativa.update(alternativa_params)
      redirect_to @alternativa, notice: 'Alternativa was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /alternativas/1
  def destroy
    @alternativa.destroy
    redirect_to alternativas_url, notice: 'Alternativa was successfully destroyed.'
  end

  private

    def set_alternativa
      @alternativa = Alternativa.find(params[:id])
    end

    def alternativa_params
      params.require(:alternativa).permit(:texto, :questao_id)
    end
end
