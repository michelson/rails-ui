# frozen_string_literal: true

module RailsUi
  class PlaygroundController < ApplicationController
    include RailsUi::ApplicationHelper
    def index
      @section = 'accordion'
      render 'show'
    end

    def show
      @section = params[:section]
      render 'show'
    end
  end
end
