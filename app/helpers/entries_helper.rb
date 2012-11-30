module EntriesHelper
  include ActsAsTaggableOn::TagsHelper

  def build_tree
    @html = ""

    recursive_html_construction(@tree,@html)

    return @html
  end

  private
  def recursive_html_construction(branch, html)
    return if branch.keys.compact.empty? # abort if the only key is :entry
    (@tag_order & branch.keys).each do |category|
      next if category == :entry # skip href entries.
      html << '<ul>'
      html << "<li>#{category}</li>" unless category.nil?
      if branch[category].key?(:entry)
        [branch[category][:entry]].flatten.each {|x| html << "<li><a href='foo'>#{x.name}</a></li>" }
      end
      recursive_html_construction(branch[category],html)
    end
    html << '</ul>'
  end

end

