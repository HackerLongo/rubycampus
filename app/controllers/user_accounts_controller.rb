#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Student & Alumni Relationship Management Software                     |
# +------------------------------------------------------------------------------------+
# | Copyright © 2008-2009 Kevin R. Aleman. Fukuoka, Japan. All Rights Reserved.        |
# +------------------------------------------------------------------------------------+
# |                                                                                    |
# | This program is free software; you can redistribute it and/or modify it under the  |
# | terms of the GNU Affero General Public License version 3 as published by the Free  |
# | Software Foundation with the addition of the following permission added to Section |
# | 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK IN WHICH THE     |
# | COPYRIGHT IS OWNED BY KEVIN R ALEMAN, KEVIN R ALEMAN DISCLAIMS THE WARRANTY OF NON |
# | INFRINGEMENT OF THIRD PARTY RIGHTS.                                                |
# |                                                                                    |
# | This program is distributed in the hope that it will be useful, but WITHOUT ANY    |
# | WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A    |
# | PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.   |
# |                                                                                    |
# | You should have received a copy of the GNU Affero General Public License along     |
# | with this program; if not, see http://www.gnu.org/licenses or write to the Free    |
# | Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  |
# | USA.                                                                               |
# |                                                                                    |
# | You can contact the author Kevin R. Aleman by email at KALEMAN@RUBYCAMPUS.ORG. The |
# |                                                                                    |
# | The interactive user interfaces in modified source and object code versions of     |
# | this program must display Appropriate Legal Notices, as required under Section 5   |
# | of the GNU Affero General Public License version 3.                                |
# |                                                                                    |
# | In accordance with Section 7(b) of the GNU Affero General Public License version   |
# | 3, these Appropriate Legal Notices must retain the display of the "Powered by      |
# | RubyCampus" logo. If the display of the logo is not reasonably feasible for        |
# | technical reasons, the Appropriate Legal Notices must display the words "Powered   |
# | by RubyCampus".                                                                    |
# +------------------------------------------------------------------------------------+
#++

class UserAccountsController < ApplicationController                        
  before_filter :login_required, :except => :show
  before_filter :not_logged_in_required, :only => :show

  # Activate action
  def show #:nodoc:
    # Uncomment and change paths to have user logged in after activation - not recommended
    #self.current_user = User.find_and_activate!(params[:id])
    User.find_and_activate!(params[:id])
    flash[:notice] = I18n.t("Your account has been activated! You can now login.", :default => "Your account has been activated! You can now login.")
    redirect_to login_path
    rescue User::ArgumentError
    flash[:notice] = I18n.t("Activation code not found. Please try creating a new account.", :default => "Activation code not found. Please try creating a new account.")
    redirect_to new_user_path
    rescue User::ActivationCodeNotFound
    flash[:notice] = I18n.t("Activation code not found. Please try creating a new account.", :default => "Activation code not found. Please try creating a new account.")
    redirect_to new_user_path
    rescue User::AlreadyActivated
    flash[:notice] = I18n.t("Your account has already been activated. You can log in below.", :default => "Your account has already been activated. You can log in below.")
    redirect_to login_path      
  end

  def edit #:nodoc:
  end    

  # Change password action
  def update #:nodoc:
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
    if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
    current_user.password_confirmation = params[:password_confirmation]
    current_user.password = params[:password]
    if current_user.save
    flash[:notice] = I18n.t("Password successfully updated.", :default => "Password successfully updated.")
    redirect_to user_path(current_user) 
    else
    flash[:error] = I18n.t("An error occurred, your password was not changed.", :default => "An error occurred, your password was not changed.")
    render :action => 'edit'
    end
    else
    flash[:error] = I18n.t("New password does not match the password confirmation.", :default => "New password does not match the password confirmation.")
    @old_password = params[:old_password]
    render :action => 'edit'
    end
    else
    flash[:error] = I18n.t("Your old password is incorrect.", :default => "Your old password is incorrect.")
    render :action => 'edit'                           
    end     
  end

end