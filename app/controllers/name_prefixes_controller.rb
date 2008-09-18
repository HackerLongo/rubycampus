#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Relationship Management & Alumni Development Software                 |
# +------------------------------------------------------------------------------------+
# | Copyright (C) 2008 Kevin Aleman, RubyCampus LLC - https://rubycampus.org           |
# +------------------------------------------------------------------------------------+
# |                                                                                    |
# | This program is free software; you can redistribute it and/or modify it under the  |
# | terms of the GNU Affero General Public License version 3 as published by the Free  |
# | Software Foundation with the addition of the following permission added to Section |
# | 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK IN WHICH THE     |
# | COPYRIGHT IS OWNED BY RUBYCAMPUS LLC, RUBYCAMPUS LLC DISCLAIMS THE WARRANTY OF NON |
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
# | You can contact RubyCampus, LLC. at email address project@rubycampus.org.          |
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

class NamePrefixesController < ApplicationController
  before_filter :not_logged_in_required, :only => [ :lookup ]
  before_filter :login_required, :except => [ :lookup ]
  before_filter :check_super_user_role, :except => [ :lookup ]
  
  # GET rubycampus.local/name_prefixes
  # GET rubycampus.local/name_prefixes.xml
  def index #:nodoc:
    # @name_prefixes = NamePrefix.find(:all)
    @name_prefixes = NamePrefix.search_for_all_and_paginate(params[:locate], params[:page])

    respond_to do |format|
      format.html # index.html.haml
      # format.xml  { render :xml => @name_prefixes }
    end
  end

  # GET rubycampus.local/name_prefixes/1
  # GET rubycampus.local/name_prefixes/1.xml
  def show #:nodoc:
    @name_prefix = NamePrefix.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      # format.xml  { render :xml => @name_prefix }
    end
  end

  # GET rubycampus.local/name_prefixes/new
  # GET rubycampus.local/name_prefixes/new.xml
  def new #:nodoc:
    @name_prefix = NamePrefix.new

    respond_to do |format|
      format.html # new.html.haml
      # format.xml  { render :xml => @name_prefix }
    end
  end

  # GET rubycampus.local/name_prefixes/1/edit
  def edit #:nodoc:
    @name_prefix = NamePrefix.find(params[:id])
  end

  # POST rubycampus.local/name_prefixes
  # POST rubycampus.local/name_prefixes.xml
  def create #:nodoc:
    @name_prefix = NamePrefix.new(params[:name_prefix])

    respond_to do |format|
      if @name_prefix.save
        flash[:notice] = _("%s was successfully created.") % _("NamePrefix")
        if params[:create_and_new_button]
          format.html { redirect_to new_name_prefix_url }
        else
          format.html { redirect_to name_prefixes_url }
          # format.xml  { render :xml => @name_prefix, :status => :created, :location => @name_prefix }
        end
      else
        format.html { render :action => "new" }
        # format.xml  { render :xml => @name_prefix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT rubycampus.local/name_prefixes/1
  # PUT rubycampus.local/name_prefixes/1.xml
  def update #:nodoc:
    @name_prefix = NamePrefix.find(params[:id])

    respond_to do |format|
      if @name_prefix.update_attributes(params[:name_prefix])
        flash[:notice] = _("%s was successfully updated.") % _("NamePrefix") 
        format.html { redirect_to name_prefixes_url }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @name_prefix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE rubycampus.local/name_prefixes/1
  # DELETE rubycampus.local/name_prefixes/1.xml
  def destroy #:nodoc:
    @name_prefix = NamePrefix.find(params[:id])
    @name_prefix.destroy

    respond_to do |format|
      format.html { redirect_to name_prefixes_url }
      # format.xml  { head :ok }
    end
  end
  
  def lookup #:nodoc:
    @name_prefixes = NamePrefix.find_for_auto_complete_lookup(params[:search])                            
  end

end