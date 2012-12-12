module EntriesHelper
  include ActsAsTaggableOn::TagsHelper

  def hash_to_haml(hash, key_order)
    @key_order = key_order << :entry
    hash_to_haml_loop(hash)
  end

  private
  def hash_to_haml_loop(hash)
    Hash[hash.sort_by{|a,b| @key_order.index(a) }].each do |key, value|
      haml_tag(:ul) do
        if key == :entry
          value.each {|entry| haml_concat(render 'entry', :entry => entry) }
        else
          haml_tag(:h3, "#"+key.name)
        end
        hash_to_haml_loop(value) if value.is_a?(Hash) && !value.empty?
      end
    end
  end
end
