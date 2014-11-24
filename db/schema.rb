# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141123062910) do

  create_table "ag_agendamiento_estados", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ag_agendamiento_log_estados", force: true do |t|
    t.integer  "responsable_id"
    t.integer  "agendamiento_estado_id"
    t.integer  "agendamiento_id"
    t.datetime "fecha"
  end

  create_table "ag_agendamientos", force: true do |t|
    t.integer  "persona_id"
    t.datetime "fecha_comienzo"
    t.datetime "fecha_final"
    t.datetime "fecha_llegada_paciente"
    t.datetime "fecha_comienzo_real"
    t.datetime "fecha_final_real"
    t.integer  "agendamiento_estado_id"
    t.integer  "especialidad_prestador_profesional_id"
    t.boolean  "motivo_consulta_nuevo"
    t.integer  "persona_diagnostico_control_id"
    t.integer  "capitulo_cie10_control_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_atenciones_salud", force: true do |t|
    t.text     "motivo_consulta"
    t.text     "examen_fisico"
    t.text     "indicaciones_generales"
    t.integer  "agendamiento_id"
    t.integer  "persona_id"
    t.integer  "tipo_ficha_id"
    t.boolean  "es_cronica"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_calendario_vacunas", force: true do |t|
    t.integer  "vacuna_id"
    t.string   "edad"
    t.integer  "numero_vacuna"
    t.integer  "agno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_certificados", force: true do |t|
    t.text     "motivo"
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer  "atencion_salud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_ficha_tipos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_gestas", force: true do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.string   "desenlace"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_alcohol", force: true do |t|
    t.integer  "persona_id"
    t.datetime "fecha_test_audit"
    t.integer  "audit_1"
    t.integer  "audit_2"
    t.integer  "audit_3"
    t.integer  "audit_4"
    t.integer  "audit_5"
    t.integer  "audit_6"
    t.integer  "audit_7"
    t.integer  "audit_8"
    t.integer  "audit_9"
    t.integer  "audit_10"
    t.integer  "audit_puntaje"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_drogas", force: true do |t|
    t.integer  "persona_id"
    t.datetime "fecha_test_dast"
    t.string   "tipo_dast"
    t.integer  "dast_1"
    t.integer  "dast_2"
    t.integer  "dast_3"
    t.integer  "dast_4"
    t.integer  "dast_5"
    t.integer  "dast_6"
    t.integer  "dast_7"
    t.integer  "dast_8"
    t.integer  "dast_9"
    t.integer  "dast_10"
    t.integer  "dast_11"
    t.integer  "dast_12"
    t.integer  "dast_13"
    t.integer  "dast_14"
    t.integer  "dast_15"
    t.integer  "dast_16"
    t.integer  "dast_17"
    t.integer  "dast_19"
    t.integer  "dast_20"
    t.integer  "dast_puntaje"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_tabaco", force: true do |t|
    t.integer  "persona_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer  "cigarros_por_dia"
    t.decimal  "paquetes_agno",    precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_interconsultas", force: true do |t|
    t.integer  "persona_diagnostico_atencion_salud_id"
    t.datetime "fecha_solicitud"
    t.integer  "prestador_destino_id"
    t.integer  "especialidad_id"
    t.integer  "persona_conocimiento_id"
    t.integer  "proposito"
    t.text     "proposito_otro"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_metricas", force: true do |t|
    t.string   "nombre"
    t.string   "unidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_notificaciones_eno", force: true do |t|
    t.integer  "persona_diagnostico_atencion_salud_id"
    t.datetime "fecha_notificacion"
    t.datetime "fecha_primeros_sintomas"
    t.string   "confirmacion_diagnostica"
    t.string   "antecedentes_vacunacion"
    t.integer  "pais_contagio_id"
    t.string   "embarazo"
    t.integer  "semanas_gestacion"
    t.string   "tbc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_notificaciones_ges", force: true do |t|
    t.integer  "persona_diagnostico_atencion_salud_id"
    t.integer  "persona_conocimiento_id"
    t.string   "confirmacion_diagnostica"
    t.datetime "fecha_notificacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_actividad_fisica", force: true do |t|
    t.integer  "persona_id"
    t.string   "nivel_actividad"
    t.integer  "P1"
    t.integer  "P2"
    t.integer  "P3"
    t.integer  "P4"
    t.integer  "P5"
    t.integer  "P6"
    t.integer  "P7"
    t.integer  "P8"
    t.integer  "P9"
    t.integer  "P10"
    t.integer  "P11"
    t.integer  "P12"
    t.integer  "P13"
    t.integer  "P14"
    t.integer  "P15"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_diagnosticos", force: true do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer  "persona_id"
    t.integer  "diagnostico_id"
    t.integer  "estado_diagnostico_id"
    t.integer  "gesta_id"
    t.boolean  "es_cronica"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_diagnosticos_atenciones_salud", force: true do |t|
    t.integer  "prioridad"
    t.integer  "persona_diagnostico_id"
    t.integer  "atencion_salud_id"
    t.integer  "estado_diagnostico_id"
    t.text     "comentario"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.boolean  "es_cronica"
    t.boolean  "en_tratamiento"
    t.boolean  "primer_diagnostico"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_medicamentos", force: true do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer  "persona_id"
    t.integer  "medicamento_id"
    t.integer  "persona_diagnostico_id"
    t.integer  "atencion_salud_id"
    t.integer  "cantidad"
    t.integer  "periodicidad"
    t.integer  "duracion"
    t.integer  "total"
    t.integer  "persona_vacuna_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_metricas", force: true do |t|
    t.integer  "persona_id"
    t.integer  "metrica_id"
    t.integer  "atencion_salud_id"
    t.decimal  "valor",             precision: 10, scale: 0
    t.datetime "fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_prestaciones", force: true do |t|
    t.integer  "persona_id"
    t.integer  "prestacion_id"
    t.integer  "atencion_salud_id"
    t.integer  "prestador_id"
    t.datetime "fecha_prestacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_personas_alergias", force: true do |t|
    t.integer  "persona_id"
    t.integer  "alergia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_personas_vacunas", force: true do |t|
    t.integer  "persona_id"
    t.integer  "vacuna_id"
    t.datetime "fecha"
    t.integer  "numero_vacuna"
    t.integer  "atencion_salud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_alergias", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_componentes", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnostico_estados", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo_cie10"
    t.string   "descripcion"
    t.integer  "grupo_id"
    t.integer  "numero"
    t.boolean  "frecuente"
    t.boolean  "nodo_terminal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_bloques", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "capitulo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_capitulos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_grupos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "bloque_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_enfermedades_notificacion_obligatoria", force: true do |t|
    t.string   "nombre"
    t.integer  "diagnostico_id"
    t.string   "tipo_vigilancia"
    t.string   "frecuencia_notificacion"
    t.integer  "prioridad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_laboratorios", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "codigo_isp"
    t.integer  "cantidad"
    t.integer  "medicamento_tipo_id"
    t.integer  "laboratorio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_componentes", force: true do |t|
    t.decimal  "relacion",       precision: 10, scale: 0
    t.integer  "medicamento_id"
    t.integer  "componente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_metatipos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_tipos", force: true do |t|
    t.string   "unidad"
    t.integer  "medicamento_metatipo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones", force: true do |t|
    t.text     "nombre"
    t.text     "descripcion"
    t.string   "codigo_fonasa"
    t.integer  "subgrupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones_grupos", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones_subgrupos", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "grupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_problemas_salud_auge", force: true do |t|
    t.string   "nombre"
    t.integer  "diagnostico_id"
    t.integer  "edad_desde"
    t.integer  "edad_hasta"
    t.string   "genero"
    t.integer  "prioridad"
    t.datetime "fecha_inicio_auge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_vacunas", force: true do |t|
    t.string   "nombre"
    t.string   "protege_contra"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_vacunas_medicamentos", force: true do |t|
    t.integer  "vacuna_id"
    t.integer  "medicamento_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_grandes_grupos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_grupos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "gran_grupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_ocupaciones", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "subgrupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_personas_ocupaciones", force: true do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer  "persona_id"
    t.integer  "ocupacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_subgrupos", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "grupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_parentescos", force: true do |t|
    t.integer  "hijo_id"
    t.integer  "progenitor_id"
    t.integer  "gesta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas", force: true do |t|
    t.integer  "user_id"
    t.integer  "rut"
    t.string   "digito_verificador",      limit: 1
    t.string   "nombre"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "genero"
    t.string   "nivel_escolaridad"
    t.integer  "numero_personas_familia"
    t.datetime "fecha_nacimiento"
    t.datetime "fecha_muerte"
    t.integer  "diagnostico_muerte_id"
    t.string   "causa_muerte"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_direcciones", force: true do |t|
    t.integer  "persona_id"
    t.integer  "direccion_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_previsiones_salud", force: true do |t|
    t.integer  "persona_id"
    t.integer  "prevision_salud_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_telefonos", force: true do |t|
    t.integer  "persona_id"
    t.integer  "telefono_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_previsiones_salud", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestador_administrativos", force: true do |t|
    t.integer  "prestador_id"
    t.integer  "rol_administrativo_id"
    t.integer  "administrativo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestador_profesionales", force: true do |t|
    t.integer  "prestador_id"
    t.integer  "profesional_id"
    t.integer  "especialidad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores", force: true do |t|
    t.integer  "rut"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores_direcciones", force: true do |t|
    t.integer  "prestador_id"
    t.integer  "direccion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores_telefonos", force: true do |t|
    t.integer  "prestador_id"
    t.integer  "telefono_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_rol_administrativos", force: true do |t|
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_especialidades", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_instituciones", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_profesionales", force: true do |t|
    t.boolean  "validado"
    t.integer  "profesional_id"
    t.integer  "especialidad_id"
    t.integer  "institucion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_ciudades", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_comunas", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_direcciones", force: true do |t|
    t.string   "calle"
    t.integer  "numero"
    t.integer  "departamento"
    t.integer  "comuna_id"
    t.integer  "ciudad_id"
    t.integer  "pais_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_paises", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_regiones", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_regiones_comunas", force: true do |t|
    t.integer  "region_id"
    t.integer  "comuna_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_telefonos", force: true do |t|
    t.integer  "codigo"
    t.integer  "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
