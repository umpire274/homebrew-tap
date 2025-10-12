class Rbackup < Formula
  desc "Incremental backup tool in Rust (multi-platform)"
  homepage "https://github.com/umpire274/rBackup"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "63858e1eea53556af2a925e1d3713c16c129843cf4fe1b623720f093416eee72"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "be8284b187dc34eb22aef164b09f1701cacdb2e21377dd4b787e00e67bca2132"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rBackup/releases/download/v#{version}/rbackup-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "65df4d98707774af6e356805d58dccb8d365c14b3e81ed79c822b234fbcaac88"
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

