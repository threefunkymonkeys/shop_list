module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the post named "(.+)" page/
      post = Post.find_by_name($1)
      post_path(post)

    when /the list named "(.+)" edit page/
      list = List.find_by_name($1)
      list.should_not be_nil
      edit_list_path(list)

    when /the (.+) edit page/
      model = $1.to_s.capitalize.constantize
      record = model.last
      "/#{$1.to_s.downcase.pluralize}/#{record.id}/edit"

    when /the new (.+) page/
      noun = $1.to_s.downcase.pluralize
      "/#{noun}/new"

    when /the (.+) page/
      "/#{$1}"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
