# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_01_28_211229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ag_accion_masiva", id: :serial, force: :cascade do |t|
    t.string "estado"
    t.integer "responsable_id"
    t.integer "especialidad_prestador_profesional_id"
    t.integer "total_agendamientos"
    t.integer "agendamientos_eliminados"
    t.integer "agendamientos_sin_eliminar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_prestador_profesional_id"], name: "index_ag_accion_masiva_on_especialidad_prestador_profesional_id"
    t.index ["responsable_id"], name: "index_ag_accion_masiva_on_responsable_id"
  end

  create_table "ag_agendamiento_estados", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ag_agendamiento_log_estados", id: :serial, force: :cascade do |t|
    t.integer "responsable_id"
    t.integer "agendamiento_estado_id"
    t.integer "agendamiento_id"
    t.datetime "fecha"
    t.index ["agendamiento_estado_id"], name: "index_ag_agendamiento_log_estados_on_agendamiento_estado_id"
    t.index ["agendamiento_id"], name: "index_ag_agendamiento_log_estados_on_agendamiento_id"
    t.index ["responsable_id"], name: "index_ag_agendamiento_log_estados_on_responsable_id"
  end

  create_table "ag_agendamientos", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "quien_pide_hora_id"
    t.datetime "fecha_comienzo"
    t.datetime "fecha_final"
    t.datetime "fecha_llegada_paciente"
    t.datetime "fecha_comienzo_real"
    t.datetime "fecha_final_real"
    t.integer "estado_id"
    t.integer "especialidad_prestador_profesional_id"
    t.integer "motivo_consulta"
    t.text "comentario_motivo"
    t.integer "persona_diagnostico_control_id"
    t.integer "capitulo_cie10_control_id"
    t.integer "accion_masiva_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accion_masiva_id"], name: "index_ag_agendamientos_on_accion_masiva_id"
    t.index ["capitulo_cie10_control_id"], name: "index_ag_agendamientos_on_capitulo_cie10_control_id"
    t.index ["especialidad_prestador_profesional_id"], name: "index_ag_agendamientos_on_especialidad_prestador_profesional_id"
    t.index ["estado_id"], name: "index_ag_agendamientos_on_estado_id"
    t.index ["persona_diagnostico_control_id"], name: "index_ag_agendamientos_on_persona_diagnostico_control_id"
    t.index ["persona_id"], name: "index_ag_agendamientos_on_persona_id"
    t.index ["quien_pide_hora_id"], name: "index_ag_agendamientos_on_quien_pide_hora_id"
  end

  create_table "fd_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "pieza_dental_id"
    t.integer "tipo_diagnostico_id"
    t.string "zona"
    t.datetime "fecha"
    t.integer "responsable_id"
    t.integer "atencion_salud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fd_diagnosticos_on_atencion_salud_id"
    t.index ["pieza_dental_id"], name: "index_fd_diagnosticos_on_pieza_dental_id"
    t.index ["responsable_id"], name: "index_fd_diagnosticos_on_responsable_id"
    t.index ["tipo_diagnostico_id"], name: "index_fd_diagnosticos_on_tipo_diagnostico_id"
  end

  create_table "fd_endodoncias", id: :serial, force: :cascade do |t|
    t.integer "atencion_salud_id"
    t.integer "pieza_dental_id"
    t.integer "comienzo_dolor"
    t.integer "dolor"
    t.integer "intensidad"
    t.boolean "es_pulsatil"
    t.boolean "cede_con_analgesicos"
    t.boolean "duele_al_acostarse"
    t.boolean "es_posible_senalar"
    t.boolean "se_genera_con_calor"
    t.boolean "se_genera_con_frio"
    t.boolean "se_genera_con_dulce"
    t.boolean "se_genera_al_masticar"
    t.text "informacion_adicional"
    t.text "examen_extraoral"
    t.text "examen_intraoral"
    t.text "examen_radiologico"
    t.text "comentario"
    t.integer "diagnostico_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fd_endodoncias_on_atencion_salud_id"
    t.index ["diagnostico_id"], name: "index_fd_endodoncias_on_diagnostico_id"
    t.index ["pieza_dental_id"], name: "index_fd_endodoncias_on_pieza_dental_id"
  end

  create_table "fd_glosas", id: :serial, force: :cascade do |t|
    t.integer "tratamiento_id"
    t.integer "precio_id"
    t.decimal "descuento", precision: 10, scale: 2
    t.integer "total"
    t.integer "presupuesto_id"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["precio_id"], name: "index_fd_glosas_on_precio_id"
    t.index ["presupuesto_id"], name: "index_fd_glosas_on_presupuesto_id"
    t.index ["tratamiento_id"], name: "index_fd_glosas_on_tratamiento_id"
  end

  create_table "fd_glosas_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "glosa_id"
    t.integer "diagnostico_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostico_id"], name: "index_fd_glosas_diagnosticos_on_diagnostico_id"
    t.index ["glosa_id"], name: "index_fd_glosas_diagnosticos_on_glosa_id"
  end

  create_table "fd_pagos", id: :serial, force: :cascade do |t|
    t.integer "presupuesto_id"
    t.integer "responsable_id"
    t.decimal "monto", precision: 10, scale: 2
    t.string "comentario"
    t.datetime "fecha_pago"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "numero"
    t.boolean "pagado", default: false
    t.index ["presupuesto_id"], name: "index_fd_pagos_on_presupuesto_id"
    t.index ["responsable_id"], name: "index_fd_pagos_on_responsable_id"
  end

  create_table "fd_periodoncia_indices", id: :serial, force: :cascade do |t|
    t.integer "periodoncia_id"
    t.integer "pieza_dental_id"
    t.integer "vestibular"
    t.integer "mesial"
    t.integer "palatino"
    t.integer "distal"
    t.string "indice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["periodoncia_id"], name: "index_fd_periodoncia_indices_on_periodoncia_id"
    t.index ["pieza_dental_id"], name: "index_fd_periodoncia_indices_on_pieza_dental_id"
  end

  create_table "fd_periodoncias", id: :serial, force: :cascade do |t|
    t.integer "atencion_salud_id"
    t.text "comentario"
    t.integer "diagnostico_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fd_periodoncias_on_atencion_salud_id"
    t.index ["diagnostico_id"], name: "index_fd_periodoncias_on_diagnostico_id"
  end

  create_table "fd_piezas_dentales", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "tipo_diente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fd_piezas_dentales_on_persona_id"
    t.index ["tipo_diente_id"], name: "index_fd_piezas_dentales_on_tipo_diente_id"
  end

  create_table "fd_precios", id: :serial, force: :cascade do |t|
    t.integer "tratamiento_id"
    t.integer "valor"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.boolean "activo"
    t.string "descripcion"
    t.integer "prestador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prestador_id"], name: "index_fd_precios_on_prestador_id"
    t.index ["tratamiento_id"], name: "index_fd_precios_on_tratamiento_id"
  end

  create_table "fd_presupuestos", id: :serial, force: :cascade do |t|
    t.integer "atencion_salud_id"
    t.string "estado"
    t.integer "valor"
    t.decimal "descuento", precision: 10, scale: 2
    t.integer "total"
    t.integer "pagado"
    t.integer "pendiente"
    t.integer "numero_cuotas", default: 3
    t.boolean "iguales", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fd_presupuestos_on_atencion_salud_id"
  end

  create_table "fd_test_diagnostico", id: :serial, force: :cascade do |t|
    t.integer "endodoncia_id"
    t.integer "pieza_dental_id"
    t.integer "calor"
    t.integer "electrico"
    t.integer "percusion"
    t.integer "palpacion"
    t.text "observacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endodoncia_id"], name: "index_fd_test_diagnostico_on_endodoncia_id"
    t.index ["pieza_dental_id"], name: "index_fd_test_diagnostico_on_pieza_dental_id"
  end

  create_table "fd_tipos_diagnosticos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fd_tipos_dientes", id: :serial, force: :cascade do |t|
    t.string "nomenclatura"
    t.integer "primer_digito"
    t.integer "segundo_digito"
    t.string "descripcion"
    t.string "tipo_denticion"
    t.integer "grupo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fd_tratamientos", id: :serial, force: :cascade do |t|
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fd_tratamientos_tipos_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "tratamiento_id"
    t.integer "tipo_diagnostico_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo_diagnostico_id"], name: "index_fd_tratamientos_tipos_diagnosticos_on_tipo_diagnostico_id"
    t.index ["tratamiento_id"], name: "index_fd_tratamientos_tipos_diagnosticos_on_tratamiento_id"
  end

  create_table "fi_atenciones_salud", id: :serial, force: :cascade do |t|
    t.text "motivo_consulta"
    t.text "examen_fisico"
    t.text "indicaciones_generales"
    t.text "anamnesis"
    t.integer "agendamiento_id"
    t.integer "persona_id"
    t.integer "tipo_ficha_id"
    t.boolean "es_cronica"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agendamiento_id"], name: "index_fi_atenciones_salud_on_agendamiento_id"
    t.index ["persona_id"], name: "index_fi_atenciones_salud_on_persona_id"
    t.index ["tipo_ficha_id"], name: "index_fi_atenciones_salud_on_tipo_ficha_id"
  end

  create_table "fi_calendario_vacunas", id: :serial, force: :cascade do |t|
    t.integer "vacuna_id"
    t.string "edad"
    t.integer "numero_vacuna"
    t.integer "agno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vacuna_id"], name: "index_fi_calendario_vacunas_on_vacuna_id"
  end

  create_table "fi_certificado_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "certificado_id"
    t.integer "persona_diagnostico_atencion_salud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificado_id"], name: "index_fi_certificado_diagnosticos_on_certificado_id"
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_ficd"
  end

  create_table "fi_certificados", id: :serial, force: :cascade do |t|
    t.string "tipo_reposo"
    t.integer "dias_reposo"
    t.datetime "control"
    t.datetime "alta"
    t.integer "atencion_salud_id"
    t.boolean "para_trabajo"
    t.boolean "para_colegio"
    t.boolean "para_juzgado"
    t.boolean "para_carabinero"
    t.boolean "para_otros"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fi_certificados_on_atencion_salud_id"
  end

  create_table "fi_ficha_tipos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fi_gestas", id: :serial, force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.string "desenlace"
    t.integer "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_gestas_on_persona_id"
  end

  create_table "fi_habitos_alcohol", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.datetime "fecha_test_audit"
    t.integer "audit_1"
    t.integer "audit_2"
    t.integer "audit_3"
    t.integer "audit_4"
    t.integer "audit_5"
    t.integer "audit_6"
    t.integer "audit_7"
    t.integer "audit_8"
    t.integer "audit_9"
    t.integer "audit_10"
    t.integer "audit_puntaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_habitos_alcohol_on_persona_id"
  end

  create_table "fi_habitos_alcohol_resumen", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.string "frecuencia"
    t.string "tipo"
    t.string "cantidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_habitos_alcohol_resumen_on_persona_id"
  end

  create_table "fi_habitos_drogas", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.datetime "fecha_test_dast"
    t.string "tipo_dast"
    t.integer "dast_1"
    t.integer "dast_2"
    t.integer "dast_3"
    t.integer "dast_4"
    t.integer "dast_5"
    t.integer "dast_6"
    t.integer "dast_7"
    t.integer "dast_8"
    t.integer "dast_9"
    t.integer "dast_10"
    t.integer "dast_11"
    t.integer "dast_12"
    t.integer "dast_13"
    t.integer "dast_14"
    t.integer "dast_15"
    t.integer "dast_16"
    t.integer "dast_17"
    t.integer "dast_19"
    t.integer "dast_20"
    t.integer "dast_puntaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_habitos_drogas_on_persona_id"
  end

  create_table "fi_habitos_tabaco", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer "cigarros_por_dia"
    t.decimal "paquetes_agno", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_habitos_tabaco_on_persona_id"
  end

  create_table "fi_interconsultas", id: :serial, force: :cascade do |t|
    t.integer "persona_diagnostico_atencion_salud_id"
    t.datetime "fecha_solicitud"
    t.integer "prestador_destino_id"
    t.integer "especialidad_id"
    t.integer "persona_conocimiento_id"
    t.integer "proposito"
    t.string "prestador_destino_texto"
    t.string "proposito_otro"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_id"], name: "index_fi_interconsultas_on_especialidad_id"
    t.index ["persona_conocimiento_id"], name: "index_fi_interconsultas_on_persona_conocimiento_id"
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_index"
    t.index ["prestador_destino_id"], name: "index_fi_interconsultas_on_prestador_destino_id"
  end

  create_table "fi_metricas", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "unidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fi_notificaciones_eno", id: :serial, force: :cascade do |t|
    t.integer "persona_diagnostico_atencion_salud_id"
    t.datetime "fecha_notificacion"
    t.datetime "fecha_primeros_sintomas"
    t.string "confirmacion_diagnostica"
    t.string "antecedentes_vacunacion"
    t.integer "pais_contagio_id"
    t.string "embarazo"
    t.integer "semanas_gestacion"
    t.string "tbc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pais_contagio_id"], name: "index_fi_notificaciones_eno_on_pais_contagio_id"
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_eno"
  end

  create_table "fi_notificaciones_ges", id: :serial, force: :cascade do |t|
    t.integer "persona_diagnostico_atencion_salud_id"
    t.integer "persona_conocimiento_id"
    t.string "confirmacion_diagnostica"
    t.datetime "fecha_notificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_conocimiento_id"], name: "index_fi_notificaciones_ges_on_persona_conocimiento_id"
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_fn"
  end

  create_table "fi_persona_actividad_fisica", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.string "nivel_actividad"
    t.integer "P1"
    t.integer "P2"
    t.integer "P3"
    t.integer "P4"
    t.integer "P5"
    t.integer "P6"
    t.integer "P7"
    t.integer "P8"
    t.integer "P9"
    t.integer "P10"
    t.integer "P11"
    t.integer "P12"
    t.integer "P13"
    t.integer "P14"
    t.integer "P15"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_persona_actividad_fisica_on_persona_id"
  end

  create_table "fi_persona_actividad_fisica_resumen", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.string "frecuencia"
    t.string "tiempo"
    t.string "intensidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_persona_actividad_fisica_resumen_on_persona_id"
  end

  create_table "fi_persona_antecedentes_ginecologicos", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.datetime "fecha_menarquia"
    t.datetime "fecha_menopausia"
    t.integer "duracion_menstruacion"
    t.integer "frecuencia_promedio"
    t.datetime "fecha_ultimo_PAP"
    t.datetime "fecha_ultima_mamografia"
    t.integer "numero_gestaciones"
    t.integer "numero_partos"
    t.integer "numero_abortos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_fi_persona_antecedentes_ginecologicos_on_persona_id"
  end

  create_table "fi_persona_diagnosticos", id: :serial, force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer "persona_id"
    t.integer "diagnostico_id"
    t.integer "estado_diagnostico_id"
    t.integer "gesta_id"
    t.boolean "es_cronica"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostico_id"], name: "index_fi_persona_diagnosticos_on_diagnostico_id"
    t.index ["estado_diagnostico_id"], name: "index_fi_persona_diagnosticos_on_estado_diagnostico_id"
    t.index ["gesta_id"], name: "index_fi_persona_diagnosticos_on_gesta_id"
    t.index ["persona_id"], name: "index_fi_persona_diagnosticos_on_persona_id"
  end

  create_table "fi_persona_diagnosticos_atenciones_salud", id: :serial, force: :cascade do |t|
    t.integer "prioridad"
    t.integer "persona_diagnostico_id"
    t.integer "atencion_salud_id"
    t.integer "estado_diagnostico_id"
    t.text "comentario"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.boolean "es_cronica"
    t.boolean "en_tratamiento"
    t.boolean "primer_diagnostico"
    t.boolean "es_antecedente"
    t.boolean "es_ultima_actualizacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "atencion_salud_index"
    t.index ["estado_diagnostico_id"], name: "estado_diagnostico_index"
    t.index ["persona_diagnostico_id"], name: "persona_diagnostico_index"
  end

  create_table "fi_persona_medicamento_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "persona_medicamento_id"
    t.integer "persona_diagnostico_atencion_salud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_fipmd"
    t.index ["persona_medicamento_id"], name: "persona_medicamento_index"
  end

  create_table "fi_persona_medicamentos", id: :serial, force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_final"
    t.integer "persona_id"
    t.integer "medicamento_id"
    t.integer "atencion_salud_id"
    t.integer "cantidad"
    t.integer "periodicidad"
    t.integer "duracion"
    t.integer "total"
    t.integer "persona_vacuna_id"
    t.boolean "es_antecedente"
    t.text "indicacion"
    t.integer "via_administracion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fi_persona_medicamentos_on_atencion_salud_id"
    t.index ["medicamento_id"], name: "index_fi_persona_medicamentos_on_medicamento_id"
    t.index ["persona_id"], name: "index_fi_persona_medicamentos_on_persona_id"
    t.index ["persona_vacuna_id"], name: "index_fi_persona_medicamentos_on_persona_vacuna_id"
  end

  create_table "fi_persona_metricas", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "metrica_id"
    t.integer "atencion_salud_id"
    t.decimal "valor", precision: 10, scale: 2
    t.datetime "fecha"
    t.text "caracteristica"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fi_persona_metricas_on_atencion_salud_id"
    t.index ["metrica_id"], name: "index_fi_persona_metricas_on_metrica_id"
    t.index ["persona_id"], name: "index_fi_persona_metricas_on_persona_id"
  end

  create_table "fi_persona_prestacion_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "persona_prestacion_id"
    t.integer "persona_diagnostico_atencion_salud_id"
    t.boolean "para_interconsulta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_fippd"
    t.index ["persona_prestacion_id"], name: "persona_prestacion_index"
  end

  create_table "fi_persona_prestaciones", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "prestacion_id"
    t.integer "atencion_salud_id"
    t.integer "prestador_id"
    t.string "prestador_texto"
    t.datetime "fecha_prestacion"
    t.boolean "es_antecedente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fi_persona_prestaciones_on_atencion_salud_id"
    t.index ["persona_id"], name: "index_fi_persona_prestaciones_on_persona_id"
    t.index ["prestacion_id"], name: "index_fi_persona_prestaciones_on_prestacion_id"
    t.index ["prestador_id"], name: "index_fi_persona_prestaciones_on_prestador_id"
  end

  create_table "fi_personas_alergias", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "alergia_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alergia_id"], name: "index_fi_personas_alergias_on_alergia_id"
    t.index ["persona_id"], name: "index_fi_personas_alergias_on_persona_id"
  end

  create_table "fi_personas_vacunas", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "vacuna_id"
    t.datetime "fecha"
    t.integer "numero_vacuna"
    t.integer "atencion_salud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_salud_id"], name: "index_fi_personas_vacunas_on_atencion_salud_id"
    t.index ["persona_id"], name: "index_fi_personas_vacunas_on_persona_id"
    t.index ["vacuna_id"], name: "index_fi_personas_vacunas_on_vacuna_id"
  end

  create_table "fi_reabrir_estado_diagnostico", id: :serial, force: :cascade do |t|
    t.integer "persona_diagnostico_atencion_salud_id"
    t.integer "estado_diagnostico_id"
    t.datetime "fecha_cambio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_diagnostico_id"], name: "index_fi_reabrir_estado_diagnostico_on_estado_diagnostico_id"
    t.index ["persona_diagnostico_atencion_salud_id"], name: "persona_diagnostico_at_sal_fired"
  end

  create_table "med_alergias", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.boolean "comun"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_componentes", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_diagnostico_estados", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_diagnosticos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo_cie10"
    t.string "descripcion"
    t.integer "grupo_id"
    t.integer "numero"
    t.boolean "frecuente"
    t.boolean "nodo_terminal"
    t.string "genero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_med_diagnosticos_on_grupo_id"
  end

  create_table "med_diagnosticos_bloques", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.integer "capitulo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["capitulo_id"], name: "index_med_diagnosticos_bloques_on_capitulo_id"
  end

  create_table "med_diagnosticos_capitulos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_diagnosticos_grupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.integer "bloque_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bloque_id"], name: "index_med_diagnosticos_grupos_on_bloque_id"
  end

  create_table "med_eno", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_eno_diagnostico", id: :serial, force: :cascade do |t|
    t.integer "eno_id"
    t.integer "diagnostico_id"
    t.string "tipo_vigilancia"
    t.string "frecuencia_notificacion"
    t.integer "prioridad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostico_id"], name: "index_med_eno_diagnostico_on_diagnostico_id"
    t.index ["eno_id"], name: "index_med_eno_diagnostico_on_eno_id"
  end

  create_table "med_laboratorios", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_medicamentos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.string "codigo_isp"
    t.integer "cantidad"
    t.boolean "es_nombre_farmaco"
    t.integer "medicamento_tipo_id"
    t.integer "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_med_medicamentos_on_laboratorio_id"
    t.index ["medicamento_tipo_id"], name: "index_med_medicamentos_on_medicamento_tipo_id"
  end

  create_table "med_medicamentos_componentes", id: :serial, force: :cascade do |t|
    t.decimal "relacion", precision: 10, scale: 2
    t.integer "medicamento_id"
    t.integer "componente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["componente_id"], name: "index_med_medicamentos_componentes_on_componente_id"
    t.index ["medicamento_id"], name: "index_med_medicamentos_componentes_on_medicamento_id"
  end

  create_table "med_medicamentos_metatipos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_medicamentos_tipos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "unidad"
    t.integer "medicamento_metatipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicamento_metatipo_id"], name: "index_med_medicamentos_tipos_on_medicamento_metatipo_id"
  end

  create_table "med_prestaciones", id: :serial, force: :cascade do |t|
    t.text "nombre"
    t.text "descripcion"
    t.string "codigo_fonasa"
    t.integer "subgrupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subgrupo_id"], name: "index_med_prestaciones_on_subgrupo_id"
  end

  create_table "med_prestaciones_grupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_prestaciones_subgrupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_med_prestaciones_subgrupos_on_grupo_id"
  end

  create_table "med_problemas_salud_auge", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.integer "edad_desde"
    t.integer "edad_hasta"
    t.datetime "fecha_inicio_auge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_problemas_salud_auge_diagnosticos", id: :serial, force: :cascade do |t|
    t.integer "diagnostico_id"
    t.integer "problema_salud_auge_id"
    t.integer "prioridad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostico_id"], name: "index_med_problemas_salud_auge_diagnosticos_on_diagnostico_id"
    t.index ["problema_salud_auge_id"], name: "problema_salud_auge_index"
  end

  create_table "med_vacunas", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "protege_contra"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "med_vacunas_medicamentos", id: :serial, force: :cascade do |t|
    t.integer "vacuna_id"
    t.integer "medicamento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicamento_id"], name: "index_med_vacunas_medicamentos_on_medicamento_id"
    t.index ["vacuna_id"], name: "index_med_vacunas_medicamentos_on_vacuna_id"
  end

  create_table "ocu_grandes_grupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ocu_grupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.integer "gran_grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gran_grupo_id"], name: "index_ocu_grupos_on_gran_grupo_id"
  end

  create_table "ocu_ocupaciones", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.integer "subgrupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subgrupo_id"], name: "index_ocu_ocupaciones_on_subgrupo_id"
  end

  create_table "ocu_personas_ocupaciones", id: :serial, force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.integer "persona_id"
    t.integer "ocupacion_id"
    t.boolean "es_actual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ocupacion_id"], name: "index_ocu_personas_ocupaciones_on_ocupacion_id"
    t.index ["persona_id"], name: "index_ocu_personas_ocupaciones_on_persona_id"
  end

  create_table "ocu_subgrupos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_ocu_subgrupos_on_grupo_id"
  end

  create_table "per_otras_relaciones", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "persona_relacion_id"
    t.string "relacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_per_otras_relaciones_on_persona_id"
    t.index ["persona_relacion_id"], name: "index_per_otras_relaciones_on_persona_relacion_id"
  end

  create_table "per_parentescos", id: :serial, force: :cascade do |t|
    t.integer "hijo_id"
    t.integer "progenitor_id"
    t.integer "gesta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gesta_id"], name: "index_per_parentescos_on_gesta_id"
    t.index ["hijo_id"], name: "index_per_parentescos_on_hijo_id"
    t.index ["progenitor_id"], name: "index_per_parentescos_on_progenitor_id"
  end

  create_table "per_personas", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "rut"
    t.string "digito_verificador", limit: 1
    t.string "nombre"
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.string "genero"
    t.string "nivel_escolaridad"
    t.integer "numero_personas_familia"
    t.datetime "fecha_nacimiento"
    t.datetime "fecha_muerte"
    t.integer "diagnostico_muerte_id"
    t.string "causa_muerte"
    t.integer "pais_nacionalidad_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostico_muerte_id"], name: "index_per_personas_on_diagnostico_muerte_id"
    t.index ["pais_nacionalidad_id"], name: "index_per_personas_on_pais_nacionalidad_id"
    t.index ["user_id"], name: "index_per_personas_on_user_id"
  end

  create_table "per_personas_direcciones", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "direccion_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["direccion_id"], name: "index_per_personas_direcciones_on_direccion_id"
    t.index ["persona_id"], name: "index_per_personas_direcciones_on_persona_id"
  end

  create_table "per_personas_previsiones_salud", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "prevision_salud_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_per_personas_previsiones_salud_on_persona_id"
    t.index ["prevision_salud_id"], name: "index_per_personas_previsiones_salud_on_prevision_salud_id"
  end

  create_table "per_personas_telefonos", id: :serial, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "telefono_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_per_personas_telefonos_on_persona_id"
    t.index ["telefono_id"], name: "index_per_personas_telefonos_on_telefono_id"
  end

  create_table "per_previsiones_salud", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pre_atenciones_pagadas", id: :serial, force: :cascade do |t|
    t.integer "agendamiento_id"
    t.integer "prestacion_id"
    t.integer "valor"
    t.integer "bonificacion_financiador"
    t.integer "aporte_seguro_complementario"
    t.integer "excedentes"
    t.integer "copago_beneficiario"
    t.datetime "fecha_pago"
    t.integer "monto_pago_profesional"
    t.integer "prevision_salud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agendamiento_id"], name: "index_pre_atenciones_pagadas_on_agendamiento_id"
    t.index ["prestacion_id"], name: "index_pre_atenciones_pagadas_on_prestacion_id"
    t.index ["prevision_salud_id"], name: "index_pre_atenciones_pagadas_on_prevision_salud_id"
  end

  create_table "pre_boletas", id: :serial, force: :cascade do |t|
    t.integer "especialidad_prestador_profesional_id"
    t.integer "responsable_id"
    t.integer "monto"
    t.string "estado"
    t.datetime "fecha"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_prestador_profesional_id"], name: "index_pre_boletas_on_especialidad_prestador_profesional_id"
    t.index ["responsable_id"], name: "index_pre_boletas_on_responsable_id"
  end

  create_table "pre_boletas_atenciones_pagadas", id: :serial, force: :cascade do |t|
    t.integer "boleta_id"
    t.integer "atencion_pagada_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atencion_pagada_id"], name: "index_pre_boletas_atenciones_pagadas_on_atencion_pagada_id"
    t.index ["boleta_id"], name: "index_pre_boletas_atenciones_pagadas_on_boleta_id"
  end

  create_table "pre_prestador_administrativos", id: :serial, force: :cascade do |t|
    t.integer "prestador_id"
    t.integer "rol_administrativo_id"
    t.integer "administrativo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrativo_id"], name: "index_pre_prestador_administrativos_on_administrativo_id"
    t.index ["prestador_id"], name: "index_pre_prestador_administrativos_on_prestador_id"
    t.index ["rol_administrativo_id"], name: "index_pre_prestador_administrativos_on_rol_administrativo_id"
  end

  create_table "pre_prestador_profesionales", id: :serial, force: :cascade do |t|
    t.integer "prestador_id"
    t.integer "profesional_id"
    t.integer "especialidad_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_id"], name: "index_pre_prestador_profesionales_on_especialidad_id"
    t.index ["prestador_id"], name: "index_pre_prestador_profesionales_on_prestador_id"
    t.index ["profesional_id"], name: "index_pre_prestador_profesionales_on_profesional_id"
  end

  create_table "pre_prestadores", id: :serial, force: :cascade do |t|
    t.integer "rut"
    t.string "nombre"
    t.boolean "es_centinela"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pre_prestadores_direcciones", id: :serial, force: :cascade do |t|
    t.integer "prestador_id"
    t.integer "direccion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["direccion_id"], name: "index_pre_prestadores_direcciones_on_direccion_id"
    t.index ["prestador_id"], name: "index_pre_prestadores_direcciones_on_prestador_id"
  end

  create_table "pre_prestadores_telefonos", id: :serial, force: :cascade do |t|
    t.integer "prestador_id"
    t.integer "telefono_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prestador_id"], name: "index_pre_prestadores_telefonos_on_prestador_id"
    t.index ["telefono_id"], name: "index_pre_prestadores_telefonos_on_telefono_id"
  end

  create_table "pre_regla_pagos", id: :serial, force: :cascade do |t|
    t.string "tipo"
    t.integer "prestador_id"
    t.integer "especialidad_prestador_profesional_id"
    t.decimal "porcentaje", precision: 10, scale: 2
    t.datetime "fecha_inicio"
    t.datetime "fecha_termino"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_prestador_profesional_id"], name: "index_pre_regla_pagos_on_especialidad_prestador_profesional_id"
    t.index ["prestador_id"], name: "index_pre_regla_pagos_on_prestador_id"
  end

  create_table "pre_rol_administrativos", id: :serial, force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pro_especialidades", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.integer "prestacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prestacion_id"], name: "index_pro_especialidades_on_prestacion_id"
  end

  create_table "pro_instituciones", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pro_profesionales", id: :serial, force: :cascade do |t|
    t.boolean "validado"
    t.integer "profesional_id"
    t.integer "especialidad_id"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_id"], name: "index_pro_profesionales_on_especialidad_id"
    t.index ["institucion_id"], name: "index_pro_profesionales_on_institucion_id"
    t.index ["profesional_id"], name: "index_pro_profesionales_on_profesional_id"
  end

  create_table "tra_ciudades", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tra_comunas", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tra_direcciones", id: :serial, force: :cascade do |t|
    t.string "calle"
    t.integer "numero"
    t.integer "departamento"
    t.integer "comuna_id"
    t.integer "ciudad_id"
    t.integer "pais_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ciudad_id"], name: "index_tra_direcciones_on_ciudad_id"
    t.index ["comuna_id"], name: "index_tra_direcciones_on_comuna_id"
    t.index ["pais_id"], name: "index_tra_direcciones_on_pais_id"
  end

  create_table "tra_paises", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tra_regiones", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tra_regiones_comunas", id: :serial, force: :cascade do |t|
    t.integer "region_id"
    t.integer "comuna_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comuna_id"], name: "index_tra_regiones_comunas_on_comuna_id"
    t.index ["region_id"], name: "index_tra_regiones_comunas_on_region_id"
  end

  create_table "tra_telefonos", id: :serial, force: :cascade do |t|
    t.integer "codigo"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
