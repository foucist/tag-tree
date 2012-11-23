class EntriesController < ApplicationController
    def index
        @tags = Entry.tag_counts_on(:tags).sort_by(&:count).reverse
        @taggings_hash = {}
        @tags.each do |tag|
            @taggings_hash[tag.name] = tag.count
        end
    end
end
