module EntriesHelper
	include ActsAsTaggableOn::TagsHelper

  def task_links(entry)
    return "" unless entry.task_list.any?
    task_links = entry.task_list.collect do |tag|
      link_to tag, :controller => 'task', :action => 'tag', :id => tag
    end
    task_links_string = task_links.join(', ') 
  end

  def tasks_string(entry)
	return "" unless entry.task_list.any?
	tasks = entry.task_list.collect do |tag|
		tag
	end
	tasks_string = tasks.join(' ')
  end
  
  def comp_links(entry)
    return "" unless entry.comp_list.any?
    comp_links = entry.comp_list.collect do |tag|
      link_to tag, :controller => 'component', :action => 'tag', :id => tag
    end
    comp_links_string = comp_links.join(', ') 
  end

  def comps_string(entry)
	return "" unless entry.comp_list.any?
	comps = entry.comp_list.collect do |tag|
		tag
	end
	comps_string = comps.join(' ')
  end
  
  def system_links(entry)
    return "" unless entry.system_list.any?
    system_links = entry.system_list.collect do |tag|
      link_to tag, :controller => 'system', :action => 'tag', :id => tag
    end
    system_links_string = system_links.join(', ') 
  end

  def systems_string(entry)
	return "" unless entry.system_list.any?
	systems = entry.system_list.collect do |tag|
		tag
	end
	systems_string = systems.join(' ')
  end
  
  def author_links(author_list)
    return "" unless author_list.any?
    author_links = author_list.collect do |tag|
      link_to tag, :controller => 'entries', :action => 'index', :filter => tag
    end
    author_links_string = author_links.join(', ') 
  end

  def author_string(entry)
	return "" unless entry.author_list.any?
	authors = entry.author_list.collect do |tag|
		tag
	end
	authors_string = authors.join(' ')
  end
end
