class Entry < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name
  after_create :set_tags

  def set_tags
    self.tag_list = self.name.scan(/#(\w+)/).join(', ')
    self.save
  end
end
