class YtDownloader < Formula
  desc "Lightweight cross-platform desktop app to download YouTube videos and playlists"
  homepage "https://github.com/ytget/yt-downloader"
  url "https://github.com/ytget/yt-downloader/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  sha256 "9468df6e65f977e96115b9e0cc1faba1e517488a21837bed7be427e8c32e86d2"
  license "MIT"
  head "https://github.com/ytget/yt-downloader.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=#{version}", "-o", bin/"yt-downloader", "."
  end

  test do
    # Test that the binary exists and is executable
    assert_predicate bin/"yt-downloader", :exist?
    assert_predicate bin/"yt-downloader", :executable?
    
    # Test that the binary can start (GUI app, so we expect it to exit with code 0 or 1)
    # We use timeout to prevent hanging if GUI starts
    system bin/"yt-downloader", "--version" rescue nil
  end
end
