class FormulariosController < ApplicationController
  before_action :set_formulario, only: [:show, :edit, :update, :destroy]

  # GET /formularios
  def index
    @formularios = Formulario.all
  end

  # GET /formularios/1
  def show
    @classes = @formulario.classes
    @template = @formulario.template
  end

  # GET /formularios/new
  def new
    @formulario = Formulario.new
    @classes_disponiveis = current_docente.classes
    @templates_disponiveis = current_docente.templates
  end

  # GET /formularios/1/edit
  def edit
    @classes_disponiveis = current_docente.classes
    @templates_disponiveis = current_docente.templates
  end

  # POST /formularios
  def create
    @formulario = Formulario.new(formulario_params)
    @formulario.classes << current_docente.classes.find(params[:formulario][:classe_ids]) if params[:formulario][:classe_ids].present?

    if @formulario.save
      redirect_to @formulario, notice: 'Formulário criado com sucesso.'
    else
      @classes_disponiveis = current_docente.classes
      @templates_disponiveis = current_docente.templates
      render :new
    end
  end

  # PATCH/PUT /formularios/1
  def update
    @formulario.classes.clear
    @formulario.classes << Classe.find(params[:formulario][:classe_ids]) if params[:formulario][:classe_ids].present?

    if @formulario.update(formulario_params)
      redirect_to @formulario, notice: 'Formulário atualizado com sucesso.'
    else
      @classes_disponiveis = current_docente.classes
      @templates_disponiveis = current_docente.templates
      render :edit
    end
  end

  # DELETE /formularios/1
  def destroy
    @formulario.destroy
    redirect_to formularios_url, notice: 'Formulário excluído com sucesso.'
  end

  private
    def set_formulario
      @formulario = Formulario.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def formulario_params
      params.require(:formulario).permit(:resultados, :dataDeTermino, :docente_id, :template_id, classe_ids: [])
    end
end
