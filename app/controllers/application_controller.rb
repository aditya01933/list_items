class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def process_act(success, msg:)
    if success
      flash[:success] = msg
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to :root
  end

  def process_set(success, action:, msg:)
    if success
      flash[:success] = msg
      redirect_to :root
    else
      render action: action
    end
  end
end
