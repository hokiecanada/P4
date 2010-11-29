class FullTextSearch1291050099 < ActiveRecord::Migration
  def self.up
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."title", '') || ' ' || coalesce("entries"."summary", ''))))
    eosql
  end

  def self.down
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
  end
end
