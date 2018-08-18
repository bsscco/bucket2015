class UsersController < ApplicationController
  before_action :set_user, only: [:show, :cards, :projects]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/cards
  def cards
    @page = @user.cards.page(params[:page]).per(10)
    @cards = @user.cards.order(created_at: :desc).page(@page.current_page).per(@page.limit_value)
  end

  # GET /users/1/projects
  def projects
    @page = @user.projects.page(params[:page]).per(10)
    @projects = @user.projects.order(created_at: :desc).page(@page.current_page).per(@page.limit_value)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
