###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  blog.summary_length = 156
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 6
  blog.page_link = "page/{num}"
end

set :casper, {
  blog: {
    url: 'http://justsomegeek.com',
    name: 'Just Some Geek',
    description: 'Yet another geeky blog...',
    date_format: '%d %B %Y',
    logo: nil # Optional
  },
  author: {
    name: 'm1n0',
    bio: 'm1n0 is a web dev passionate about technology, ' \
         'music and reading.',
    location: nil, # Optional
    website: 'http://sk.linkedin.com/in/milanlukac', # Optional
    dorg: 'https://www.drupal.org/u/m1n0', # Optional
    github: 'https://github.com/m1n0', # Optional
    gravatar_email: 'mino.lukac@gmail.com' # Optional
  }
}

page '/feed.xml', layout: false
page '/sitemap.xml', layout: false

ignore '/partials/*'

ready do
  blog.tags.each do |tag, articles|
    proxy "/tag/#{tag.downcase.parameterize}/feed.xml", '/feed.xml', layout: false do
      @tagname = tag
      @articles = articles[0..5]
    end
  end

  proxy "/author/#{blog_author.name.parameterize}.html", '/author.html', ignore: true
end


activate :google_analytics do |ga|
  ga.tracking_id = 'UA-61271241-1' # Replace with your property ID.
end

activate :disqus do |d|
  d.shortname = 'm1n0blog' # Replace with your Disqus shortname.
end

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  # config.output_style = :compact
  config.line_comments = false
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :kramdown
set :markdown, fenced_code_blocks: true, smartypants: true, parse_block_html: true
activate :syntax, line_numbers: true

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :partials_dir, 'partials'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  set :build_dir, '../blog-build'

  activate :robots, :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => "http://justsomegeek.com/sitemap.xml"
end
