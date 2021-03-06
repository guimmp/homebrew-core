class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  url "https://github.com/sharkdp/bat/archive/v0.7.1.tar.gz"
  sha256 "5863895e6ac95f5349da95ff74e196c4b365af3fc3f4a1376cab797df493b7a4"

  bottle do
    sha256 "62e42c268d73f27f0eada988ddaf5a2f841b72af3cbc8c85d716183788608448" => :mojave
    sha256 "0ab5a742c1fadeb7749caf7d96bc7005518df5d939c4482396d539aaceb0bd9d" => :high_sierra
    sha256 "b556a914588cc041a14493fe735d39d1fab438cfde09b79f9f834404c8516ddd" => :sierra
    sha256 "9a8134c1d9b345e5f97965b3796dfbdf24ccb6fe480de4185bb215f373ba0109" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "zlib" unless OS.mac?

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    pdf = test_fixtures("test.pdf")
    output = shell_output("#{bin}/bat #{pdf} --color=never")
    assert_match "Homebrew test", output
  end
end
