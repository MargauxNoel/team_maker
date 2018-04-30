class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    @team.save
    redirect_to team_path(@team)
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.update(params[:team])
    redirect_to team_path(@team)
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to team_path(@team)
  end

  def get_players_total
    puts "How many players in the game?"
    # players_total = 21
  end

  def get_number_of_teams
    puts "How many teams do you want to do?"
    #number_of_teams = 7
  end

  def get_team_size(players_total, number_of_teams)
    modulo = (players_total % number_of_teams)
    if modulo == 0
    team_size = (players_total / number_of_teams).to_i
    return team_size
    else
      size_min = (players_total / number_of_teams).to_i
      size_max = ((players_total / number_of_teams).to_i) + 1
      coef_min = (players_total - (modulo * size_max)) / size_min
      coef_max = modulo
      return team_size = [size_min, size_max, coef_min, coef_max, modulo]
    end
  end

  def hashify(number_of_teams)
    teams = Hash.new
    number_of_teams.times do
      teams[number_of_teams] = Array.new
      number_of_teams -= 1
    end
    return teams
  end

  def distributionize(array, number_of_teams)

    team_size = get_team_size(array.size, number_of_teams.to_i)
    teams_final = hashify(number_of_teams)

    # CASE1: ALL TEAMS HAVE THE SAME SIZE
    if team_size.class == Integer
      return harmonize(array, number_of_teams)

    # CASE2: TEAMS HAVE DIFFERENT SIZES
    elsif team_size.class == Array
      return spreadify(array, number_of_teams)
    end
  end

  def harmonize(array, number_of_teams)
    # CASE1: ALL TEAMS HAVE THE SAME SIZE
    team_size = get_team_size(array.size, number_of_teams.to_i)
    teams_final = hashify(number_of_teams)

    array.each do |player|
      team_number = rand(1..number_of_teams)
      p team_number
      if teams_final[team_number].size < team_size # && teams_final[team_number]include? player.partner == false
        teams_final[team_number] << player
        p teams_final[team_number]
      else
        new_team_number = rand(1..number_of_teams)
        while new_team_number == team_number || teams_final[new_team_number].size >= team_size # || player.partner == true
          new_team_number = rand(1..number_of_teams)
        end
        p new_team_number
        teams_final[new_team_number] << player
        p teams_final[new_team_number]
      end
    end
    p teams_final
  end

  def spreadify(array, number_of_teams)
    # CASE2: TEAMS HAVE DIFFERENT SIZES
    team_size = get_team_size(array.size, number_of_teams.to_i)
      team_size_min = team_size[0].to_i
      team_size_max = team_size[1].to_i
      coef_min = team_size[2].to_i
      coef_max = team_size[3].to_i
      modulo = team_size[4].to_i
      counter = 0
      rest = []
    teams_final = hashify(number_of_teams)
    puts "min_size = #{team_size[0]}, max_size = #{team_size[1]}"
    puts "let's make #{team_size[2]} teams of #{team_size[0]} players and #{team_size[3]} of #{team_size[1]} players"
    puts "modulo = #{modulo}"

    array.each do |player|
      if (array.size - counter) <= modulo #once have all the same number of players, we had the remaining ones in another array.
        rest << player
      else
        p team_number = rand(1..number_of_teams)
        if teams_final[team_number].size < team_size_min
          teams_final[team_number] << player
          p teams_final[team_number]
        else
          new_team_number = rand(1..number_of_teams)
          while new_team_number == team_number || teams_final[new_team_number].size >= team_size_min
            new_team_number = rand(1..number_of_teams)
          end
          p new_team_number
          teams_final[new_team_number] << player
          p teams_final[new_team_number]
        end
      end
      counter += 1
    end
    puts "rest = #{rest}"

    rest.each do |player| # the remaining players are added randomly and equally to teams.
      p team_number = rand(1..number_of_teams)
        if teams_final[team_number].size < team_size_max
          teams_final[team_number] << player
        end
    end
    return teams_final
  end

  private

  def team_params
    params.require(:team).permit(:size)
  end

end




players = ["Terrance", "Rex", "Walton", "Susannah", "Ivy", "Phil", "Lynda", "Krissy", "Leena", "Charlotte", "Edyth", "Tawana", "Leonel", "Leisa", "Martha", "Cammy", "Jeri", "Yevette", "George", "Cory", "Abby"]

distributionize(players)
