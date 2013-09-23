namespace :neo4j do
  namespace :server do

    # Taken from https://github.com/maxdemarzi/neography/blob/master/lib/neography/tasks.rb (Unix)
    desc 'Install Neo4j server'
    task :install, :edition, :version do |t, args|
      args.with_defaults(:edition => 'community', :version => '2.0.0-M05')
      puts "Installing Neo4j-#{args[:edition]}-#{args[:version]}..."
      %x[curl -O http://dist.neo4j.org/neo4j-#{args[:edition]}-#{args[:version]}-unix.tar.gz]
      %x[tar -xvzf neo4j-#{args[:edition]}-#{args[:version]}-unix.tar.gz]
      %x[mv neo4j-#{args[:edition]}-#{args[:version]} neo4j]
      %x[rm neo4j-#{args[:edition]}-#{args[:version]}-unix.tar.gz]
      puts 'Neo4j Installed in to neo4j directory.'
    end

    desc 'Start Neo4j server'
    task :start do
      puts "Starting Neo4j..."
      %x[neo4j/bin/neo4j start]
    end

    desc 'Stop Neo4j server'
    task :stop do
      puts 'Stopping Neo4j...'
      %x[neo4j/bin/neo4j stop]
    end

    desc 'Restart Neo4j server'
    task :restart do
      puts 'Restarting Neo4j...'
      %x[neo4j/bin/neo4j restart]
    end

  end
end