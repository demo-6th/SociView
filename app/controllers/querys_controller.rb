class QuerysController < ApplicationController
  layout "homepage"
  def index
  end

  def list
  end

  def sentiment
  end

  def volume
  end

  def sub_topic
  end

  def wordcloud
    @cloud = `python lib/assets/python/word-cloud.py`
    # send_file 'app/assets/images/wordcloud.png', type: 'image/png', disposition: 'inline'
  end

  def diffusion
  end
end
