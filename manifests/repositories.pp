# yumrepos::repositories
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   yumrepos::repositories { 'namevar': }
define yumrepos::repositories(
  String $title
  String $name
  String $baseurl
  String $metalink
  String $failovermethod
  String $enabled
  String $gpgcheck
  String $gpgkey
  String $gpgfile = '/etc/yum.repos.d/#{title}'
) {

  $file_conf_template = @(END)
  [<%= @title %>]
  name=<%= @name %>
  <% if @baseurl.defined? %>
  baseurl=<%= @baseurl %>
  <% end %>
  <% if @metaurl.defined? %>
  metalink=<%= @metaurl %>
  failovermethod=priority
  enabled=<%= @enabled %>
  gpgcheck=<%= @gpgcheck %>
  gpgkey=<%= @gpgfile %>
  END
  
  file { $file:
  ensure  => file,
  content => inline_template($file_conf_template),
}
}
