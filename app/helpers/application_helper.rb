module ApplicationHelper

  # hack for firefox. The 'alt' parameter on images does not work. Firefox uses 'title' instead.
  # http://snippets.dzone.com/posts/show/2917
  def image_tag(location, options={})
    options[:title] ||= options[:alt]
    super(location, options)
  end

  def sill_version
    #Java::OrgSonarServerPlatform::Platform.getServer().getVersion()
    '1.0.0'
  end

end
