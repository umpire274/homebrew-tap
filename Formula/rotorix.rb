class Rotorix < Formula
  desc "Rotor-based encryption CLI inspired by the Enigma machine"
  homepage "https://github.com/umpire274/rotorix"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rotorix/releases/download/rotorix-v#{version}/rotorix-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "f1a773189041d34120d178ee56fa601035dcae32cb6735675a36014d7c219320"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rotorix/releases/download/rotorix-v#{version}/rotorix-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e3d14b3ba65da2494156e9d833f3d98045dc2b1947fa00b75c77369716fe3c3d"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rotorix/releases/download/rotorix-v#{version}/rotorix-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d833202a2d8e82ffe61b7780049f3e17551f0a3a78bc0388da274f32bf1efeea"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "rotorix"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/rotorix --version")
    assert_match version.to_s, output
  end
end

