#encoding: utf-8
class WelcomeController < ApplicationController
  def index
    @user = User.new
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "新規登録に成功しました。"
      redirect_to :action => 'index' #, :notice => "新規登録に成功しました。" :actionではnoticeがパラメータになるらしい
    else
      render :action => 'new_user'
    end
  end

  def login
    if user = User.authenticate(params[:user])
      session[:login_user] = user
      flash[:notice] = "ログインに成功しました" unless flash[:notice]
      redirect_to memopages_path
    else
      flash[:notice] = "ログインに失敗しました"
      redirect_to :action => 'index'
    end
  end

  def logout
    session[:login_user] = nil
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to :action => 'index'
  end
end
