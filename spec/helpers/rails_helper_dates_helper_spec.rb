require 'rails_helper'

RSpec.describe DatesHelper, type: :helper do
  describe '#friendly_date' do
    describe 'today' do
      it "returns today's date" do
        today = Time.zone.today
        expect(
          helper.friendly_date(today)
        ).to eq("today at #{today.strftime('%l:%M %p')}")
      end
    end

    describe 'yesterday' do
      it "returns yesterday's date" do
        yesterday = Time.zone.today - 1
        expect(
          helper.friendly_date(yesterday)
        ).to eq("yesterday at #{yesterday.strftime('%l:%M %p')}")
      end
    end

    describe 'other date' do
      it "returns the date in the format 'Month day, Year'" do
        date = Time.zone.today - 2
        expect(
          helper.friendly_date(date)
        ).to eq("#{date.strftime('%B %e, %Y')} at #{date.strftime('%l:%M %p')}")
      end
    end
  end

  describe '#format_date' do
    it "returns the date in the format 'Month day, Year'" do
      date = Time.zone.today - 2
      expect(
        helper.format_date(date)
      ).to eq(date.strftime('%B %e, %Y'))
    end
  end
end
