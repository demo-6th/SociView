require 'rails_helper'

RSpec.describe "queries", :type => :routing do
  it "#list" do
    expect(:get => "queries/list").to route_to(
      :controller => "queries",
      :action => "list",
      )
  end

  it "#list" do
    expect(:post => "queries/list").to route_to(
      :controller => "queries",
      :action => "listpost",
      )
  end

  it "#volume" do
    expect(:get => "queries/volume").to route_to(
      :controller => "queries",
      :action => "volume",
      )
  end

  it "#volume" do
    expect(:post => "queries/volume").to route_to(
      :controller => "queries",
      :action => "volumepost",
      )
  end

  it "#sentiment" do
    expect(:get => "queries/sentiment").to route_to(
      :controller => "queries",
      :action => "sentiment",
      )
  end

  it "#sentiment" do
    expect(:post => "queries/sentiment").to route_to(
      :controller => "queries",
      :action => "sentpost",
      )
  end

  it "#topic" do
    expect(:get => "queries/topic").to route_to(
      :controller => "queries",
      :action => "topic",
      )
  end

  it "#topic" do
    expect(:post => "queries/topic").to route_to(
      :controller => "queries",
      :action => "topicpost",
      )
  end

  it "#wordcloud" do
    expect(:get => "queries/wordcloud").to route_to(
      :controller => "queries",
      :action => "wordcloud",
      )
  end

  it "#wordcloud" do
    expect(:post => "queries/wordcloud").to route_to(
      :controller => "queries",
      :action => "cloudpost",
      )
  end

  it "#termfreq" do
  expect(:get => "queries/termfreq").to route_to(
    :controller => "queries",
    :action => "termfreq",
    )
  end

  it "#termfreq" do
  expect(:post => "queries/termfreq").to route_to(
    :controller => "queries",
    :action => "termfreqpost",
    )
  end

end