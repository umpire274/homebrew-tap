class Rfortune < Formula
  desc "Rust-based clone of the classic UNIX 'fortune' command"
  homepage "https://github.com/umpire274/rFortune"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "dacbb7d6a8a9319b4157adde28ca3b5d326184a8943914e6c4a71beace95498b"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "4bc279acc65eff13218d1424236e80dbf4b4fce64b05d1336ea541d6563506bd"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a18b9690641608c8fcf40c99f7af0f3ee9f5f038f9f3718f856c6c62833564e5"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "rfortune"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/rfortune --version")
    assert_match version.to_s, output
  end
end

