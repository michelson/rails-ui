# frozen_string_literal: true

require 'rails_helper'

describe ContextMenu::Component do
  let(:options) { {} }
  let(:component) { ContextMenu::Component.new(**options) }

  subject { rendered_component }

  it 'renders' do
    render_inline(component)

    is_expected.to have_css 'div'
  end
end
