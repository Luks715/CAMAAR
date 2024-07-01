class FormulariosController < ApplicationController
  # GET /formularios
  def index
    @formularios = Formulario.all
  end

  # GET /formularios/1
  def show
    @formulario = Formulario.find(params[:id])
  end

  def responder
    @formulario = Formulario.find(params[:id])
    @template = @formulario.template
  end

  # GET /formularios/new
  def new
    @formulario = Formulario.new
    @templates = Template.all
  end

  # GET /formularios/1/edit
  def edit
    @formulario = Formulario.find(params[:id])
  end

  # POST /formularios
  def create
    @formulario = Formulario.new(formulario_params)

    if @formulario.save
      criar_resultados_formulario(@formulario)
      redirect_to @formulario, notice: 'Formulário foi criado com sucesso.'
    else
      @templates = Template.all
      render :new
    end
  end

  # PATCH/PUT /formularios/1
  def update
    @formulario = Formulario.find(params[:id])
    if @formulario.update(formulario_params)
      redirect_to @formulario, notice: 'Formulário foi atualizado com sucesso.'
    else
      @templates = Template.all
      render :edit
    end
  end

  # DELETE /formularios/1
  def destroy
    @formulario = Formulario.find(params[:id])
    @formulario.destroy
    redirect_to formularios_url, notice: 'Formulário foi excluído com sucesso.'
  end

  private
    # Only allow a list of trusted parameters through.
    def formulario_params
      params.require(:formulario).permit(:dataDeTermino, :nome, :respondentes, :template_id)
    end

    def criar_resultados_formulario(formulario)
      template = formulario.template
      template.questaos.each do |questao|
        questao.alternativas.each do |alternativa|
          Resultado.create!(
            formulario: formulario,
            template: template,
            questao: questao,
            alternativa: alternativa,
            respostas: 0,
            respostas_discursivas: ""
          )
        end
      end
    end
end
