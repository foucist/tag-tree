class Entry < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name
  after_create :set_tags

  default_scope includes(:tags)

  def set_tags
    self.tag_list = self.name.scan(/#(\w+)/).join(', ')
      self.save
  end

  def self.tree
    auto_hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    tag_order = Entry.tag_counts.order('COUNT desc')

    Entry.all.each{ |entry|
      sub = auto_hash
      keys = tag_order & entry.tags
      keys.each { |leaf| sub = sub[leaf] }
      sub.default = nil
      (sub[:entry] ||= []) << entry
    }

    return [auto_hash, tag_order]
  end

end
