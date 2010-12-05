class SystemsController < ApplicationController
  
  before_filter :authenticate_admin!
  
  
  def create
    @system = System.create(params[:system])
	@system.save
	redirect_to admin_edit_form_path
  end


  def destroy
    @system = System.find(params[:id])
	Entry.tagged_with(@system.tag).each do |entry|
		entry.system_list.remove(@system.tag)
		entry.tags_string = tasks_string(entry) + " " + comps_string(entry) + " " + systems_string(entry)
		entry.save
	end
    @system.destroy
	redirect_to admin_edit_form_path
  end
  
  
  def tasks_string(entry)
	return "" unless entry.task_list.any?
	tasks = entry.task_list.collect do |tag|
		tag
	end
	tasks_string = tasks.join(' ')
  end

  
  def comps_string(entry)
	return "" unless entry.comp_list.any?
	comps = entry.comp_list.collect do |tag|
		tag
	end
	comps_string = comps.join(' ')
  end
  

  def systems_string(entry)
	return "" unless entry.system_list.any?
	systems = entry.system_list.collect do |tag|
		tag
	end
	systems_string = systems.join(' ')
  end
  

  def authors_string(entry)
	return "" unless entry.author_list.any?
	authors = entry.author_list.collect do |tag|
		tag
	end
	authors_string = authors.join(' ')
  end
end