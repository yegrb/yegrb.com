class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.send_it
      flash[:success] = 'I have received your message and will be in touch soon!'
      redirect_to root_path
    else
      flash.now[:warning] = 'There was an error sending your message. Please try again.'
      render 'pages/getinvolved'
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :phone_number, :body)
  end
end
