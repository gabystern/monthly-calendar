require 'pry'

class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new()
  end

  def create
    @event = Event.new(event_params)
    find_event = Event.find_by(time: @event.time)
    redirect_to events_path
    if !find_event.present?
      @event.save
      redirect_to events_path
    else
      flash[:notice] = "There is already an event at that time. Please try again."
      return render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :time)
  end

end
