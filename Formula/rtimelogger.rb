class Rtimelogger < Formula
  desc "Rust-based CLI tool for personal time logging and tracking"
  homepage "https://github.com/umpire274/rTimelogger"
  version "0.8.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "291395e65ebd8e38f968f2e779b12f943637b99907f3374c62c99e0dc26ff57d"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3b581c5bcd36760761552ea5662c223ea68927b1565381d22f023ecf88a6a3d0"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9fc985a3e09b4a4fca33f5ec80e0a9affbdc847f07dad739811891cfa8203207"
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

