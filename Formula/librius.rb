class Librius < Formula
  desc "A fast, minimalist CLI to manage your personal book collection — built in Rust."
  homepage "https://github.com/umpire274/librius"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "4bccb976cef8a7c70a60a8b960e3a64a4c1cac10bcbf9b54727da39463942768"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "83e8d80a658f805185d762bdba7eac8c136813dcfcc0fca7e61afcca9cd5573e"
    end
  end

  on_linux do
    url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2e02be8a726a949d155af3488d3dd0275a221d3c64eaf38f4f14832f9055ba15"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "librius"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/librius --version")
    assert_match version.to_s, output
  end
end

