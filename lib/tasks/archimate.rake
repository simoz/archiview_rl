namespace :archimate do
  desc "Copia lo schema di archimate per il database di test"
  task schema: :environment do
    source = Pathname(ENV.fetch("ARCHIMATE_PATH", Rails.root.join("../archimate").to_s)).join("db/schema.rb")
    abort "Schema di archimate non trovato: #{source}" unless source.file?

    FileUtils.cp source, Rails.root.join("db/schema.rb")
    puts "Copiato #{source}"
  end
end
