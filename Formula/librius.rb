class Librius < Formula
  desc "A fast, minimalist CLI to manage your personal book collection — built in Rust."
  homepage "https://github.com/umpire274/librius"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "c2f8486a2248abfdd7670558e7148c8f583a82ec32de83649e53ad9feb5ae005"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "8a317e9728170e7aa084311d9f01cfdd1a4fb1f27f6cd1a17d6dd6998f739b94"
    end
  end

  on_linux do
    url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "beab9fd46a5c020ba539833820a7299db50a3087b2de75979247eb6b5f893e7b"
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

