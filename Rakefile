task :enlighten_many do
  Dir.glob("koans/*") do |directory|
    cd directory do
      puts "running path to enlightenment for #{directory}"
      sh "ruby path_to_enlightenment.rb"
    end
  end
end
