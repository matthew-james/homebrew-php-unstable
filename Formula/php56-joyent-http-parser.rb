require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56JoyentHttpParser < AbstractPhp56Extension
  init
  homepage "https://github.com/chobie/php-httpparser"
  url "https://github.com/chobie/php-httpparser.git"
  sha256 "8c3cb465ca8f1080e5d16f316f2756985ef197ab89d03eb8eacd4d62851f6857"
  head "https://github.com/chobie/php-httpparser"
  version "0.0.1"
  conflicts_with "php54-httpparser", :because => "extension name is identical"
  conflicts_with "php55-httpparser", :because => "extension name is identical"
  conflicts_with "php56-httpparser", :because => "extension name is identical"

  def extension
    "httpparser"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    system "git submodule update --init --recursive"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"

    prefix.install ["modules/httpparser.so"]
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("httpparser")
  end
end