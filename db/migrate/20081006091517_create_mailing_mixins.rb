#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Relationship Management & Alumni Development Software                 |
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

class CreateMailingMixins < ActiveRecord::Migration
  def self.up
    create_table :mailing_mixins do |t|
      t.integer    :domain_id, :default => 1, :null => false  # TODO Remove default
      t.string     :name, :null => false
      t.string     :subject, :null => false
      t.text       :html
      t.text       :text, :null => false
      t.integer    :mailing_mixin_type_id, :null => false
      t.boolean    :is_default, :default => false
      t.boolean    :is_reserved, :default => false
      t.boolean    :is_enabled, :default => true
      t.integer    :revisable_original_id
      t.integer    :revisable_branched_from_id
      t.integer    :revisable_number
      t.string     :revisable_name
      t.string     :revisable_type
      t.datetime   :revisable_current_at
      t.datetime   :revisable_revised_at
      t.datetime   :revisable_deleted_at
      t.boolean    :revisable_is_current
      t.timestamps
    end
    require 'active_record/fixtures'
    Fixtures.create_fixtures(RUBYCAMPUS_PATH_TO_DEFAULTS, File.basename("mailing_mixins.yml", '.*'))
  end

  def self.down
    drop_table :mailing_mixins
  end
end
