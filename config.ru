require 'rubygems'
require 'bundler'
require 'sass'
require 'sass/plugin/rack'

Sass::Plugin.options.merge! css_location: 'public/stylesheets',
                            template_location: 'public/stylesheets/sass',
                            debug_info: true,
                            style: :compressed
use Sass::Plugin::Rack

require_relative 'config/environment'

run ApplicationController
