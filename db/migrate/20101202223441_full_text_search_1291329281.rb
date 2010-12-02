class FullTextSearch1291329281 < ActiveRecord::Migration
  def self.up
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_fts_idx
      ON entries
      USING gin((setweight(to_tsvector('english', coalesce("entries"."title", '') || ' ' || coalesce("entries"."authors_string", '') || ' ' || coalesce("entries"."tags_string", '') || ' ' || coalesce("entries"."findings", '') || ' ' || coalesce("entries"."summary", '')), 'A') || ' ' || setweight(to_tsvector('english', coalesce("entries"."task_desc", '') || ' ' || coalesce("entries"."interface_desc", '') || ' ' || coalesce("entries"."env_desc", '') || ' ' || coalesce("entries"."systems_tech", '') || ' ' || coalesce("entries"."systems_desc", '') || ' ' || coalesce("entries"."comps_desc", '') || ' ' || coalesce("entries"."variables_desc", '') || ' ' || coalesce("entries"."constants", '') || ' ' || coalesce("entries"."issues", '') || ' ' || coalesce("entries"."other", '')), 'B') || ' ' || setweight(to_tsvector('english', coalesce("entries"."env_dim", '') || ' ' || coalesce("entries"."env_scale", '') || ' ' || coalesce("entries"."env_density", '') || ' ' || coalesce("entries"."env_realism", '') || ' ' || coalesce("entries"."part_gender", '') || ' ' || coalesce("entries"."part_background", '') || ' ' || coalesce("entries"."part_other", '') || ' ' || coalesce("entries"."exp_type", '')), 'C') || ' ' || to_tsvector('english', coalesce("entries"."specificity", ''))))
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_title_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_title_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."title", ''))))
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_author_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index entries_author_fts_idx
      ON entries
      USING gin((to_tsvector('english', coalesce("entries"."authors_string", ''))))
    eosql
  end

  def self.down
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_title_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS entries_author_fts_idx
    eosql
  end
end
