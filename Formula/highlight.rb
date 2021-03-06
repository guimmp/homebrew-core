class Highlight < Formula
  desc "Convert source code to formatted text with syntax highlighting"
  homepage "http://www.andre-simon.de/doku/highlight/en/highlight.php"
  url "http://www.andre-simon.de/zip/highlight-3.45.tar.bz2"
  sha256 "b360ab217a30e8fa7dbbf3359ea9bb808f18079a12173d49aba9742388636372"
  head "https://gitlab.com/saalen/highlight.git"

  bottle do
    sha256 "9e066a116ee456c5150a25405e0a845e888d7083f5d2341fa40457d4fb607efd" => :mojave
    sha256 "6e44cf1d79d5bc738fae34e141a4bfdad85d4d86793f6f69f56166680a632f41" => :high_sierra
    sha256 "2686c460019910cb2dcced8df9cc1ae3cc462371f6ec4573c49d06157575c149" => :sierra
    sha256 "d89620f021a4627041fd209e0f8ded6f9194d2bbd13d00c6145430e8e15e5b02" => :x86_64_linux
  end

  depends_on "boost" => :build
  depends_on "pkg-config" => :build
  depends_on "lua"

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    conf_dir = etc/"highlight/" # highlight needs a final / for conf_dir
    system "make", "PREFIX=#{prefix}", "conf_dir=#{conf_dir}"
    system "make", "PREFIX=#{prefix}", "conf_dir=#{conf_dir}", "install"
  end

  test do
    system bin/"highlight", doc/"extras/highlight_pipe.php"
  end
end
