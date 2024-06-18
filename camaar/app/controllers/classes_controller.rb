class ClassesController < ApplicationController
  before_action :set_classe, only: [:show, :edit, :update, :destroy]

  # GET /classes
  def index
    @classes = Classe.all
  end

  # GET /classes/1
  def show
    @formularios = @classe.formularios
  end

  # GET /classes/new
  def new
    @classe = Classe.new
  end

  # GET /classes/1/edit
  def edit
  end

  # POST /classes
  def create
    @classe = Classe.new(classe_params)

    if @classe.save
      redirect_to @classe, notice: 'Classe criada com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /classes/1
  def update
    if @classe.update(classe_params)
      redirect_to @classe, notice: 'Classe atualizada com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /classes/1
  def destroy
    @classe.destroy
    redirect_to classes_url, notice: 'Classe excluída com sucesso.'
  end

  private
    def set_classe
      @classe = Classe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def classe_params
      params.require(:classe).permit(:class_code, :semestre, :horario, :disciplina_id, :docente_id)
    end
end
