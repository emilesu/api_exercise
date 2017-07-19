class ToutiaosController < ApplicationController
  def index
    @toutiaos = Toutiao.all.order("date DESC")
  end

end
