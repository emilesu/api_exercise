class ToutiaosController < ApplicationController
  def index
    @toutiaos = Toutiao.all
  end

end
