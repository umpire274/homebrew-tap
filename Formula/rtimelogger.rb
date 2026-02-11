class Rtimelogger < Formula
  desc "Rust-based CLI tool for personal time logging and tracking"
  homepage "https://github.com/umpire274/rTimelogger"
  version "0.8.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "5a329e07a803fe42e281e65a76289f6cbb7ab5b57443f1baf4d7295f8583fdf1"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "eb4e71c66d1fc83e19566a43c6f3f700d3ef2e0facfdcd99d0db9687b54c81e7"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bbb83c24fa549e2aaa8e532d146164e6f5331c41bffa66228d5e02d8bc86220a"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "rtimelogger"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/rtimelogger --version")
    assert_match version.to_s, output
  end
end

