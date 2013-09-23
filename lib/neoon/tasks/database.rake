namespace :neo4j do
  namespace :db do

    namespace :index do
      desc 'Index/reindex the nodes'
      task :build do
      end

      desc 'Remove nodes indexing'
      task :destroy do
      end
    end

  end
end
