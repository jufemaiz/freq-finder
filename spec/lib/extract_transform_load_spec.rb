# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExtractTransformLoad do
  let(:time) { Time.parse('2019-01-01T00:00:00Z').utc }

  describe 'Class Constants' do
    describe '::BASE_DIR' do
      it 'is a directory' do
        expect(Dir.exist?(ExtractTransformLoad::BASE_DIR)).to eq(true)
      end
    end

    describe '::EXCLUDE_KEYS' do
      it 'excludes ids and timestamps' do
        expect(ExtractTransformLoad::EXCLUDE_KEYS)
          .to include(:id, :station_id, :created_at, :updated_at)
      end
    end

    describe '::EXPORT_SUBDIR' do
      it 'is a valid strftime value' do
        expect { Time.now.utc.strftime(ExtractTransformLoad::EXPORT_SUBDIR) }
          .not_to raise_error(TypeError)
      end
    end
  end

  describe '.export!' do
    before(:each) { Timecop.freeze(time) }

    after(:each) do
      # Delete the files
      export_dir = ExtractTransformLoad::BASE_DIR.join('20190101T000000Z')
      FileUtils.rm_r(export_dir, force: true)
      # Return time
      Timecop.return
    end

    context 'nothing in the database' do
      it 'exports no files' do
        ExtractTransformLoad.export!

        export_dir = ExtractTransformLoad::BASE_DIR.join('20190101T000000Z')
        files = Dir.entries(export_dir)
                   .reject { |f| File.directory?(File.join(export_dir, f)) }

        expect(files.count.zero?).to eq(true)
      end
    end

    context 'one station in database' do
      before(:each) { FactoryBot.create(:station) }

      it 'exports a single file' do
        ExtractTransformLoad.export!

        export_dir = ExtractTransformLoad::BASE_DIR.join('20190101T000000Z')
        files = Dir.entries(export_dir)
                   .reject { |f| File.directory?(File.join(export_dir, f)) }

        expect(files.count).to eq(1)
      end
    end

    context 'many stations in database' do
      before(:each) { FactoryBot.create_list(:station, 10) }

      it 'exports a single file' do
        ExtractTransformLoad.export!

        export_dir = ExtractTransformLoad::BASE_DIR.join('20190101T000000Z')
        files = Dir.entries(export_dir)
                   .reject { |f| File.directory?(File.join(export_dir, f)) }

        expect(files.count).to eq(10)
      end
    end
  end

  describe '.export_subdirectory' do
    before(:each) { Timecop.freeze(time) }
    after(:each) { Timecop.return }

    it 'uses time for the subdirectory' do
      expect(ExtractTransformLoad.export_subdirectory)
        .to eq(time.strftime('%Y%m%dT%H%M%SZ'))
    end
  end

  describe '.import!' do
    it 'imports the stations' do
      ExtractTransformLoad.import!

      expect(Station.count.zero?).to eq(false)
    end

    it 'imports the transmitters' do
      ExtractTransformLoad.import!

      expect(Transmitter.count.zero?).to eq(false)
    end
  end
end
