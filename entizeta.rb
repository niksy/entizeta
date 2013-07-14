require 'formula'

class Entizeta < Formula
  homepage 'https://github.com/niksy/entizeta'
  url 'https://github.com/niksy/entizeta/archive/master.tar.gz'
  sha1 '53bed08f1a79a9bc0251a09bf304640e4eab1e29'
  version '0.1'

  def install
    bin.install 'entizeta'
  end
end
