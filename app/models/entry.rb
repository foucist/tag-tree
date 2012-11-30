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
    tree = {}

    tag_order =  Entry.tag_counts.order('count DESC').map {|x| x.name} << nil

    Entry.all.each do |entry|
      tags = tag_order & entry.tags.map {|x| x.name} #.scan(/#(\w+)/).flatten #.join(', ')
      tags = [nil] if tags.empty?
      deepest_folder = insert_leaves(tree,tags)
      if deepest_folder[:entry].nil?
        deepest_folder[:entry] = entry 
      else
        deepest_folder[:entry] = [deepest_folder[:entry], entry].flatten
      end
    end

    return [tag_order, tree]
  end

  private
  def self.insert_leaves(tree,node_list)
    next_leaf = node_list[0]
    rest = node_list[1..-1]
    tree[next_leaf] ||= {}
    if not rest.empty?
      insert_leaves(tree[next_leaf],rest)
    else
      tree[next_leaf]
      # recursively, this will fall out to be the final result, making the
      # function return the last (deepest) node inserted.
    end
  end

end
