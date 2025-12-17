class Rfortune < Formula
  desc "Rust-based clone of the classic UNIX 'fortune' command"
  homepage "https://github.com/umpire274/rFortune"
  version "0.5.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "9452562b2ebabae5a677edf75f3c9353e0a6bab5df63450b2ce2dce5ea7792c6"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2d4df0675a5fc46dbcdb9b72f52b53cbabab31fff73e6bd77a7fecc605da8f90"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c8414993cae845ba1394dca89eb3481de350a402345a71f49712a6c1bb32ea1f"
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

