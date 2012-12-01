class EntriesController < ApplicationController
  def index
    @tag_tree, @tag_order = Entry.tree
  end
end
