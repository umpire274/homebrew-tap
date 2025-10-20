class Librius < Formula
  desc "A fast, minimalist CLI to manage your personal book collection — built in Rust."
  homepage "https://github.com/umpire274/librius"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7e6634ae1693571ad098f7622b0e7b43dfdf03de9c13f3ad0f1185ff054c26e4"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "83644aaafdb78e318b00b81d0d6a41680632c7878032b4d9107af1e073c685c9"
    end
  end

  on_linux do
    url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "32a27d8347b865a46d68e75ea4efbe37121e47b00e48ea17e428be8408512fdf"
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

