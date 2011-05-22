class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    respond_to do |format|
      if @feedback.save
        flash[:notice] = I18n.translate("application.messages.feedback_thankyou")
      else
        flash[:error] = I18n.translate("application.messages.feedback_error")
      end
      format.js
      format.html{ redirect_back_or_default lists_path }
    end
  end

end
