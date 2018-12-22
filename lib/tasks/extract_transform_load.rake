# frozen_string_literal: true

namespace :extract_transform_load do
  namespace :export do
    desc 'YAML Export'
    task yaml: :environment do
      ExtractTransformLoad.export
    end
  end

  namespace :import do
    desc 'YAML import'
    task yaml: :environment do
      ExtractTransformLoad.import
    end
  end
end
