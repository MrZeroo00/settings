#!/usr/bin/ruby
require 'cgi'
require 'iconv'

CONFIG_FILE = File.expand_path "~/.w3m/cgi-bin/search.conf"
DEFAULT_ENCODING = 'EUC-JP'
class SearchEngines
  def encoding(encoding)
    @from_encoding = encoding || DEFAULT_ENCODING
  end

  def defsearch(name, to_encoding, url_format)
    (@searches||={})[name.to_s] = lambda { |q|
      q = Iconv.iconv(to_encoding, @from_encoding, q).first if to_encoding
      format(url_format, CGI.escape(q))
    }
  end

  def defalias(alias_, original)
    @searches[alias_.to_s] = @searches[original.to_s]
  end

  def load_config(config_file=CONFIG_FILE)
    eval(File.read(config_file), binding)
  end

  def search(site, query)
    url = @searches[site][query]
    print "Location: #{url}\r\n\r\n"
  end
end

site, query = CGI.unescape(ENV['QUERY_STRING']).split(/:/, 2)
se = SearchEngines.new
se.load_config
se.search(site, query)
