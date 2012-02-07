module StoredProcedures
  class Lookup
    attr_reader :relevant_dbs

    def initialize
      @relevant_dbs = %w[Mongo Riak].select do |db|
        defined? db.constantize
      end
    end

    def find_procedures
      relevant_dbs.each do |db|
        directory = "#{Rails.root}/app/stored_procedures/#{db.downcase}"
        directory = Rails.root.join "app/stored_procedures/#{db.downcase}"

        if File.directory? directory
          Dir["#{directory}/*"].each do |procedure_dir|
            #procedure_dir = File.basename procedure_dir

            if File.exists?("#{procedure_dir}/map.js") and File.exists?("#{procedure_dir}/reduce.js")
              map_proc = File.read "#{procedure_dir}/map.js"
              reduce_proc = File.read "#{procedure_dir}/reduce.js"

              puts map_proc
              puts reduce_proc

              if db == "Mongo"
                #StoredProcedures.mongo_connection.eval "db.system.js.save()", {
                #  _id: "#{File.basename(procedure_dir)}_map",
                #  value: map_proc
                #}
                #
                #StoredProcedures.mongo_connection.eval "db.system.js.save()", {
                #  _id: "#{File.basename(procedure_dir)}_reduce",
                #  value: reduce_proc
                #}

                StoredProcedures.mongo_connection.eval <<-JS
                  db.system.js.save({
                    _id: "#{File.basename(procedure_dir)}_map",
                    value: #{map_proc}
                  })
                JS
              elsif db == "Riak"
                # TODO
              end
            end
          end
        end
      end
    end
  end
end