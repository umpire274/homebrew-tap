class Rtimelogger < Formula
  desc "Rust-based CLI tool for personal time logging and tracking"
  homepage "https://github.com/umpire274/rTimelogger"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "c54ffb27ea24107a009c9eb0e738f110593c8a467c0170721f59064ce7d3c916"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a56455f128ec90ca10df4e4fe8121cd8d24340c858ce783fb75259fc1cf80d4d"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rTimelogger/releases/download/v#{version}/rtimelogger-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "443867ecb9f29fefc359729c593fd0a99ab707c41deba20c7b59be22b56d8103"
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

