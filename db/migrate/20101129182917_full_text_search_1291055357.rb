class FullTextSearch1291055357 < ActiveRecord::Migration
  def self.up
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."title", '') || ' ' || coalesce("entries"."authors", '') || ' ' || coalesce("entries"."year", '') || ' ' || coalesce("entries"."task_desc", '') || ' ' || coalesce("entries"."interface_desc", '') || ' ' || coalesce("entries"."env_dim", '') || ' ' || coalesce("entries"."env_scale", '') || ' ' || coalesce("entries"."env_density", '') || ' ' || coalesce("entries"."env_realism", '') || ' ' || coalesce("entries"."env_desc", '') || ' ' || coalesce("entries"."part_gender", '') || ' ' || coalesce("entries"."part_background", '') || ' ' || coalesce("entries"."part_other", '') || ' ' || coalesce("entries"."exp_type", '') || ' ' || coalesce("entries"."systems", '') || ' ' || coalesce("entries"."systems_tech", '') || ' ' || coalesce("entries"."systems_desc", '') || ' ' || coalesce("entries"."comps", '') || ' ' || coalesce("entries"."comps_desc", '') || ' ' || coalesce("entries"."variables_desc", '') || ' ' || coalesce("entries"."constants", '') || ' ' || coalesce("entries"."findings", '') || ' ' || coalesce("entries"."specificity", '') || ' ' || coalesce("entries"."issues", '') || ' ' || coalesce("entries"."summary", '') || ' ' || coalesce("entries"."other", ''))))
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_author_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_author_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."authors", ''))))
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_year_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_year_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."year", ''))))
    eosql
  end

  def self.down
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_author_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_year_fts_idx
    eosql
  end
end
