class Rfortune < Formula
  desc "Rust-based clone of the classic UNIX 'fortune' command"
  homepage "https://github.com/umpire274/rFortune"
  version "0.5.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "5a7fecd9631ed7e2753611fec07d730ec20d540ffb390c36915905033fe83aff"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "88f5198f3fa10fe2ed53aca312fc73620cd3bad142f6f7d40632e2bb83e65abb"
    end
  end

  on_linux do
    url "https://github.com/umpire274/rFortune/releases/download/v#{version}/rfortune-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9d50f9bf24b836cb9799a2792e108f2d685e9288ef2749bf6fe86010f951670d"
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

