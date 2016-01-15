class MonstersController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  respond_to :json, :html

  def index
    @monsters = current_user.monsters.includes(:team).references(:teams)

    # Sorting
    @sort_col = params[:sort_col].in?(%w[power element weakness LOWER(teams.name)]) ? params[:sort_col] : "LOWER(monsters.name)"
    @sort_dir = params[:sort_dir] == "desc" ? "desc" : "asc"
    @monsters = if @sort_col == "weakness"
      @monsters.sort { |a, b| @sort_dir == "asc" ? a.weakness <=> b.weakness : b.weakness <=> a.weakness }
    else
      @monsters.order("#{@sort_col} #{@sort_dir}")
    end
  end

  def show
  end

  def new
    @monster = current_user.monsters.new
  end

  def edit
  end

  def create
    @monster = current_user.monsters.new(monster_params)

    respond_to do |format|
      if @monster.save
        format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
        format.json { render :show, status: :created, location: @monster }
      else
        format.html { render :new }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster }
      else
        format.html { render :edit }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster = current_user.monsters.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_params
      params.require(:monster).permit(:name, :power, :element, :team_id)
    end

end
