class Rbackup < Formula
  desc "Incremental backup tool in Rust (multi-platform)"
  homepage "https://github.com/umpire274/rBackup"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "06bb29eda1e85de8ac36e649bd2dff2efbf4f28e0b77fb63c1fc50cbe2a329b8"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "10a00ac0306ab3fcc4323cc580592c0af393516a8da98e6b161637b1ca9f418a"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f253bbec68fd3fe9f9531dac22a500639094c6847a65d8640bb89c7605dbb3ce"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "rbackup"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/rbackup --version")
    assert_match version.to_s, output
  end
end

