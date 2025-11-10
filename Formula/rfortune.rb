class Rfortune < Formula
  desc "Rust-based clone of the classic UNIX 'fortune' command"
  homepage "https://github.com/umpire274/rFortune"
  version "0.5.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "85f3fe1d454b3f90a602f88451f67ee597cba878a44514be27b6ad4a9f03872c"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ba12aab7eaa4ce053f7f4f071a81e3c8f81dc1c7b171d70b5c685e460943fde9"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a1cb9e7fdd2c828246866e97e99f2952c9e5f5b602d731d554f65e7c85ebc33a"
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

