# frozen_string_literal: true

namespace :export do
  desc 'YAML Export'
  task yaml: :environment do
    stations = Station.all.map do |s|
      station = JSON.parse(s.to_json).symbolize_keys.except(:id, :created_at, :updated_at)
      station[:transmitters] = s.transmitters.order(frequency: :asc).all.map do |t|
        JSON.parse(t.to_json).symbolize_keys.except(:id, :station_id, :created_at, :updated_at)
      end
      station
    end

    stations.map do |s|
      title = s[:title].blank? ? 'null' : s[:title].downcase.gsub(/[^\da-z]/,'_')
      f = Rails.root.join('public', 'yaml', "#{title}.yml")
      File.open(f, 'w+') { |w| w.write(s.to_yaml) }
    end
  end
end
