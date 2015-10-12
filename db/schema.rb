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

ActiveRecord::Schema.define(version: 20150827013308) do

  create_table "ag_accion_masiva", force: :cascade do |t|
    t.string   "estado",                                limit: 255
    t.integer  "responsable_id",                        limit: 4
    t.integer  "especialidad_prestador_profesional_id", limit: 4
    t.integer  "total_agendamientos",                   limit: 4
    t.integer  "agendamientos_cancelados",              limit: 4
    t.integer  "agendamientos_sin_cancelar",            limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "ag_agendamiento_estados", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ag_agendamiento_log_estados", force: :cascade do |t|
    t.integer  "responsable_id",         limit: 4
    t.integer  "agendamiento_estado_id", limit: 4
    t.integer  "agendamiento_id",        limit: 4
    t.datetime "fecha"
  end

  create_table "ag_agendamientos", force: :cascade do |t|
    t.integer  "persona_id",                            limit: 4
    t.integer  "quien_pide_hora_id",                    limit: 4
    t.datetime "fecha_comienzo"
    t.datetime "fecha_final"
    t.datetime "fecha_llegada_paciente"
    t.datetime "fecha_comienzo_real"
    t.datetime "fecha_final_real"
    t.integer  "agendamiento_estado_id",                limit: 4
    t.integer  "especialidad_prestador_profesional_id", limit: 4
    t.boolean  "motivo_consulta_nuevo"
    t.integer  "persona_diagnostico_control_id",        limit: 4
    t.integer  "capitulo_cie10_control_id",             limit: 4
    t.integer  "accion_masiva_id",                      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_atenciones_salud", force: :cascade do |t|
    t.text     "motivo_consulta",        limit: 65535
    t.text     "examen_fisico",          limit: 65535
    t.text     "indicaciones_generales", limit: 65535
    t.text     "anamnesis",              limit: 65535
    t.integer  "agendamiento_id",        limit: 4
    t.integer  "persona_id",             limit: 4
    t.integer  "tipo_ficha_id",          limit: 4
    t.boolean  "es_cronica"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_calendario_vacunas", force: :cascade do |t|
    t.integer  "vacuna_id",     limit: 4
    t.string   "edad",          limit: 255
    t.integer  "numero_vacuna", limit: 4
    t.integer  "agno",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_certificado_diagnosticos", force: :cascade do |t|
    t.integer  "certificado_id",                        limit: 4
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "fi_certificados", force: :cascade do |t|
    t.string   "tipo_reposo",       limit: 255
    t.integer  "dias_reposo",       limit: 4
    t.datetime "control"
    t.datetime "alta"
    t.integer  "atencion_salud_id", limit: 4
    t.boolean  "para_trabajo"
    t.boolean  "para_colegio"
    t.boolean  "para_juzgado"
    t.boolean  "para_carabinero"
    t.boolean  "para_otros"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_ficha_tipos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_gestas", force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.string   "desenlace",     limit: 255
    t.integer  "persona_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_alcohol", force: :cascade do |t|
    t.integer  "persona_id",       limit: 4
    t.datetime "fecha_test_audit"
    t.integer  "audit_1",          limit: 4
    t.integer  "audit_2",          limit: 4
    t.integer  "audit_3",          limit: 4
    t.integer  "audit_4",          limit: 4
    t.integer  "audit_5",          limit: 4
    t.integer  "audit_6",          limit: 4
    t.integer  "audit_7",          limit: 4
    t.integer  "audit_8",          limit: 4
    t.integer  "audit_9",          limit: 4
    t.integer  "audit_10",         limit: 4
    t.integer  "audit_puntaje",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_drogas", force: :cascade do |t|
    t.integer  "persona_id",      limit: 4
    t.datetime "fecha_test_dast"
    t.string   "tipo_dast",       limit: 255
    t.integer  "dast_1",          limit: 4
    t.integer  "dast_2",          limit: 4
    t.integer  "dast_3",          limit: 4
    t.integer  "dast_4",          limit: 4
    t.integer  "dast_5",          limit: 4
    t.integer  "dast_6",          limit: 4
    t.integer  "dast_7",          limit: 4
    t.integer  "dast_8",          limit: 4
    t.integer  "dast_9",          limit: 4
    t.integer  "dast_10",         limit: 4
    t.integer  "dast_11",         limit: 4
    t.integer  "dast_12",         limit: 4
    t.integer  "dast_13",         limit: 4
    t.integer  "dast_14",         limit: 4
    t.integer  "dast_15",         limit: 4
    t.integer  "dast_16",         limit: 4
    t.integer  "dast_17",         limit: 4
    t.integer  "dast_19",         limit: 4
    t.integer  "dast_20",         limit: 4
    t.integer  "dast_puntaje",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_habitos_tabaco", force: :cascade do |t|
    t.integer  "persona_id",       limit: 4
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer  "cigarros_por_dia", limit: 4
    t.decimal  "paquetes_agno",              precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_interconsultas", force: :cascade do |t|
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.datetime "fecha_solicitud"
    t.integer  "prestador_destino_id",                  limit: 4
    t.integer  "especialidad_id",                       limit: 4
    t.integer  "persona_conocimiento_id",               limit: 4
    t.integer  "proposito",                             limit: 4
    t.string   "prestador_destino_texto",               limit: 255
    t.string   "proposito_otro",                        limit: 255
    t.text     "comentario",                            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_metricas", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "unidad",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_notificaciones_eno", force: :cascade do |t|
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.datetime "fecha_notificacion"
    t.datetime "fecha_primeros_sintomas"
    t.string   "confirmacion_diagnostica",              limit: 255
    t.string   "antecedentes_vacunacion",               limit: 255
    t.integer  "pais_contagio_id",                      limit: 4
    t.string   "embarazo",                              limit: 255
    t.integer  "semanas_gestacion",                     limit: 4
    t.string   "tbc",                                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_notificaciones_ges", force: :cascade do |t|
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.integer  "persona_conocimiento_id",               limit: 4
    t.string   "confirmacion_diagnostica",              limit: 255
    t.datetime "fecha_notificacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_actividad_fisica", force: :cascade do |t|
    t.integer  "persona_id",      limit: 4
    t.string   "nivel_actividad", limit: 255
    t.integer  "P1",              limit: 4
    t.integer  "P2",              limit: 4
    t.integer  "P3",              limit: 4
    t.integer  "P4",              limit: 4
    t.integer  "P5",              limit: 4
    t.integer  "P6",              limit: 4
    t.integer  "P7",              limit: 4
    t.integer  "P8",              limit: 4
    t.integer  "P9",              limit: 4
    t.integer  "P10",             limit: 4
    t.integer  "P11",             limit: 4
    t.integer  "P12",             limit: 4
    t.integer  "P13",             limit: 4
    t.integer  "P14",             limit: 4
    t.integer  "P15",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_antecedentes_ginecologicos", force: :cascade do |t|
    t.integer  "persona_id",              limit: 4
    t.datetime "fecha_menarquia"
    t.datetime "fecha_menopausia"
    t.integer  "duracion_menstruacion",   limit: 4
    t.integer  "frecuencia_promedio",     limit: 4
    t.datetime "fecha_ultimo_PAP"
    t.datetime "fecha_ultima_mamografia"
    t.integer  "numero_gestaciones",      limit: 4
    t.integer  "numero_partos",           limit: 4
    t.integer  "numero_abortos",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_diagnosticos", force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer  "persona_id",            limit: 4
    t.integer  "diagnostico_id",        limit: 4
    t.integer  "estado_diagnostico_id", limit: 4
    t.integer  "gesta_id",              limit: 4
    t.boolean  "es_cronica"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_diagnosticos_atenciones_salud", force: :cascade do |t|
    t.integer  "prioridad",              limit: 4
    t.integer  "persona_diagnostico_id", limit: 4
    t.integer  "atencion_salud_id",      limit: 4
    t.integer  "estado_diagnostico_id",  limit: 4
    t.text     "comentario",             limit: 65535
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.boolean  "es_cronica"
    t.boolean  "en_tratamiento"
    t.boolean  "primer_diagnostico"
    t.boolean  "es_antecedente"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_medicamentos", force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer  "persona_id",             limit: 4
    t.integer  "medicamento_id",         limit: 4
    t.integer  "persona_diagnostico_id", limit: 4
    t.integer  "atencion_salud_id",      limit: 4
    t.integer  "cantidad",               limit: 4
    t.integer  "periodicidad",           limit: 4
    t.integer  "duracion",               limit: 4
    t.integer  "total",                  limit: 4
    t.integer  "persona_vacuna_id",      limit: 4
    t.boolean  "es_antecedente"
    t.text     "indicacion",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_metricas", force: :cascade do |t|
    t.integer  "persona_id",        limit: 4
    t.integer  "metrica_id",        limit: 4
    t.integer  "atencion_salud_id", limit: 4
    t.decimal  "valor",                           precision: 10, scale: 2
    t.datetime "fecha"
    t.text     "caracteristica",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_persona_prestacion_diagnosticos", force: :cascade do |t|
    t.integer  "persona_prestacion_id",                 limit: 4
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.boolean  "para_interconsulta"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "fi_persona_prestaciones", force: :cascade do |t|
    t.integer  "persona_id",        limit: 4
    t.integer  "prestacion_id",     limit: 4
    t.integer  "atencion_salud_id", limit: 4
    t.integer  "prestador_id",      limit: 4
    t.string   "prestador_texto",   limit: 255
    t.datetime "fecha_prestacion"
    t.boolean  "es_antecedente"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_personas_alergias", force: :cascade do |t|
    t.integer  "persona_id", limit: 4
    t.integer  "alergia_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_personas_vacunas", force: :cascade do |t|
    t.integer  "persona_id",        limit: 4
    t.integer  "vacuna_id",         limit: 4
    t.datetime "fecha"
    t.integer  "numero_vacuna",     limit: 4
    t.integer  "atencion_salud_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fi_reabrir_estado_diagnostico", force: :cascade do |t|
    t.integer  "persona_diagnostico_atencion_salud_id", limit: 4
    t.integer  "estado_diagnostico_id",                 limit: 4
    t.datetime "fecha_cambio"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "med_alergias", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.boolean  "comun"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_componentes", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnostico_estados", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos", force: :cascade do |t|
    t.string   "nombre",        limit: 255
    t.string   "codigo_cie10",  limit: 255
    t.string   "descripcion",   limit: 255
    t.integer  "grupo_id",      limit: 4
    t.integer  "numero",        limit: 4
    t.boolean  "frecuente"
    t.boolean  "nodo_terminal"
    t.string   "genero",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_bloques", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "codigo",      limit: 255
    t.integer  "capitulo_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_capitulos", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "codigo",      limit: 255
    t.string   "descripcion", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_diagnosticos_grupos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "codigo",     limit: 255
    t.integer  "bloque_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_eno", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "med_eno_diagnostico", force: :cascade do |t|
    t.integer  "eno_id",                  limit: 4
    t.integer  "diagnostico_id",          limit: 4
    t.string   "tipo_vigilancia",         limit: 255
    t.string   "frecuencia_notificacion", limit: 255
    t.integer  "prioridad",               limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "med_laboratorios", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos", force: :cascade do |t|
    t.string   "nombre",              limit: 255
    t.string   "descripcion",         limit: 255
    t.string   "codigo_isp",          limit: 255
    t.integer  "cantidad",            limit: 4
    t.integer  "medicamento_tipo_id", limit: 4
    t.integer  "laboratorio_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_componentes", force: :cascade do |t|
    t.decimal  "relacion",                 precision: 10, scale: 2
    t.integer  "medicamento_id", limit: 4
    t.integer  "componente_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_metatipos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_medicamentos_tipos", force: :cascade do |t|
    t.string   "nombre",                  limit: 255
    t.string   "unidad",                  limit: 255
    t.integer  "medicamento_metatipo_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones", force: :cascade do |t|
    t.text     "nombre",        limit: 65535
    t.text     "descripcion",   limit: 65535
    t.string   "codigo_fonasa", limit: 255
    t.integer  "subgrupo_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones_grupos", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.text     "descripcion", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_prestaciones_subgrupos", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.text     "descripcion", limit: 65535
    t.integer  "grupo_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_problemas_salud_auge", force: :cascade do |t|
    t.string   "nombre",            limit: 255
    t.integer  "edad_desde",        limit: 4
    t.integer  "edad_hasta",        limit: 4
    t.datetime "fecha_inicio_auge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_problemas_salud_auge_diagnosticos", force: :cascade do |t|
    t.integer  "diagnostico_id",         limit: 4
    t.integer  "problema_salud_auge_id", limit: 4
    t.integer  "prioridad",              limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "med_vacunas", force: :cascade do |t|
    t.string   "nombre",         limit: 255
    t.string   "protege_contra", limit: 255
    t.string   "tipo",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_vacunas_medicamentos", force: :cascade do |t|
    t.integer  "vacuna_id",      limit: 4
    t.integer  "medicamento_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_grandes_grupos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "codigo",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_grupos", force: :cascade do |t|
    t.string   "nombre",        limit: 255
    t.string   "codigo",        limit: 255
    t.integer  "gran_grupo_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_ocupaciones", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "codigo",      limit: 255
    t.integer  "subgrupo_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_personas_ocupaciones", force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer  "persona_id",    limit: 4
    t.integer  "ocupacion_id",  limit: 4
    t.boolean  "es_actual"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocu_subgrupos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "codigo",     limit: 255
    t.integer  "grupo_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_otras_relaciones", force: :cascade do |t|
    t.integer  "persona_id",          limit: 4
    t.integer  "persona_relacion_id", limit: 4
    t.string   "relacion",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_parentescos", force: :cascade do |t|
    t.integer  "hijo_id",       limit: 4
    t.integer  "progenitor_id", limit: 4
    t.integer  "gesta_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.integer  "rut",                     limit: 4
    t.string   "digito_verificador",      limit: 1
    t.string   "nombre",                  limit: 255
    t.string   "apellido_paterno",        limit: 255
    t.string   "apellido_materno",        limit: 255
    t.string   "genero",                  limit: 255
    t.string   "nivel_escolaridad",       limit: 255
    t.integer  "numero_personas_familia", limit: 4
    t.datetime "fecha_nacimiento"
    t.datetime "fecha_muerte"
    t.integer  "diagnostico_muerte_id",   limit: 4
    t.string   "causa_muerte",            limit: 255
    t.integer  "pais_nacionalidad_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_direcciones", force: :cascade do |t|
    t.integer  "persona_id",    limit: 4
    t.integer  "direccion_id",  limit: 4
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_previsiones_salud", force: :cascade do |t|
    t.integer  "persona_id",         limit: 4
    t.integer  "prevision_salud_id", limit: 4
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_personas_telefonos", force: :cascade do |t|
    t.integer  "persona_id",  limit: 4
    t.integer  "telefono_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_previsiones_salud", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_atenciones_pagadas", force: :cascade do |t|
    t.integer  "agendamiento_id",              limit: 4
    t.integer  "prestacion_id",                limit: 4
    t.integer  "valor",                        limit: 4
    t.integer  "bonificacion_financiador",     limit: 4
    t.integer  "aporte_seguro_complementario", limit: 4
    t.integer  "excedentes",                   limit: 4
    t.integer  "copago_beneficiario",          limit: 4
    t.datetime "fecha_pago"
    t.integer  "monto_pago_profesional",       limit: 4
    t.integer  "prevision_salud_id",           limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "pre_boletas", force: :cascade do |t|
    t.integer  "especialidad_prestador_profesional_id", limit: 4
    t.integer  "responsable_id",                        limit: 4
    t.integer  "monto",                                 limit: 4
    t.string   "estado",                                limit: 255
    t.datetime "fecha"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "pre_boletas_atenciones_pagadas", force: :cascade do |t|
    t.integer  "boleta_id",          limit: 4
    t.integer  "atencion_pagada_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pre_prestador_administrativos", force: :cascade do |t|
    t.integer  "prestador_id",          limit: 4
    t.integer  "rol_administrativo_id", limit: 4
    t.integer  "administrativo_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestador_profesionales", force: :cascade do |t|
    t.integer  "prestador_id",    limit: 4
    t.integer  "profesional_id",  limit: 4
    t.integer  "especialidad_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores", force: :cascade do |t|
    t.integer  "rut",          limit: 4
    t.string   "nombre",       limit: 255
    t.boolean  "es_centinela"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores_direcciones", force: :cascade do |t|
    t.integer  "prestador_id", limit: 4
    t.integer  "direccion_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_prestadores_telefonos", force: :cascade do |t|
    t.integer  "prestador_id", limit: 4
    t.integer  "telefono_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_regla_pagos", force: :cascade do |t|
    t.string   "tipo",                                  limit: 255
    t.integer  "prestador_id",                          limit: 4
    t.integer  "especialidad_prestador_profesional_id", limit: 4
    t.decimal  "porcentaje",                                        precision: 10, scale: 2
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
  end

  create_table "pre_rol_administrativos", force: :cascade do |t|
    t.text     "nombre",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_especialidades", force: :cascade do |t|
    t.string   "nombre",        limit: 255
    t.integer  "prestacion_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_instituciones", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pro_profesionales", force: :cascade do |t|
    t.boolean  "validado"
    t.integer  "profesional_id",  limit: 4
    t.integer  "especialidad_id", limit: 4
    t.integer  "institucion_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_ciudades", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_comunas", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_direcciones", force: :cascade do |t|
    t.string   "calle",        limit: 255
    t.integer  "numero",       limit: 4
    t.integer  "departamento", limit: 4
    t.integer  "comuna_id",    limit: 4
    t.integer  "ciudad_id",    limit: 4
    t.integer  "pais_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_paises", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_regiones", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_regiones_comunas", force: :cascade do |t|
    t.integer  "region_id",  limit: 4
    t.integer  "comuna_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tra_telefonos", force: :cascade do |t|
    t.integer  "codigo",     limit: 4
    t.integer  "numero",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
