module ActiveRecord
  class Base
    def self.delete_all_with_reset_pk_sequence
      delete_all
      case ActiveRecord::Base.connection.adapter_name
      when 'SQLite'
        new_max = maximum(primary_key) || 0
        update_seq_sql = "update sqlite_sequence set seq = #{new_max} where name = '#{table_name}';"
        ActiveRecord::Base.connection.execute(update_seq_sql)
      when 'PostgreSQL'
        ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      end
    end
  end
end
