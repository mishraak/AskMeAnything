class UpvoteAnswersController < ApplicationController
  before_action :authenticate_user!

  def toggle_upvote
    @answer = Answer.find(params[:answer_id])
    upvoteAnswer = UpvoteAnswer.where(user: current_user, answer: @answer).first
    if upvoteAnswer
      upvoteAnswer.destroy!
      @is_upVotedA = false
    else
      UpvoteAnswer.create(user: current_user, answer: @answer)
      @is_upVotedA = true
    end

    respond_to do |format|
      format.js { }
    end
  end
end
