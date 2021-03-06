require 'spec_helper'

describe SeedFu::Seeder do
  context 'in regular seed' do
    it 'should run single seeds' do
      SeededModel.seed(:title) do |s|
        s.title = 'Foo'
        s.login = 'Foo'
        s.first_name = 'Bar'
      end

      expect(SeededModel.count).to eq(1)
    end

    it 'should run multiple seeds' do
      SeededModel.seed(:title,
                       { title: 'Foo', login: 'Foo', first_name: 'Foo' },
                       title: 'Bar', login: 'Bar', first_name: 'Bar')

      expect(SeededModel.count).to eq(2)
    end
  end

  context 'in unseed' do
    before do
      SeedFuNdo.send(:class_variable_set, :@@recorder, SeedFuNdo::Recorder.new)
    end

    context 'for single seeds' do
      before do
        SeededModel.seed(:title) do |s|
          s.title = 'Foo'
          s.login = 'Foo'
          s.first_name = 'Bar'
        end
      end

      it 'should only record' do
        expect(SeededModel.count).to eq(0)
      end

      it 'should ignore non-existing records' do
        unseed
        expect(SeededModel.count).to eq(0)
      end

      it 'should unseed existing records' do
        SeededModel.create!(title: 'Foo')
        unseed
        expect(SeededModel.count).to eq(0)
      end

      it 'should find existing records' do
        rec = SeededModel.create!(title: 'Foo')
        expect(SeedFuNdo.recorder.seeders.first.existing_records).to eq([rec])
      end
    end

    context 'for multiple seeds' do
      before do
        SeededModel.seed(:title,
                         { title: 'Foo', login: 'Foo', first_name: 'Foo' },
                         title: 'Bar', login: 'Bar', first_name: 'Bar')
      end

      it 'should only record' do
        expect(SeededModel.count).to eq(0)
      end

      it 'should rollback if one record cannot be destroyed' do
        SeededModel.create!(title: 'Foo', fail_to_destroy: true)
        SeededModel.create!(title: 'Bar')
        expect { unseed }.to raise_error(ActiveRecord::ActiveRecordError)
        expect(SeededModel.count).to eq(2)
      end
    end
  end
end

def unseed
  SeedFuNdo.recorder.seeders.reverse.each(&:unseed)
end
