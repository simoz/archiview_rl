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

ActiveRecord::Schema[8.1].define(version: 2026_10_02_171100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "unaccent"

  create_table "addresses", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.string "kind"
    t.string "name"
    t.text "description"
    t.string "street"
    t.string "postcode"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_addresses_on_agent_id"
  end

  create_table "aef_imports", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id"
    t.string "filename", null: false
    t.string "source", null: false
    t.string "checksum"
    t.integer "aef_version"
    t.string "attached_entity"
    t.string "producer"
    t.datetime "exported_at"
    t.string "status", default: "pending", null: false
    t.string "step"
    t.jsonb "stats", default: {}, null: false
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_aef_imports_on_user_id"
    t.index ["workspace_id"], name: "index_aef_imports_on_workspace_id"
  end

  create_table "agent_names", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.string "name", null: false
    t.string "name_type", default: "authorized", null: false
    t.boolean "preferred", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "patronymic"
    t.string "nickname"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_agent_names_on_agent_id"
  end

  create_table "agents", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "type", null: false
    t.boolean "authority", default: true, null: false
    t.string "name", null: false
    t.string "corporate_type"
    t.string "legal_status"
    t.string "residence"
    t.text "abstract"
    t.text "history"
    t.date "date_start"
    t.date "date_end"
    t.string "date_display"
    t.text "note"
    t.boolean "published", default: false, null: false
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "type", "name"], name: "index_agents_on_workspace_id_and_type_and_name"
    t.index ["workspace_id"], name: "index_agents_on_workspace_id"
  end

  create_table "alternative_titles", force: :cascade do |t|
    t.bigint "record_resource_id", null: false
    t.string "title", null: false
    t.string "qualifier"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_resource_id"], name: "index_alternative_titles_on_record_resource_id"
  end

  create_table "axf_exports", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id"
    t.string "scope", null: false
    t.bigint "root_ids", default: [], null: false, array: true
    t.string "title", null: false
    t.string "status", default: "pending", null: false
    t.string "step"
    t.jsonb "stats", default: {}, null: false
    t.bigint "file_size"
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_axf_exports_on_user_id"
    t.index ["workspace_id"], name: "index_axf_exports_on_workspace_id"
  end

  create_table "axf_imports", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id"
    t.string "filename", null: false
    t.string "checksum"
    t.integer "axf_version"
    t.uuid "origin_uuid"
    t.string "origin_name"
    t.string "scope"
    t.datetime "exported_at"
    t.string "status", default: "pending", null: false
    t.string "step"
    t.jsonb "stats", default: {}, null: false
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_axf_imports_on_user_id"
    t.index ["workspace_id"], name: "index_axf_imports_on_workspace_id"
  end

  create_table "cataloging_events", force: :cascade do |t|
    t.string "describable_type", null: false
    t.bigint "describable_id", null: false
    t.string "name", null: false
    t.string "qualifier"
    t.string "action"
    t.date "occurred_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["describable_type", "describable_id"], name: "index_cataloging_events_on_describable"
  end

  create_table "concepts", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "scheme", null: false
    t.string "label", null: false
    t.string "code"
    t.text "description"
    t.text "note"
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "scheme", "label"], name: "index_concepts_on_workspace_id_and_scheme_and_label", unique: true
    t.index ["workspace_id"], name: "index_concepts_on_workspace_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.string "kind", null: false
    t.string "value", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_contacts_on_agent_id"
  end

  create_table "date_ranges", force: :cascade do |t|
    t.string "dateable_type", null: false
    t.bigint "dateable_id", null: false
    t.boolean "preferred", default: true, null: false
    t.date "start_from"
    t.date "start_to"
    t.string "start_precision"
    t.string "start_qualifier"
    t.string "start_certainty"
    t.string "start_century_part"
    t.date "end_from"
    t.date "end_to"
    t.string "end_precision"
    t.string "end_qualifier"
    t.string "end_certainty"
    t.string "end_century_part"
    t.string "start_place"
    t.string "end_place"
    t.string "expression"
    t.string "edtf"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dateable_type", "dateable_id"], name: "index_date_ranges_on_dateable"
  end

  create_table "identifiers", force: :cascade do |t|
    t.string "identifiable_type", null: false
    t.bigint "identifiable_id", null: false
    t.string "kind", default: "identifier", null: false
    t.string "value", null: false
    t.string "scheme"
    t.string "qualifier"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifiable_type", "identifiable_id"], name: "index_identifiers_on_identifiable"
    t.index ["scheme", "value"], name: "index_identifiers_on_scheme_and_value"
  end

  create_table "instantiations", force: :cascade do |t|
    t.bigint "record_resource_id", null: false
    t.string "kind", null: false
    t.integer "position", default: 1, null: false
    t.string "carrier_type"
    t.string "medium"
    t.text "physical_description"
    t.string "container_type"
    t.string "container_title"
    t.string "container_number"
    t.string "preservation_state"
    t.text "preservation_note"
    t.text "restoration"
    t.string "damages", default: [], null: false, array: true
    t.string "title"
    t.text "description"
    t.string "asset_file_name"
    t.string "asset_content_type"
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.string "legacy_access_token"
    t.boolean "published", default: false, null: false
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_resource_id", "kind", "position"], name: "idx_on_record_resource_id_kind_position_4159e379bf"
    t.index ["record_resource_id"], name: "index_instantiations_on_record_resource_id"
  end

  create_table "legacy_records", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "aef_import_id"
    t.bigint "axf_import_id"
    t.string "source", null: false
    t.string "legacy_table", null: false
    t.string "legacy_id", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aef_import_id"], name: "index_legacy_records_on_aef_import_id"
    t.index ["axf_import_id"], name: "index_legacy_records_on_axf_import_id"
    t.index ["record_type", "record_id"], name: "index_legacy_records_on_record"
    t.index ["workspace_id", "source", "legacy_table", "legacy_id"], name: "index_legacy_records_uniqueness", unique: true
    t.index ["workspace_id"], name: "index_legacy_records_on_workspace_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "editor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_memberships_on_user_id"
    t.index ["workspace_id", "user_id"], name: "index_memberships_on_workspace_id_and_user_id", unique: true
    t.index ["workspace_id"], name: "index_memberships_on_workspace_id"
  end

  create_table "places", force: :cascade do |t|
    t.bigint "workspace_id"
    t.string "name", null: false
    t.string "qualifier"
    t.string "place_type"
    t.string "ancestry", default: "/", null: false, collation: "C"
    t.string "istat_code"
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.boolean "authority", default: true, null: false
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_places_on_ancestry", opclass: :varchar_pattern_ops
    t.index ["workspace_id", "name"], name: "index_places_on_workspace_id_and_name"
    t.index ["workspace_id"], name: "index_places_on_workspace_id"
  end

  create_table "project_participants", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "role", null: false
    t.string "qualifier"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_participants_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "name", null: false
    t.string "project_type"
    t.integer "start_year"
    t.integer "end_year"
    t.string "status"
    t.text "description"
    t.text "note"
    t.boolean "published", default: false, null: false
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_projects_on_workspace_id"
  end

  create_table "record_resources", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "type", null: false
    t.string "tier", null: false
    t.string "ancestry", null: false, collation: "C"
    t.integer "ancestry_depth", default: 0, null: false
    t.integer "position", null: false
    t.integer "children_count", default: 0, null: false
    t.bigint "root_id"
    t.string "title", null: false
    t.boolean "title_supplied", default: false, null: false
    t.string "level"
    t.integer "sequence_number"
    t.string "reference_number"
    t.integer "provisional_number"
    t.string "provisional_reference"
    t.string "folder_number"
    t.string "file_number"
    t.date "date_start"
    t.date "date_end"
    t.string "date_display"
    t.text "scope_content"
    t.text "abstract"
    t.text "archival_history"
    t.text "arrangement"
    t.text "related_materials"
    t.string "extent"
    t.decimal "linear_extent", precision: 10, scale: 2
    t.string "language_codes", default: [], null: false, array: true
    t.string "access_conditions"
    t.text "access_conditions_note"
    t.string "use_conditions"
    t.text "use_conditions_note"
    t.text "note"
    t.text "archivist_note"
    t.text "comments"
    t.boolean "published", default: false, null: false
    t.string "profile"
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry", "position"], name: "index_record_resources_on_ancestry_and_position"
    t.index ["ancestry"], name: "index_record_resources_on_ancestry", opclass: :varchar_pattern_ops
    t.index ["root_id", "tier"], name: "index_record_resources_on_root_id_and_tier"
    t.index ["workspace_id", "type"], name: "index_record_resources_on_workspace_id_and_type"
    t.index ["workspace_id"], name: "index_record_resources_on_workspace_id"
  end

  create_table "relations", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.string "predicate", null: false
    t.string "object_type", null: false
    t.bigint "object_id", null: false
    t.string "role"
    t.string "details"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_relations_on_object"
    t.index ["subject_type", "subject_id", "predicate", "object_type", "object_id"], name: "index_relations_uniqueness", unique: true
    t.index ["subject_type", "subject_id"], name: "index_relations_on_subject"
    t.index ["workspace_id"], name: "index_relations_on_workspace_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id"
    t.string "kind", null: false
    t.string "subject_type"
    t.bigint "subject_id"
    t.string "title", null: false
    t.jsonb "options", default: {}, null: false
    t.string "status", default: "pending", null: false
    t.integer "page_count"
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_type", "subject_id"], name: "index_reports_on_subject"
    t.index ["user_id"], name: "index_reports_on_user_id"
    t.index ["workspace_id"], name: "index_reports_on_workspace_id"
  end

  create_table "repository_profiles", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.string "custodian_type"
    t.string "contact_person"
    t.text "administrative_structure"
    t.text "collecting_policies"
    t.text "holdings"
    t.text "accessibility"
    t.text "services"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_repository_profiles_on_agent_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "solid_queue_batch_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.index ["batch_id"], name: "index_solid_queue_batch_executions_on_batch_id"
    t.index ["job_id"], name: "index_solid_queue_batch_executions_on_job_id", unique: true
  end

  create_table "solid_queue_batches", force: :cascade do |t|
    t.string "active_job_batch_id"
    t.string "description"
    t.text "on_finish"
    t.text "on_success"
    t.text "on_failure"
    t.text "metadata"
    t.integer "total_jobs", default: 0, null: false
    t.integer "completed_jobs", default: 0, null: false
    t.integer "failed_jobs", default: 0, null: false
    t.datetime "enqueued_at"
    t.datetime "finished_at"
    t.datetime "failed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_batch_id"], name: "index_solid_queue_batches_on_active_job_batch_id", unique: true
    t.index ["finished_at"], name: "index_solid_queue_batches_on_finished_at"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "batch_id"
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["batch_id"], name: "index_solid_queue_jobs_on_batch_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.string "key", null: false
    t.string "schedule", null: false
    t.string "command", limit: 2048
    t.string "class_name"
    t.text "arguments"
    t.string "queue_name"
    t.integer "priority", default: 0
    t.boolean "static", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "sources", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "source_type", null: false
    t.string "source_subtype"
    t.string "short_title", null: false
    t.string "author"
    t.text "title"
    t.string "editor"
    t.string "publisher"
    t.string "place"
    t.integer "year"
    t.string "date_string"
    t.text "related_item"
    t.string "related_item_specs"
    t.text "abstract"
    t.boolean "finding_aid_published"
    t.boolean "finding_aid_valid"
    t.text "legacy_description"
    t.text "legacy_notes"
    t.jsonb "legacy_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_sources_on_workspace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "username"
    t.boolean "superadmin", default: false, null: false
    t.string "theme", default: "classic", null: false
    t.string "locale", default: "it", null: false
    t.string "grid_columns", array: true
    t.jsonb "hidden_areas", default: {}, null: false
    t.datetime "deactivated_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((username)::text)", name: "index_users_on_lower_username", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "web_links", force: :cascade do |t|
    t.string "linkable_type", null: false
    t.bigint "linkable_id", null: false
    t.string "url", null: false
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_type", "linkable_id"], name: "index_web_links_on_linkable"
  end

  create_table "workspace_domains", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "host", null: false
    t.boolean "primary", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host"], name: "index_workspace_domains_on_host", unique: true
    t.index ["workspace_id"], name: "index_workspace_domains_on_primary_workspace_id", unique: true, where: "\"primary\""
    t.index ["workspace_id"], name: "index_workspace_domains_on_workspace_id"
  end

  create_table "workspace_images", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.integer "position", null: false
    t.string "caption"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "position"], name: "index_workspace_images_on_workspace_id_and_position"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "tagline"
    t.text "home_intro"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_workspaces_on_slug", unique: true
    t.index ["uuid"], name: "index_workspaces_on_uuid", unique: true
  end

  add_foreign_key "addresses", "agents", on_delete: :cascade
  add_foreign_key "aef_imports", "users"
  add_foreign_key "aef_imports", "workspaces"
  add_foreign_key "agent_names", "agents", on_delete: :cascade
  add_foreign_key "agents", "workspaces"
  add_foreign_key "alternative_titles", "record_resources", on_delete: :cascade
  add_foreign_key "axf_exports", "users", on_delete: :nullify
  add_foreign_key "axf_exports", "workspaces"
  add_foreign_key "axf_imports", "users", on_delete: :nullify
  add_foreign_key "axf_imports", "workspaces"
  add_foreign_key "concepts", "workspaces"
  add_foreign_key "contacts", "agents", on_delete: :cascade
  add_foreign_key "instantiations", "record_resources", on_delete: :cascade
  add_foreign_key "legacy_records", "aef_imports", on_delete: :nullify
  add_foreign_key "legacy_records", "axf_imports", on_delete: :nullify
  add_foreign_key "legacy_records", "workspaces"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships", "workspaces"
  add_foreign_key "places", "workspaces"
  add_foreign_key "project_participants", "projects", on_delete: :cascade
  add_foreign_key "projects", "workspaces"
  add_foreign_key "record_resources", "workspaces"
  add_foreign_key "relations", "workspaces"
  add_foreign_key "reports", "users", on_delete: :nullify
  add_foreign_key "reports", "workspaces"
  add_foreign_key "repository_profiles", "agents", on_delete: :cascade
  add_foreign_key "solid_queue_batch_executions", "solid_queue_batches", column: "batch_id", on_delete: :cascade
  add_foreign_key "solid_queue_batch_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "sources", "workspaces"
  add_foreign_key "workspace_domains", "workspaces", on_delete: :cascade
  add_foreign_key "workspace_images", "workspaces", on_delete: :cascade

  create_view "search_items", materialized: true, sql_definition: <<-SQL
      WITH RECURSIVE other_names AS (
           SELECT agent_names.agent_id,
              string_agg((agent_names.name)::text, ' '::text ORDER BY agent_names.id) AS names
             FROM agent_names
            WHERE (NOT agent_names.preferred)
            GROUP BY agent_names.agent_id
          ), record_agents AS (
           SELECT relations.subject_id AS record_resource_id,
              array_agg(DISTINCT agents.id) FILTER (WHERE ((relations.predicate)::text = 'has_creator'::text)) AS creator_ids,
              array_agg(DISTINCT agents.id) FILTER (WHERE ((relations.predicate)::text = 'has_holder'::text)) AS custodian_ids,
              array_agg(DISTINCT agents.id) FILTER (WHERE (NOT agents.authority)) AS heading_ids,
              string_agg(DISTINCT concat_ws(' '::text, agents.name, other_names.names), ' '::text) AS names
             FROM ((relations
               JOIN agents ON ((agents.id = relations.object_id)))
               LEFT JOIN other_names ON ((other_names.agent_id = agents.id)))
            WHERE (((relations.subject_type)::text = 'RecordResource'::text) AND ((relations.object_type)::text = 'Agent'::text) AND (agents.published OR (NOT agents.authority)))
            GROUP BY relations.subject_id
          ), visible_records AS (
           SELECT record_resources.id,
              (((record_resources.ancestry)::text || record_resources.id) || '/'::text) AS path,
              COALESCE(record_agents.creator_ids, '{}'::bigint[]) AS creator_ids,
              COALESCE(record_agents.custodian_ids, '{}'::bigint[]) AS custodian_ids
             FROM (record_resources
               LEFT JOIN record_agents ON ((record_agents.record_resource_id = record_resources.id)))
            WHERE (((record_resources.ancestry)::text = '/'::text) AND record_resources.published)
          UNION ALL
           SELECT record_resources.id,
              ((visible_records.path || record_resources.id) || '/'::text),
                  CASE
                      WHEN (record_agents.creator_ids IS NULL) THEN visible_records.creator_ids
                      ELSE ARRAY( SELECT DISTINCT unnest((visible_records.creator_ids || record_agents.creator_ids)) AS unnest
                        ORDER BY (unnest((visible_records.creator_ids || record_agents.creator_ids))))
                  END AS "array",
                  CASE
                      WHEN (record_agents.custodian_ids IS NULL) THEN visible_records.custodian_ids
                      ELSE ARRAY( SELECT DISTINCT unnest((visible_records.custodian_ids || record_agents.custodian_ids)) AS unnest
                        ORDER BY (unnest((visible_records.custodian_ids || record_agents.custodian_ids))))
                  END AS "array"
             FROM ((visible_records
               JOIN record_resources ON (((record_resources.ancestry)::text = visible_records.path)))
               LEFT JOIN record_agents ON ((record_agents.record_resource_id = record_resources.id)))
            WHERE record_resources.published
          ), digital_records AS (
           SELECT DISTINCT instantiations.record_resource_id
             FROM instantiations
            WHERE (((instantiations.kind)::text = 'digital'::text) AND (instantiations.asset_file_name IS NOT NULL) AND instantiations.published)
          )
   SELECT 'RecordResource'::text AS searchable_type,
      record_resources.id AS searchable_id,
      record_resources.workspace_id,
          CASE
              WHEN ((record_resources.tier)::text = 'aggregation'::text) THEN 'fonds'::text
              ELSE 'unit'::text
          END AS kind,
      record_resources.level,
      record_resources.root_id,
      record_resources.title,
      record_resources.date_display,
      (EXTRACT(year FROM record_resources.date_start))::integer AS start_year,
      (EXTRACT(year FROM record_resources.date_end))::integer AS end_year,
      (digital_records.record_resource_id IS NOT NULL) AS has_digital_object,
      visible_records.creator_ids,
      visible_records.custodian_ids,
      COALESCE(record_agents.heading_ids, '{}'::bigint[]) AS heading_ids,
      (((setweight(to_tsvector('italian'::regconfig, unaccent((record_resources.title)::text)), 'A'::"char") || setweight(to_tsvector('italian'::regconfig, unaccent(COALESCE(record_agents.names, ''::text))), 'B'::"char")) || setweight(to_tsvector('italian'::regconfig, unaccent((COALESCE(record_resources.reference_number, ''::character varying))::text)), 'C'::"char")) || setweight(to_tsvector('italian'::regconfig, unaccent(concat_ws(' '::text, record_resources.scope_content, record_resources.abstract, record_resources.archival_history, record_resources.arrangement, record_resources.note))), 'D'::"char")) AS tsv
     FROM (((visible_records
       JOIN record_resources ON ((record_resources.id = visible_records.id)))
       LEFT JOIN record_agents ON ((record_agents.record_resource_id = record_resources.id)))
       LEFT JOIN digital_records ON ((digital_records.record_resource_id = record_resources.id)))
  UNION ALL
   SELECT 'Agent'::text AS searchable_type,
      agents.id AS searchable_id,
      agents.workspace_id,
          CASE
              WHEN (repository_profiles.id IS NULL) THEN 'creator'::text
              ELSE 'custodian'::text
          END AS kind,
      NULL::character varying AS level,
      NULL::bigint AS root_id,
      agents.name AS title,
      agents.date_display,
      (EXTRACT(year FROM agents.date_start))::integer AS start_year,
      (EXTRACT(year FROM agents.date_end))::integer AS end_year,
      false AS has_digital_object,
          CASE
              WHEN (repository_profiles.id IS NULL) THEN ARRAY[agents.id]
              ELSE '{}'::bigint[]
          END AS creator_ids,
          CASE
              WHEN (repository_profiles.id IS NULL) THEN '{}'::bigint[]
              ELSE ARRAY[agents.id]
          END AS custodian_ids,
      '{}'::bigint[] AS heading_ids,
      (setweight(to_tsvector('italian'::regconfig, unaccent(concat_ws(' '::text, agents.name, other_names.names))), 'A'::"char") || setweight(to_tsvector('italian'::regconfig, unaccent(concat_ws(' '::text, agents.history, agents.abstract, agents.note))), 'D'::"char")) AS tsv
     FROM ((agents
       LEFT JOIN repository_profiles ON ((repository_profiles.agent_id = agents.id)))
       LEFT JOIN other_names ON ((other_names.agent_id = agents.id)))
    WHERE (agents.authority AND agents.published);
  SQL
  add_index "search_items", ["creator_ids"], name: "index_search_items_on_creator_ids", using: :gin
  add_index "search_items", ["custodian_ids"], name: "index_search_items_on_custodian_ids", using: :gin
  add_index "search_items", ["heading_ids"], name: "index_search_items_on_heading_ids", using: :gin
  add_index "search_items", ["root_id"], name: "index_search_items_on_root_id"
  add_index "search_items", ["searchable_type", "searchable_id"], name: "index_search_items_on_searchable_type_and_searchable_id", unique: true
  add_index "search_items", ["tsv"], name: "index_search_items_on_tsv", using: :gin
  add_index "search_items", ["workspace_id", "kind"], name: "index_search_items_on_workspace_id_and_kind"

end
