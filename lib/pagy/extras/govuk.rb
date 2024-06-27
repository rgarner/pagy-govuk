# See the Pagy documentation: https://ddnexus.github.io/pagy/docs/extras/bootstrap
# frozen_string_literal: true

require 'pagy'

class Pagy # :nodoc:
  # Frontend modules are specially optimized for performance.
  # The resulting code may not look very elegant, but produces the best benchmarks
  module GovukExtra
    # Add default English translations to the I18n load_path. Copy the keys if you don't need this
    def self.add_default_i18n_load_path
      ::I18n.load_path += Dir[File.join(File.dirname(__FILE__), '../../../config/locales', '**', '*.{rb,yml}')]
    end

    # Pagination for GOV.UK adapted from Pagy's Bootstrap: it returns the html with the series of links to the pages
    def pagy_govuk_nav(pagy, id: nil, classes: '', aria_label: ::I18n.t('pagy.aria_label.nav'), **vars)
      id = %( id="#{id}") if id
      a  = pagy_anchor(pagy)

      html = <<~HTML
        <nav#{id} class="govuk-pagination" #{nav_aria_label(pagy, aria_label:)}>
          #{govuk_prev_html(pagy, a)}
          <ul class="govuk-pagination__list #{classes}">
      HTML
      pagy.series(**vars).each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
        html << case item
                when Integer
                  %(<li class="govuk-pagination__item">#{a.call(item,
                    classes: 'govuk-link govuk-pagination__link')}</li>)
                when String
                  %(<li class="govuk-pagination__item govuk-pagination__item--current"><a role="link" class="govuk-link govuk-pagination__link" aria-current="page" aria-disabled="true">#{
                    pagy.label_for(item)}</a></li>)
                when :gap
                  %(<li class="govuk-pagination__item "><a role="link" class="govuk-link govuk-pagination__link" aria-disabled="true">#{
                    ::I18n.t('pagy.gap')}</a></li>)
                else raise InternalError,
                  "expected item types in series to be Integer, String or :gap; got #{item.inspect}"
                end
      end
      html << %(</ul>#{govuk_next_html(pagy, a)}</nav>)
    end

    private

    def govuk_prev_html(pagy, a)
      if (p_prev = pagy.prev)
        %(<div class="govuk-pagination__prev">#{
          a.call(p_prev, ::I18n.t('pagy.prev'), classes: 'govuk-link govuk-pagination__link',
            aria_label: ::I18n.t('pagy.aria_label.prev'))}</div>)
      else
        ''
      end
    end

    def govuk_next_html(pagy, a)
      if (p_next = pagy.next)
        %(<div class="govuk-pagination__next">#{
          a.call(p_next, ::I18n.t('pagy.next'), classes: 'govuk-link govuk-pagination__link',
            aria_label: ::I18n.t('pagy.aria_label.next'))}</div>)
      else
        ''
      end
    end
  end

  Frontend.prepend GovukExtra
end
