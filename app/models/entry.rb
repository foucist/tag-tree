class Entry < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name
  after_create :set_tags

  default_scope includes(:tags)
  scope :tagged, includes(:taggings).where('taggings.id IS NOT NULL')
  scope :untagged, includes(:taggings).where('taggings.id IS NULL')

  def set_tags
    self.tag_list = self.name.scan(/#(\w+)/).join(', ')
      self.save
  end

  # Builds a hashtree going by the tag counts
  def self.tree
    auto_hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    tag_order = Entry.tag_counts.order('COUNT desc')

    (Entry.tagged + Entry.untagged).each{ |entry|
      sub = auto_hash
      keys = tag_order & entry.tags
      keys.each { |leaf| sub = sub[leaf] }
      sub.default = nil
      (sub[:entry] ||= []) << entry
    }

    return [auto_hash, tag_order]
  end

end
