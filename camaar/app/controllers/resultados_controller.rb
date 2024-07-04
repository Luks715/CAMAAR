class ResultadosController < ApplicationController
  before_action :set_resultado, only: [:edit, :update]
  def new
    @formulario = Formulario.find(params[:formulario_id])
    @resultado = Resultado.new(formulario: @formulario)
  end

  def create
    @resultado = Resultado.new(resultado_params)

    if @resultado.save
      @resultado.calcular_nota
      @resultado.save # Salva novamente para persistir a nota calculada
      redirect_to @resultado, notice: 'Resultado foi criado com sucesso.'
    else
      @formulario = @resultado.formulario
      render :new
    end
  end

  def edit
    @formulario = @resultado.formulario
    @template = @formulario.template
    @questaos = @template.questaos
  end

  def update
    @formulario = @resultado.formulario
    @template = @formulario.template

    if @formulario.respondentes.include?(current_user.nome)
      flash[:notice] = "Formulário já respondido"
      redirect_to home_dicente_url
    else
      if params[:respostas].present?
        # Processa as respostas discursivas
        if params[:respostas][:discursivas].present?
          params[:respostas][:discursivas].each do |questao_id, resposta|
            resultado = Resultado.find_or_create_by(
              formulario: @formulario,
              template: @template,
              questao_id: questao_id
            )
            resultado.update(respostas_discursivas: (resultado.respostas_discursivas.to_s + "###" + resposta))
          end
        end

        # Processa as respostas alternativas
        if params[:respostas][:alternativas_ids].present?
          params[:respostas][:alternativas_ids].each do |questao_id, alternativa_id|
            resultado = Resultado.find_or_create_by(
              formulario: @formulario,
              template: @template,
              questao_id: questao_id,
              alternativa_id: alternativa_id
            )
            resultado.update(quantidade_respostas: resultado.quantidade_respostas.to_i + 1)
          end
        end
        respondentes = @formulario.respondentes
        respondentes += ", " + current_user.nome
        @formulario.update(respondentes: respondentes)

        redirect_to home_dicente_url, notice: "Formulário respondido com sucesso."
      end
    end
  end

  #def update
  #  @formulario = @resultado.formulario
  #  @template = @formulario.template

  #  @template.questaos.each do |questao|
  #    if questao.tipo.discursiva == "true"

  #      respostas_discursiva = params[:discursivas]

  #      respostas_discursiva.each do |questao_id, resposta|
  #        resultado = Resultado.find_or_create_by(
  #          formulario: @formulario,
  #          template: @template,
  #          questao_id: questao_id
  #        )
  #        resultado.update(respostas_discursivas: resultado.respostas_discursivas + "###" + resposta)
  #      end
  #    else
  #      alternativa_ids = params[:alternativas_ids]
  #      alternativa_ids.each do |id|
  #        resultado = Resultado.find_or_create_by(
  #          formulario: @formulario,
  #          template: @template,
  #          questao: questao,
  #          alternativa_id: id
  #        )
  #        resultado.update(quantidade_respostas: resultado.quantidade_respostas + 1)
  #      end
  #    end
  #  end

  #  respondentes = @formulario.respondentes
  #  respondentes += ", " + current_user.nome
  #  @formulario.update(respondentes: respondentes)

  #  redirect_to home_dicente_url, notice: "Formulário respondido com sucesso."
  #end


  private
  def set_resultado
    @resultado = Resultado.find(params[:id])
  end

  def resultado_params
    params.require(:resultado).permit(:formulario_id, :template_id, :questao_id, :alternativa_id, :quantidade_respostas, :respostas_discursivas)
  end
end
