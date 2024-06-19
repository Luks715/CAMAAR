# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_222322) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classes", force: :cascade do |t|
    t.string "class_code", null: false
    t.string "semestre", null: false
    t.string "horario", null: false
    t.string "dicentes", default: [], array: true
    t.string "formularios", default: [], array: true
    t.bigint "docente_id", null: false
    t.bigint "disciplina_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disciplina_id"], name: "index_classes_on_disciplina_id"
    t.index ["docente_id"], name: "index_classes_on_docente_id"
  end

  create_table "dicentes", force: :cascade do |t|
    t.string "curso", null: false
    t.string "matricula", null: false
    t.string "classes", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dicentes_on_user_id"
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docentes", force: :cascade do |t|
    t.string "departamento", null: false
    t.string "formularios", default: [], array: true
    t.string "templates", default: [], array: true
    t.string "tipos", default: [], array: true
    t.string "classes", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_docentes_on_user_id"
  end

  create_table "formularios", force: :cascade do |t|
    t.date "dataDeTermino", null: false
    t.string "classes", default: [], array: true
    t.jsonb "resultados", default: {}
    t.bigint "docente_id", null: false
    t.bigint "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["docente_id"], name: "index_formularios_on_docente_id"
    t.index ["template_id"], name: "index_formularios_on_template_id"
  end

  create_table "questaos", force: :cascade do |t|
    t.string "pergunta", null: false
    t.string "alternativas", default: [], null: false, array: true
    t.decimal "pontos", precision: 10, scale: 2, null: false
    t.decimal "fatorDeCorrecao", precision: 10, scale: 2, default: "0.0", null: false
    t.string "alternativaCorreta", null: false
    t.bigint "tipo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo_id"], name: "index_questaos_on_tipo_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "nome", null: false
    t.string "questaos", default: [], null: false, array: true
    t.bigint "docente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["docente_id"], name: "index_templates_on_docente_id"
  end

  create_table "tipos", force: :cascade do |t|
    t.string "nome", null: false
    t.integer "numeroDeAlternativas", null: false
    t.boolean "discursiva?", null: false
    t.boolean "fatorDeCorrecao?", null: false
    t.bigint "docente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["docente_id"], name: "index_tipos_on_docente_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.string "usuario", null: false
    t.string "formacao", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "classes", "disciplinas"
  add_foreign_key "classes", "docentes"
  add_foreign_key "dicentes", "users"
  add_foreign_key "docentes", "users"
  add_foreign_key "formularios", "docentes"
  add_foreign_key "formularios", "templates"
  add_foreign_key "questaos", "tipos"
  add_foreign_key "templates", "docentes"
  add_foreign_key "tipos", "docentes"
end
