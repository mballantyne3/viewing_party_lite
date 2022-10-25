class PartiesController < ApplicationController

  def index

  end

  def new
    @user = User.find(params[:user_id])
    @users = User.all
    @movie = MovieFacade.find(params[:movie_id])
  end

  def create
    @user = User.find(params[:user_id])
    @movie = MovieFacade.find(params[:movie_id])

    if params[:duration].to_i < @movie.runtime
      flash[:alert] = "Error: Duration is less than movie duration"
    elsif parse_date_params <= Time.now
      flash[:alert] = "Error: Please pick a time in the future"
    elsif params[:user_ids].keys == []
      flash[:alert] = "Error: Please select users to invite"
    else
      @party = Party.new(party_params)
      @party.movie_poster_url = @movie.poster
      @party.save!

      PartyUser.create!(party: @party, user_id: params[:user_id])
      invited = params[:user_ids].keys
      invited.each do |user|
        PartyUser.create!(party_id: @party.id, user_id: user)
      end
    end

    redirect_to '/dashboard'
  end

  def parse_date_params
    DateTime.new(params["start_time(1i)"].to_i,
      params["start_time(2i)"].to_i,
      params["start_time(3i)"].to_i,
      params["start_time(4i)"].to_i,
      params["start_time(5i)"].to_i)
  end

  private

  def party_params
    params.permit(:movie_id, :movie_title, :start_time, :duration, :host_id)
  end
end
