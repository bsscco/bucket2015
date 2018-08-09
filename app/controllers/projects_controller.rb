class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new
    @project.user = current_user
    @project.title = params[:project][:title];
    project_cards_params = params[:project][:project_cards];
    project_cards_params.each do |project_card_params|
      if project_card_params[1][:card_id] == "0"
        new_card = Card.new(img: project_card_params[1][:img], content: project_card_params[1][:content])
        new_card.user = current_user;
        new_card.save
        new_project_card = ProjectCard.new
        new_project_card.card_id = new_card.id;
        new_project_card.position = project_card_params[1][:position];
        new_project_card.content = new_card.content;
        @project.project_cards.push new_project_card
      else
        new_project_card = ProjectCard.new
        new_project_card.card_id = project_card_params[1][:card_id];
        new_project_card.position = project_card_params[1][:position];
        new_project_card.content = project_card_params[1][:content];
        @project.project_cards.push new_project_card
      end
    end

    respond_to do |format|
      if @project.save
        format.html {redirect_to @project, notice: 'Project was successfully created.'}
        format.json {render :show, status: :created, location: @project}
      else
        format.html {render :new}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project.title = params[:project][:title];
    project_cards_params = params[:project][:project_cards];
    project_cards_params.each do |project_card_params|
      if project_card_params[1][:id] && project_card_params[1][:id] != "0"
        project_card = @project.project_cards.find_by(id: project_card_params[1][:id])
        project_card.position = project_card_params[1][:position]
        project_card.content = project_card_params[1][:content]
        project_card.save
      elsif project_card_params[1][:card_id] == "0"
        new_card = Card.new(img: project_card_params[1][:img], content: project_card_params[1][:content])
        new_card.user = current_user;
        new_card.save
        new_project_card = ProjectCard.new
        new_project_card.card_id = new_card.id;
        new_project_card.position = project_card_params[1][:position];
        new_project_card.content = new_card.content;
        @project.project_cards.push new_project_card
      else
        new_project_card = ProjectCard.new
        new_project_card.card_id = project_card_params[1][:card_id];
        new_project_card.position = project_card_params[1][:position];
        new_project_card.content = project_card_params[1][:content];
        @project.project_cards.push new_project_card
      end
    end

    respond_to do |format|
      if @project.save
        format.html {redirect_to @project, notice: 'Project was successfully updated.'}
        format.json {render :show, status: :ok, location: @project}
      else
        format.html {render :edit}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html {redirect_to projects_url, notice: 'Project was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def project_params
  #   params.require(:project).permit(:title, project_cards: [:card_id, :content])
  # end
end
