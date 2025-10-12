class Librius < Formula
  desc "A fast, minimalist CLI to manage your personal book collection — built in Rust."
  homepage "https://github.com/umpire274/librius"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "3b4dfd22c7cf9d3ddfb2210e6822afb72e400eadbea16c0b6e9ed160cf93c5b1"
    elsif Hardware::CPU.arm?
      url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7dfe0f6995d4345feba8c3f13580595979d5f825edd7d4b33cf3747468d8f4e1"
    end
  end

  on_linux do
    url "https://github.com/umpire274/librius/releases/download/v#{version}/librius-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fb83b61099b0f7adb2304575f052204cbdd6578acde993cda98566290ecab01f"
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

