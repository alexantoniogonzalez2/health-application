class AgendamientoEstadoController < ApplicationController
	def show_all
		@AgendamientoEstados=AgAgendamientoEstados.where("deleted = ?",false)

		respond_to do |format|
	      format.html { render "ag_estado_agendamiento/show_all"}
	    end
	end

	def new
      respond_to do |format|
      	@est_ag = AgAgendamientoEstados.new
        format.html {render "ag_estado_agendamiento/new" }
      end
	end

	def create
		@est_ag = AAgAgendamientoEstados.where("nombre = ?",params[:ag_estado_agendamiento][:nombre]).first
		if not @est_ag
			@est_ag=AgAgendamientoEstados.create(params[:ag_estado_agendamiento])
			@est_ag.save
		else
			@est_ag.deleted=false
			@est_ag.save
		end
		respond_to do |format|
	      format.html { redirect_to :ag_est_R}
	    end
	end

	def edit
		@est_ag = AgAgendamientoEstados.find(params[:id])

		respond_to do |format|
			@id=params[:id]
			@exists=true
			format.html {render "ag_estado_agendamiento/new"}
		end
	end

	def update
		@est_ag = AgAgendamientoEstados.find(params[:id])
		@est_ag.update_attributes(params[:ag_estado_agendamiento])
		respond_to do |format|
			format.html { redirect_to :ag_est_R }
		end
	end


	def delete
		@est_ag = AgAgendamientoEstados.find(params[:id])
		@est_ag.deleted = true
		@est_ag.save
		respond_to do |format|
			format.html { redirect_to :ag_est_R }
		end
	end

end
