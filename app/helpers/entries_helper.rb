module EntriesHelper
  include ActsAsTaggableOn::TagsHelper

  def hash_to_haml(hash, key_order)
    @key_order = key_order << :entry
    hash_to_haml_loop(hash)
  end

  private
  def hash_to_haml_loop(hash)
    haml_tag(:ul) do
      Hash[hash.sort_by{|a,b| @key_order.index(a) }].each do |key, value|
        if key == :entry
          value.each {|x| haml_tag(:li){ haml_tag(:a, :href => x.id){ haml_concat(x.name) }}}
        else
          haml_tag(:li){ haml_concat(key.name) }
        end
        hash_to_haml_loop(value) if value.is_a?(Hash) && !value.empty?
      end
    end
  end
end
