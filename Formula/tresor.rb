class Tresor < Formula
  desc "k9s-style terminal UI for HashiCorp Vault and OpenBao"
  homepage "https://github.com/njoerd114/tresor"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/njoerd114/tresor/releases/download/v0.1.0/tresor-aarch64-apple-darwin.tar.gz"
      sha256 "013a63679cb3cec70f86d12830f478f02166156a66d2acd007d78f168bd0807e"
    end
    on_intel do
      url "https://github.com/njoerd114/tresor/releases/download/v0.1.0/tresor-x86_64-apple-darwin.tar.gz"
      sha256 "8015dd45ef4ce54d09ecfd6350f1944983134fe287742f330e43c218212c9284"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/njoerd114/tresor/releases/download/v0.1.0/tresor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e08337c9652c10903b54fecb55d68a5c72813fd8dfee25af5b729d31a1a33fb4"
    end
    on_intel do
      url "https://github.com/njoerd114/tresor/releases/download/v0.1.0/tresor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "928d7aba09ed83d5d13f0fa7ac89b3b6a2e85180f0d775fe1aae11557e2b271a"
    end
  end

  def install
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    suffix = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    bin.install "tresor-#{cpu}-#{suffix}" => "tresor"
  end

  test do
    # v0.1.0 predates the --version flag: verify the binary runs and reports
    # the missing configuration cleanly instead.
    assert_match "no configuration",
                 shell_output("env -u BAO_ADDR -u VAULT_ADDR -u BAO_TOKEN -u VAULT_TOKEN #{bin}/tresor --check 2>&1", 1)
  end
end
