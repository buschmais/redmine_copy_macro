Redmine::Plugin.register :redmine_copy_macro do
  name 'Redmine Copy Macro plugin'
  author 'Frank Schwarz'
  description 'Macro for copy-to-clipboard button'
  version '0.0.1.dev'
  url 'https://github.com/buschmais/redmine_copy_macro'
  author_url 'https://www.buschmais.de/author/frank/'

  Redmine::WikiFormatting::Macros.register do
    desc "Add copy macro: {{copy(some text)}}"
    macro :copy do |obj, args, text|
      html_id = "copy-#{Redmine::Utils.random_hex(4)}"
      js = "navigator.clipboard.writeText($('##{html_id}').text())"
      value = args.length > 0 ? args[0] : text
      out = ''.html_safe
      out << content_tag(
            'span',
            value,
            :id => "#{html_id}",
            :class => 'copy-text',
            :style => 'display: inline-block; padding: 1px; border: 1px solid darkgrey; background-color: #eee; border-radius: 2px;'
          )
      out << link_to_function(
            '📋',
            js,
            :title => 'Copy',
            :class => 'copy-text-button',
            :style => 'padding-left: 5px; text-decoration: none;')
      out
    end
  end
end
