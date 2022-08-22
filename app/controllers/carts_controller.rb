# frozen_string_literal: true

class CartsController < ApplicationController
  def show; end

  def destroy
    session[:cart123] = nil
    redirect_to products_path, notice: '購物車清除成功'
  end
end
