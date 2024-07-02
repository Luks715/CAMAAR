class ResultadosController < ApplicationController
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

  private

  def resultado_params
    params.require(:resultado).permit(:formulario_id, :template_id, :questao_id, :alternativa_id, :quantidade_respostas, :respostas_discursivas)
  end
end
