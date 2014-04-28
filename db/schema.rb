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

ActiveRecord::Schema.define(version: 20140420073640) do

  create_table "ag_agendamiento_estados", force: true do |t|
    t.text     "nombre"
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
    t.datetime "fecha_comienzo"
    t.datetime "fecha_final"
    t.datetime "fecha_comienzo_real"
    t.datetime "fecha_final_real"
    t.datetime "fecha_llegada_paciente"
    t.integer  "persona_id"
    t.integer  "agendamiento_estado_id"
    t.integer  "especialidad_prestador_profesional_id"
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
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_gestas", force: true do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.text     "desenlace"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_interconsultas", force: true do |t|
    t.text     "motivo"
    t.integer  "prestador_destino_id"
    t.integer  "atencion_salud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_metricas", force: true do |t|
    t.text     "nombre"
    t.text     "unidad"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_diagnosticos_atenciones_salud", force: true do |t|
    t.integer  "prioridad"
    t.integer  "persona_diagnostico_id"
    t.integer  "atencion_salud_id"
    t.integer  "estado_diagnostico_id"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_examenes", force: true do |t|
    t.integer  "persona_id"
    t.integer  "examen_id"
    t.integer  "atencion_salud_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_metricas", force: true do |t|
    t.integer  "persona_id"
    t.integer  "metrica_id"
    t.integer  "atencion_salud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnostico_estados", force: true do |t|
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos", force: true do |t|
    t.text     "nombre"
    t.text     "codigo_cie10"
    t.text     "descripcion"
    t.integer  "grupo_id"
    t.integer  "numero"
    t.boolean  "frecuente"
    t.boolean  "nodo_terminal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_examenes", force: true do |t|
    t.text     "nombre"
    t.text     "descripcion"
    t.text     "indicaciones"
    t.text     "codigo_isapre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_grupos", force: true do |t|
    t.text     "codigo"
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos", force: true do |t|
    t.text     "nombre"
    t.text     "descripcion"
    t.text     "principio_activo"
    t.text     "codigo"
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
    t.string   "nombre"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "genero"
    t.datetime "fecha_nacimiento"
    t.datetime "fecha_muerte"
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

  create_table "pre_rol_administrativos", force: true do |t|
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_especialidades", force: true do |t|
    t.text     "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_instituciones", force: true do |t|
    t.text     "nombre"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
