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

class GroupsController < ApplicationController
  before_filter :login_required, :except => [ :lookup ]
  before_filter :check_super_user_role, :except => [ :lookup ]

  def index #:nodoc:
    sort = case params['sort']
           when "name"  then "name"
           when "name_reverse"  then "name DESC"
           when "id"  then "id"
           when "id_reverse"  then "id DESC"
           when "description"  then "description"
           when "description_reverse"  then "description DESC"
           when "is_enabled"  then "is_enabled"
           when "is_enabled_reverse"  then "is_enabled DESC"
           when "group_type_id"  then "group_type_id"
           when "group_type_id_reverse"  then "group_type_id DESC"
           when "updated_at"  then "updated_at"
           when "updated_at_reverse"  then "updated_at DESC"
           end

    conditions = ["name LIKE ?", "%#{params[:query]}%"] unless params[:query].nil?

    @total = Group.count(:conditions => conditions)
    @groups_pages, @groups = paginate :groups, :order => sort, :conditions => conditions, :per_page => AppConfig.rows_per_page

    if request.xml_http_request?
      render :partial => "groups", :layout => false
    end
  end

  # GET rubycampus.local/groups/1
  # GET rubycampus.local/groups/1.xml
  def show #:nodoc:
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      # format.xml  { render :xml => @group }
    end
  end

  # GET rubycampus.local/groups/new
  # GET rubycampus.local/groups/new.xml
  def new #:nodoc:
    @group = Group.new

    respond_to do |format|
      format.html # new.html.haml
      # format.xml  { render :xml => @group }
    end
  end

  # GET rubycampus.local/groups/1/edit
  def edit #:nodoc:
    @group = Group.find(params[:id])
  end

  # POST rubycampus.local/groups
  # POST rubycampus.local/groups.xml
  def create #:nodoc:
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = I18n.t("{{value}} was successfully created.", :default => "{{value}} was successfully created.", :value => I18n.t("Group", :default => "Group"))
        if params[:create_and_new_button]
          format.html { redirect_to new_group_url }
        else
          format.html { redirect_to groups_url }
          # format.xml  { render :xml => @group, :status => :created, :location => @group }
        end
      else
        format.html { render :action => "new" }
        # format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT rubycampus.local/groups/1
  # PUT rubycampus.local/groups/1.xml
  def update #:nodoc:
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = I18n.t("{{value}} was successfully updated.", :default => "{{value}} was successfully updated.", :value => I18n.t("Group", :default => "Group"))
        format.html { redirect_to groups_url }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE rubycampus.local/groups/1
  # DELETE rubycampus.local/groups/1.xml
  def destroy #:nodoc:
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      # format.xml  { head :ok }
    end
  end

  def lookup #:nodoc:
    @groups = Group.find_for_auto_complete_lookup(params[:search])
  end

  # PUT rubycampus.local/groups/1/enable
  def enable #:nodoc:
    @group = Group.find(params[:id])
    if @group.update_attribute(:is_enabled, true)
    flash[:notice] = I18n.t("{{name}} enabled.", :default => "{{name}} enabled.", :name => I18n.t("Group", :default => "Group"))
    else
    flash[:error] = I18n.t("There was a problem enabling this {{name}}.", :default => "There was a problem enabling this {{name}}.", :name => I18n.t("group", :default => "group"))
    end
    redirect_to groups_url
  end

  # PUT rubycampus.local/groups/1/disable
  def disable #:nodoc:
    @group = Group.find(params[:id])
    if @group.update_attribute(:is_enabled, false)
    flash[:notice] = I18n.t("{{name}} disabled.", :default => "{{name}} disabled.", :name => I18n.t("Group", :default => "Group"))
    else
    flash[:error] = I18n.t("There was a problem disabling this {{name}}.", :default => "There was a problem disabling this {{name}}.", :name => I18n.t("group", :default => "group"))
    end
    redirect_to groups_url
  end

  # GET rubycampus.local/groups/1/members
  def members #:nodoc:
    @group = Group.find(params[:id])
    @contacts_total = @group.contacts.count
    @contacts = @group.contacts.search_for_all_and_paginate(params[:search], params[:page], params[:contact_type], params[:stage])

    respond_to do |format|
      format.html
    end
  end

  # GET rubycampus.local/groups/search
  def search #:nodoc:
    @group = Group.find(params[:id])
    @contacts = Contact.search_for_all_and_paginate(params[:search], params[:page], params[:contact_type], params[:stage])

    respond_to do |format|
      format.html
    end
  end

  def add #:nodoc:
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(:contact_ids => params[:contact_ids])
        flash[:notice] = I18n.t("{{value}} members successfully updated.", :default => "{{value}} members successfully updated.", :value => I18n.t("Group", :default => "Group"))
        format.html { redirect_to members_group_url(params[:id]) }
      else
        format.html { redirect_to groups_url }
      end
    end
  end

end