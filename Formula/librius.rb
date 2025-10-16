class Librius < Formula
  desc "A fast, minimalist CLI to manage your personal book collection — built in Rust."
  homepage "https://github.com/umpire274/librius"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "27b024c1b012e8932edc2961274e3cf15c74c34cffab71c26f917ca7774c6970"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "4a95d83e2f2a3634de87427d65edf785a19960861c2cbd06d063e4d365fce2b7"
    end
  end

  on_linux do
    url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a107c2bfe7d413322b0fe5635353247240b6cb6f1fc08e0171da3ac83d903cf7"
  end

  # facoltativo, aiuta `brew livecheck`
  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "librius"
    # se nel tarball includi questi file, li installi così:
    pkgshare.install "README.md" if File.exist?("README.md")
    pkgshare.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    # verifica minima: stampa versione o help
    output = shell_output("#{bin}/librius --version")
    assert_match version.to_s, output
  end
end

