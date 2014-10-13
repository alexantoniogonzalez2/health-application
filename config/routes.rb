AplicacionMedica::Application.routes.draw do

  devise_for :users,:controllers => { :registrations =>'registration'}

  get 'about',   to: 'home#about',  as: 'about' 
  get 'dashboard' => 'home#dashboard'

  #root :to =>'home#index'

  #Antecedentes
  get '/antecedentes/index', to: 'antecedentes#index', :as => :antecedentes_index 

  #Habitos alcohol
  get '/habitos_alcohol/new', to: 'habitos_alcohol#new', :as => :habitos_alcohol_new
  post '/habitos_alcohol', to: 'habitos_alcohol#create'   
  get '/habitos_alcohol/index', to: 'habitos_alcohol#index', :as => :habitos_alcohol_index  
  get '/habitos_alcohol/:id', to: 'habitos_alcohol#show'

  #Habitos tabaco
  get '/habitos_tabaco/new', to: 'habitos_tabaco#new', :as => :habitos_tabaco_new
  post '/habitos_tabaco', to: 'habitos_tabaco#create'   
  get '/habitos_tabaco/index', to: 'habitos_tabaco#index', :as => :habitos_tabaco_index  
  get '/habitos_tabaco/:id', to: 'habitos_tabaco#edit'


  #Horas agendadas
  post '/bloquear_hora', to: 'agendamiento#bloquearHora', :as => :bloquearHora
  post '/desbloquear_hora', to: 'agendamiento#desbloquearHora', :as => :desbloquearHora

  #Modulo atencion salud
  resources :atenciones_salud
  post '/agregar_prestacion', to: 'persona_prestacion#agregarPrestacion', :as => :agregarExamen
  post '/eliminar_prestacion', to: 'persona_prestacion#eliminarPrestacion', :as => :eliminarPrestacion
  post '/agregar_diagnostico', to: 'persona_diagnostico#agregarDiagnostico', :as => :agregarDiagnostico
  post '/crear_atencion', to: 'atenciones_salud#crearAtencion'
  post '/reabrir_atencion', to: 'atenciones_salud#reabrirAtencion'
  post '/editar_atencion', to: 'atenciones_salud#editarAtencion'
  post '/cargar_diagnosticos', to: 'persona_diagnostico#cargarDiagnosticos'
  post '/cargar_personas', to: 'persona_diagnostico#cargarPersonas'
  post '/agregar_persona_notificacion', to: 'persona_diagnostico#agregarPersonaNotificacion'
  post '/agregar_persona_notificacion_pre', to: 'persona_diagnostico#agregarPersonaNotificacionPre'
  post '/agregar_info_interconsulta', to: 'persona_diagnostico#agregarInfoInterconsulta'
  post '/agregar_persona_interconsulta_pre', to: 'persona_diagnostico#agregarPersonaInterconsultaPre'  
  post '/agregar_info_eno', to: 'persona_diagnostico#agregarInfoEno' 
  post '/cargar_prestaciones', to: 'persona_prestacion#cargarPrestaciones'
  post '/eliminar_diagnostico', to: 'persona_diagnostico#eliminarDiagnostico', :as => :eliminarDiagnostico
  post '/guardar_diagnostico', to: 'persona_diagnostico#guardarDiagnostico', :as => :guardarDiagnostico 
  post '/cargar_medicamentos', to: 'persona_medicamento#cargarMedicamentos'
  post '/agregar_medicamento', to: 'persona_medicamento#agregarMedicamento'
  post '/eliminar_medicamento', to: 'persona_medicamento#eliminarMedicamento'
  post '/guardar_medicamento', to: 'persona_medicamento#guardarMedicamento'
  post '/guardar_metricas', to: 'persona_metricas#guardarMetricas'
  post '/cargar_datos_metricas', to: 'persona_metricas#cargarDatosMetricas'
  post '/guardar_texto', to: 'atenciones_salud#guardarTexto'
  post '/autoguardar_comentario', to: 'persona_diagnostico#autoguardarComentario'
  post '/descargar_constancia_ges', to: 'persona_diagnostico#descargarConstanciaGes'
  post '/descargar_interconsulta', to: 'persona_diagnostico#descargarInterconsulta'
  post '/descargar_notificacion_obligatoria', to: 'persona_diagnostico#descargarNotificacionObligatoria'
  post '/persona_diagnostico/index', to: 'persona_diagnostico#index', :as => :persona_diagnostico_index  
  get '/persona_diagnostico/index', to: 'persona_diagnostico#index'
 
  #Modulo agendamiento
  post '/agendamiento/agregarHora', to: 'agendamiento#new'
  get '/agendamiento/buscarHora', to: 'agendamiento#showFormBusqueda', :as => :agendaShowFormBusqueda
  get '/agendamiento/pedirHora/:especialidad_id/:prestador_id/:profesional_id', to: 'agendamiento#pedirHora'
  put '/agendamiento/pedirHora', to: 'agendamiento#pedirHora', :as => :pedirHora #Esta es solo para ponerle un nombre a la anterior pero sin parámtros
  get '/agendamiento/buscadorHora', to: 'agendamiento#buscadorHora', :as => :agendamientoBuscadorHora
  post '/cargarTodos', to: 'agendamiento#cargarTodos', :as => :agendamientoCargarTodos
  post '/filtrar_profesionales', to: 'agendamiento#filtrarProfesionales', :as => :filtrarProfesionales
  post '/buscar_horas', to: 'agendamiento#buscarHoras', :as => :buscarHoras
  post '/buscar_horas_profesional', to: 'agendamiento#buscarHorasProfesional'
  post '/aux/formNuevaHora', to: 'agendamiento#agregarNuevaHora', :as => :agregarHora
  post '/aux/mostrarEventos', to: 'agendamiento#mostrarEventos', :as => :showEventos
  post '/aux/detalleEvento', to: 'agendamiento#detalleEvento', :as => :detalleEvento
  post '/aux/pedirHoraEvento', to: 'agendamiento#pedirHoraEvento', :as => :pedirHoraEvento
  post '/aux/cancelarHora', to: 'agendamiento#cancelarHora', :as => :cancelarHora
  post '/aux/confirmarHora', to: 'agendamiento#confirmarHora', :as => :confirmarHora
  post '/aux/marcarLlegada', to: 'agendamiento#marcarLlegada', :as => :marcarLlegada
  post '/aux/buscarHoraFormActualizar', to:'agendamiento#showFormBusquedaActualizar', :as => :agendaShowFormBusquedaRefresh

  #Home
  root :controller => 'home', :action => :index
  post '/actualizar_atenciones', to: 'home#actualizarAtenciones'
  post '/revisar_actualizaciones', to: 'home#revisarActualizaciones'

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
