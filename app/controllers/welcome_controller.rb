class WelcomeController < ApplicationController
    def index
      render json: { message: 'The Crafty-Carier Server is up and running. No issues whatsoever.' }
    end
  end