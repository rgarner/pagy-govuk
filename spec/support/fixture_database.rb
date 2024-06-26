# frozen_string_literal: true

require 'sqlite3'
require 'active_record'

class BlogPost < ActiveRecord::Base
end

module FixtureDatabase
  def create_fixture_database
    config = YAML.safe_load(
      <<~YAML
        adapter: sqlite3
        database: ":memory:"
        pool: 5
        timeout: 5000
      YAML
    )

    ActiveRecord::Base.establish_connection(config)
    SQLite3::Database.open(config['database'])

    ActiveRecord::Migration.suppress_messages do
      load_schema
    end
  end

  def load_schema
    ActiveRecord::Schema.define do
      create_table 'blog_posts', force: :cascade do |t|
        t.string 'title'
      end

      create_table 'schema_migrations', force: :cascade
    end
  end
end
