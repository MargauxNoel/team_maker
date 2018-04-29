class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end



  def distributionize(array, team_size, number_of_teams)
    number_of_teams.times do
      team = array.sample(team_size)
      puts "team##{number_of_teams} = #{team}"
      number_of_teams -= 1
    end
  end

end

players = ["Terrance", "Rex", "Walton", "Susannah", "Ivy", "Phil", "Lynda", "Krissy", "Leena", "Charlotte", "Edyth", "Tawana", "Leonel", "Leisa", "Martha", "Cammy", "Jeri", "Yevette", "George", "Cory", "Abby"]

distributionize(players)
