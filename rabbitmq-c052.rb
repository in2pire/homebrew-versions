require "formula"

class RabbitmqC052 < Formula
  desc "RabbitMQ C client"
  homepage "https://github.com/alanxz/rabbitmq-c"
  url "https://github.com/alanxz/rabbitmq-c/archive/v0.5.2.tar.gz"
  sha256 "418726e830567c296292fd37325d8eeea7b8973c143c4b50b8acf694244ff6a7"

  bottle do
  end

  conflicts_with "rabbitmq-c", :because => "Differing versions of same formula"

  option :universal
  option "without-tools", "Build without command-line tools"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "rabbitmq" => :recommended
  depends_on "popt" if build.with? "tools"
  depends_on "openssl"

  def install
    ENV.universal_binary if build.universal?
    args = std_cmake_args
    args << "-DBUILD_EXAMPLES=OFF"
    args << "-DBUILD_TESTS=OFF"
    args << "-DBUILD_API_DOCS=OFF"

    if build.with? "tools"
      args << "-DBUILD_TOOLS=ON"
    else
      args << "-DBUILD_TOOLS=OFF"
    end

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system bin/"amqp-publish", "--help"
  end
end
