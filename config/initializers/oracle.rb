if Rails.env.oracle?
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
      self.emulate_integers_by_column_name = true
      self.emulate_dates_by_column_name = true
      self.emulate_booleans_from_strings = true

      # to ensure that sequences will start from 1 and without gaps
      self.default_sequence_start_value = "1 NOCACHE INCREMENT BY 1"

      self.string_to_date_format = "%Y.%m.%d"
      self.string_to_time_format = "%Y.%m.%d %H:%M:%S"

      # Cache column descriptions between requests.
      # Highly recommended as currently Arel is doing a lot of additional queries
      # to get table columns and primary key.
      # If this is used then you need to restart server in development environment
      # after running migrations which change table columns.
      # By default caching is enabled just in test and production environments.
      # ? 是否有意义
      if ['orcle', 'development', 'test', 'production'].include? Rails.env
        self.cache_columns = true
      end

    end

    # PL/SQL connection
    plsql.activerecord_class = ActiveRecord::Base

  end
end

