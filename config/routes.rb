Rails.application.routes.draw do

  devise_for :users,:controllers => { :registrations =>'registration', :passwords => "password"} 
  
  root :controller => 'home', :action => :index
  get 'about',   to: 'home#about',  as: 'about' 
  get 'account_created' => 'home#account_created'
  get 'password_reset' => 'home#password_reset'
  get 'password_reseted' => 'home#password_reseted'
  post '/enviar_correo_contacto', to: 'home#enviarCorreoContacto'

  #Antecedentes
  get '/antecedentes/index', to: 'antecedentes#index', :as => :antecedentes_index 
  post '/antecedentes/:id', to: 'antecedentes#edit'
  post '/editar_alergia', to: 'antecedentes#editarAlergia'
  post '/agregar_alergia', to: 'antecedentes#agregarAlergia'
  post '/guardar_antecedentes_sociales', to: 'antecedentes#guardarAntecedentesSociales'
  post '/cargar_antecedentes', to: 'antecedentes#cargarAntecedentes'
  post '/guardar_antecedente_familiar_muerte', to: 'antecedentes#guardarAntecedenteFamiliarMuerte'
  post '/guardar_antecedente_familiar_cronica', to: 'antecedentes#guardarAntecedenteFamiliarCronica'
  post '/guardar_antecedentes_ginecologicos', to: 'antecedentes#guardarAntecedentesGinecologicos'

  #Ocupaciones
  get '/ocupaciones/new', to: 'ocupaciones#new', :as => :ocupaciones_new
  post '/ocupaciones', to: 'ocupaciones#create'
  get '/ocupaciones/index', to: 'ocupaciones#index', :as => :ocupaciones_index  
  get '/ocupaciones/:id', to: 'ocupaciones#edit'
  post '/cargar_ocupaciones', to: 'ocupaciones#cargarOcupaciones'

  #Habitos alcohol
  get '/habitos_alcohol/new', to: 'habitos_alcohol#new', :as => :habitos_alcohol_new
  post '/habitos_alcohol', to: 'habitos_alcohol#create'   
  get '/habitos_alcohol/index', to: 'habitos_alcohol#index', :as => :habitos_alcohol_index  
  get '/habitos_alcohol/:id', to: 'habitos_alcohol#show'
  post '/guardar_habito_alcohol_resumen', to: 'habitos_alcohol#guardarHabitoAlcoholResumen'  

  #Habitos tabaco
  get '/habitos_tabaco/new', to: 'habitos_tabaco#new', :as => :habitos_tabaco_new
  post '/habitos_tabaco', to: 'habitos_tabaco#create'   
  get '/habitos_tabaco/index', to: 'habitos_tabaco#index', :as => :habitos_tabaco_index  
  get '/habitos_tabaco/:id', to: 'habitos_tabaco#edit'

  #Vacunas
  get '/vacunas/index', to: 'vacunas#index', :as => :vacunas_index
  get '/vacunas/calendario', to: 'vacunas#calendario', :as => :vacunas_calendario 
  get '/vacunas/otras_vacunas', to: 'vacunas#otras_vacunas', :as => :otras_vacunas
  post '/actualizar_vacunas', to: 'vacunas#actualizar'
  
  #Horas agendadas
  post '/bloquear_hora', to: 'agendamiento#bloquearHora', :as => :bloquearHora
  post '/desbloquear_hora', to: 'agendamiento#desbloquearHora', :as => :desbloquearHora

  #Actividad física
  post '/guardar_actividad_fisica', to: 'antecedentes#guardarActividadFisica'
  post '/guardar_actividad_fisica_resumen', to: 'antecedentes#guardarActividadFisicaResumen'  

  #Modulo atencion salud
  resources :atenciones_salud
  post '/agregar_prestacion', to: 'persona_prestacion#agregarPrestacion', :as => :agregarExamen
  post '/agregar_prestacion_ant', to: 'persona_prestacion#agregarPrestacionAntecedentes'
  post '/eliminar_prestacion', to: 'persona_prestacion#eliminarPrestacion', :as => :eliminarPrestacion
  post '/agregar_diagnostico', to: 'persona_diagnostico#agregarDiagnostico', :as => :agregarDiagnostico
  post '/agregar_diagnostico_ant', to: 'persona_diagnostico#agregarDiagnosticoAntecedentes'
  post '/crear_atencion', to: 'atenciones_salud#crearAtencion'
  get '/sin_permiso', to: 'atenciones_salud#sinPermiso'
  get '/sin_editar', to: 'atenciones_salud#sinEditar'
  post '/reabrir_atencion', to: 'atenciones_salud#reabrirAtencion'
  post '/ver_atencion', to: 'atenciones_salud#verAtencion'
  post '/editar_atencion', to: 'atenciones_salud#editarAtencion'
  post '/cargar_diagnosticos', to: 'persona_diagnostico#cargarDiagnosticos'
  post '/agregar_persona_notificacion', to: 'persona_diagnostico#agregarPersonaNotificacion'
  post '/agregar_persona', to: 'persona#agregarPersona'
  post '/cargar_cercanos', to: 'persona#cargarCercanos'
  post '/agregar_info_interconsulta', to: 'persona_diagnostico#agregarInfoInterconsulta'
  post '/agregar_info_eno', to: 'persona_diagnostico#agregarInfoEno'
  post '/agregar_info_prestacion', to: 'persona_prestacion#agregarInfoPrestacion'  
  post '/cargar_prestaciones', to: 'persona_prestacion#cargarPrestaciones'
  post '/eliminar_diagnostico', to: 'persona_diagnostico#eliminarDiagnostico'
  post '/guardar_diagnostico', to: 'persona_diagnostico#guardarDiagnostico', :as => :guardarDiagnostico 
  post '/cargar_medicamentos', to: 'persona_medicamento#cargarMedicamentos'
  post '/agregar_medicamento', to: 'persona_medicamento#agregarMedicamento'
  post '/agregar_medicamento_ant', to: 'persona_medicamento#agregarMedicamentoAntecedentes'
  post '/eliminar_medicamento', to: 'persona_medicamento#eliminarMedicamento'
  post '/guardar_medicamento', to: 'persona_medicamento#guardarMedicamento'
  post '/guardar_metricas', to: 'persona_metricas#guardarMetricas'
  post '/cargar_datos_metricas', to: 'persona_metricas#cargarDatosMetricas'
  post '/guardar_texto', to: 'atenciones_salud#guardarTexto'
  post '/autoguardar_comentario', to: 'persona_diagnostico#autoguardarComentario'
  post '/descargar_constancia_ges', to: 'persona_diagnostico#descargarConstanciaGes'
  post '/descargar_interconsulta', to: 'persona_diagnostico#descargarInterconsulta'
  post '/descargar_notificacion_obligatoria', to: 'persona_diagnostico#descargarNotificacionObligatoria'
  post '/descargar_certificado', to: 'atenciones_salud#descargarCertificado'
  post '/descargar_indicaciones', to: 'atenciones_salud#descargarIndicaciones'
  post '/descargar_receta', to: 'atenciones_salud#descargarReceta'
  post '/persona_prestacion/index_examen', to: 'persona_prestacion#indexExamen', :as => :persona_prestacion_index_examen  
  get '/persona_prestacion/index_examen', to: 'persona_prestacion#indexExamen'
  post '/persona_prestacion/index_procedimiento', to: 'persona_prestacion#indexProc', :as => :persona_prestacion_index_procedimiento  
  get '/persona_prestacion/index_procedimiento', to: 'persona_prestacion#indexProc'
  post '/agregar_diag_med', to: 'persona_medicamento#agregarDiagMed'
  post '/agregar_diag_cert', to: 'atenciones_salud#agregarDiagCert'
  post '/agregar_diag_pres', to: 'persona_prestacion#agregarDiagPres'
  post '/agregar_pres_int', to: 'persona_diagnostico#agregarPresInt'
  post '/actualizar_diag_med', to: 'persona_medicamento#actualizarDiagMed'
  post '/guardar_atencion', to: 'atenciones_salud#update'
  post '/cargar_atenciones_salud', to: 'atenciones_salud#cargarAtenciones'
  post '/cargar_atenciones_salud_para_pago', to: 'atenciones_salud#cargarAtencionesParaPago'
  post '/agregar_info_certificado', to: 'atenciones_salud#agregarInfoCertificado'
  post '/actualizar_diag_certificado', to: 'atenciones_salud#actualizarDiagCertificado'
  post '/actualizar_diag_prestacion', to: 'persona_prestacion#actualizarDiagPrestacion'
  post '/actualizar_diag_prestacion_int', to: 'persona_prestacion#actualizarDiagPrestacionInt'
  post '/imprimir_presupuesto', to: 'atenciones_salud#imprimirPresupuesto'
  
  #Modulo agendamiento
  post '/agendamiento/agregarHora', to: 'agendamiento#new'
  get '/agendamiento/buscarHora', to: 'agendamiento#showFormBusqueda', :as => :agendaShowFormBusqueda
  get '/agendamiento/generarHora/:especialidad_id/:prestador_id/:profesional_id', to: 'agendamiento#generarHora'
  put '/agendamiento/generarHora', to: 'agendamiento#generarHora', :as => :generarHora #Esta es solo para ponerle un nombre a la anterior pero sin parámetros
  get '/agendamiento/buscadorHora', to: 'agendamiento#buscadorHora', :as => :agendamientoBuscadorHora
  post '/cargarTodos', to: 'agendamiento#cargarTodos', :as => :agendamientoCargarTodos
  post '/filtrar_profesionales', to: 'agendamiento#filtrarProfesionales', :as => :filtrarProfesionales
  post '/filtrar_especialidad', to: 'agendamiento#filtrarEspecialidad'
  post '/buscar_horas', to: 'agendamiento#buscarHoras', :as => :buscarHoras
  post '/buscar_horas_profesional', to: 'agendamiento#buscarHorasProfesional'
  post '/aux/formNuevaHora', to: 'agendamiento#agregarNuevaHora', :as => :agregarHora
  post '/aux/mostrarEventos', to: 'agendamiento#mostrarEventos', :as => :showEventos
  post '/aux/detalleEvento', to: 'agendamiento#detalleEvento', :as => :detalleEvento
  post '/modificar_evento', to: 'agendamiento#modificarEvento'
  post '/aux/pedirHoraEvento', to: 'agendamiento#pedirHoraEvento', :as => :pedirHoraEvento
  post '/aux/cancelarHora', to: 'agendamiento#cancelarHora', :as => :cancelarHora
  post '/eliminarHora', to: 'agendamiento#eliminarHora'
  post '/aux/confirmarHora', to: 'agendamiento#confirmarHora', :as => :confirmarHora
  post '/aux/marcarLlegada', to: 'agendamiento#marcarLlegada', :as => :marcarLlegada
  post '/aux/buscarHoraFormActualizar', to:'agendamiento#showFormBusquedaActualizar', :as => :agendaShowFormBusquedaRefresh
  post '/preparar_ingreso', to: 'agendamiento#prepararIngreso'
  post '/cargar_cancelar_accion', to: 'agendamiento#cargarCancelarAccion'
  post '/cargar_vista_sin_cancelar', to: 'agendamiento#cargarVistaSinCancelar'
  post '/cancelar_accion_masiva', to: 'agendamiento#cancelarAccionMasiva'
  post '/cargar_pacientes', to: 'agendamiento#cargarPacientes'

  #Home
  post '/actualizar_atenciones', to: 'home#actualizarAtenciones'
  post '/revisar_actualizaciones', to: 'home#revisarActualizaciones'

  #Administración
  post '/generar_boletas', to: 'administracion#generarBoletas'
  post '/filtrar_boletas', to: 'administracion#filtrarBoletas'
  post '/cargar_atenciones_boleta', to: 'administracion#cargarAtencionesBoleta'
  post '/anular_boleta', to: 'administracion#anularBoleta'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end