ActiveRecord::Schema.define(version: 20_201_129_161_129) do
  enable_extension 'plpgsql'

  create_table 'chat_messages', force: :cascade do |t|
    t.bigint 'travel_id', null: false
    t.bigint 'user_id', null: false
    t.text 'message'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['travel_id'], name: 'index_chat_messages_on_travel_id'
    t.index ['user_id'], name: 'index_chat_messages_on_user_id'
  end

  create_table 'destinations', force: :cascade do |t|
    t.float 'longitude'
    t.float 'latitude'
    t.string 'address'
    t.bigint 'travel_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['travel_id'], name: 'index_destinations_on_travel_id'
  end

  create_table 'origins', force: :cascade do |t|
    t.float 'longitude'
    t.float 'latitude'
    t.string 'address'
    t.bigint 'travel_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['travel_id'], name: 'index_origins_on_travel_id'
  end

  create_table 'participants', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'travel_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['travel_id'], name: 'index_participants_on_travel_id'
    t.index ['user_id'], name: 'index_participants_on_user_id'
  end

  create_table 'travels', force: :cascade do |t|
    t.bigint 'owner_id'
    t.datetime 'departure_time'
    t.integer 'capacity'
    t.text 'owner_comment'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'periodicity'
    t.index ['owner_id'], name: 'index_travels_on_owner_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'avatar'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'chat_messages', 'travels'
  add_foreign_key 'chat_messages', 'users'
  add_foreign_key 'destinations', 'travels'
  add_foreign_key 'origins', 'travels'
  add_foreign_key 'participants', 'travels'
  add_foreign_key 'participants', 'users'
  add_foreign_key 'travels', 'users', column: 'owner_id'
end
