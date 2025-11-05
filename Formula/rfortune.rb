class Rfortune < Formula
  desc "Rust-based clone of the classic UNIX 'fortune' command"
  homepage "https://github.com/umpire274/rFortune"
  version "0.5.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "67c9fb7f1d5c1c7a30418dbbf6e751f9b136c48cd4bcaa1b4778a0b7827b8d4c"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "087a947c734366d29e47b2ee6ea99fa68cd1a350511e6bf8fe3cc86520d8da89"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1b852b876dacea822a86c1b15c82448923c6bb00a3fb9d02ce5dddeb689a1447"
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

