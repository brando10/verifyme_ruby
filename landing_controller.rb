class LandingController < ApplicationController


  def index
    @response = HTTParty.get('http://verifyyou.herokuapp.com/api/v1/app_tokens/b7dfb74576c3d51bcdfa85437f639b85')
    @valid_id = current_user.validation_id
    @access_token_presence = @response.parsed_response.select{ |x| x['id'] == @valid_id }[0]['access_token'].empty? rescue ''
    if @access_token_presence.eql?('')
      redirect_to "http://verifyme.ph/apps/verify?app_key=b7dfb74576c3d51bcdfa85437f639b85&user_id=#{current_user.id}"
    else
      redirect_to root_path
    end
  end

  def landing
  end

  def receive
    v_id = params[:id]
    user_current = params[:user_id].to_i
    User.find(user_current).update_attributes(validation_id: v_id.to_i)
    flash[:notice] = 'User validated successfully!'
    redirect_to root_path
  end
end
