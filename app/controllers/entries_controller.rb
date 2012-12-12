class EntriesController < ApplicationController
  def index
    @tag_tree, @tag_order = Entry.tree
    #redirect_to entry_path(Date.today)
  end

  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        @tag_tree, @tag_order = Entry.tree
        format.html { redirect_to(:entries, :notice => 'Entry was successfully created.') }
        format.json  { render :json => @entry, :status => :created, :location => @entry }
        format.js #{ render :partial => @entry }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.json  { head :ok }
    end
  end
end
