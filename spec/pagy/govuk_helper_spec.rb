require 'spec_helper'

RSpec.describe Pagy::GovukExtra, type: :helper do
  include Pagy::Backend   # For pagy()
  include Pagy::Frontend  # For things the helper uses like pagy_anchor
  include RSpecHtmlMatchers
  include FixtureDatabase

  describe '#pagy_govuk_nav' do
    before(:all) { create_fixture_database }

    after { BlogPost.destroy_all }

    let(:items) { 9 }

    let(:collection) do
      (1..items).each { |n| BlogPost.create! title: "Blog post number #{n}" }
      BlogPost.all
    end

    let(:request) { Rack::Request.new(Rack::MockRequest.env_for('http://localhost/foo', params: { page: 2 })) }
    let(:pagy_instance) { pagy(collection, items: 3, page:).first } # pagy(...) returns itself and the collection

    subject { pagy_govuk_nav(pagy_instance).tap { File.write('/tmp/test.html', _1) } }

    context 'on page 1' do
      let(:page) { 1 }

      it { is_expected.not_to have_tag('nav > div.govuk-pagination__prev') }
      it { is_expected.to have_tag('nav > div.govuk-pagination__next') }

      it {
        is_expected.to have_tag('nav.govuk-pagination[aria-label="Pagination"]') do
          with_tag('ul.govuk-pagination__list') do
            with_tag('li.govuk-pagination__item.govuk-pagination__item--current') do
              with_tag('a.govuk-pagination__link[aria-disabled="true"]', text: '1')
            end
          end
          with_tag('ul.govuk-pagination__list') do
            with_tag('li.govuk-pagination__item') do
              with_tag('a.govuk-pagination__link', text: '2')
            end
          end
          with_tag('ul.govuk-pagination__list') do
            with_tag('li.govuk-pagination__item') do
              with_tag('a.govuk-pagination__link', text: '3')
            end
          end
          with_tag('.govuk-pagination__next') do
            with_tag('.govuk-pagination__link[aria-label="Next page"]') do
              with_tag('.govuk-pagination__link-title') do
                with_tag('.govuk-visually-hidden', text: ' page')
              end
              with_tag('svg.govuk-pagination__icon--next')
            end
          end
        end
      }
    end

    context 'on page 2' do
      let(:page) { 2 }

      it { is_expected.to have_tag('nav > div.govuk-pagination__prev') }
      it { is_expected.to have_tag('nav > div.govuk-pagination__next') }
    end

    context 'on page 3' do
      let(:page) { 3 }

      it { is_expected.to have_tag('nav > div.govuk-pagination__prev') }
      it { is_expected.not_to have_tag('nav > div.govuk-pagination__next') }
    end
  end
end
