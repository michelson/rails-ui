module RailsUi
  class PlaygroundController < ApplicationController
    def show
      @section = params[:section]
      render 'show'
    end
  end
end
