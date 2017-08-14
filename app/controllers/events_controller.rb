require 'pry'

class EventsController < ApplicationController

  def index
    @events = Event.all
    if params[:date]
      @selected = params[:date]
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new()
  end

  def create
    @event = Event.new(event_params)
    find_event = Event.find_by(date: @event.date)
    binding.pry
    if find_event.present? && @event.eventtime.hour == find_event.eventtime.hour && @event.eventtime.min == find_event.eventtime.min
      flash.now[:alert] = "There is already an event at that time"
      render :new
    else
      @event.save
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.delete
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :eventtime)
  end

end
