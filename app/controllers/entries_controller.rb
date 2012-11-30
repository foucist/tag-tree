class EntriesController < ApplicationController
  def index
    @tag_order, @tree = Entry.tree
  end
end
