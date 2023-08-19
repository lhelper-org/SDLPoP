set -e

if [ -z ${1+x} ]; then
  echo "error: please provide the target macOS version"
  echo "usage: $0 <macos-target>"
  exit 1
fi

# The following variable should be set to declare
# the minimum MACOSX version required by the application.
# For Apple Silicon ARM architecture it should be 11, corresponding to
# "Big Sur" released on 2020.
# For Intel x86-64 we can choose 10.11 corresponding to "El Capitan"
# release in 2015.
# See https://en.wikipedia.org/wiki/MacOS_version_history for more
# macOS version information.
export MACOSX_DEPLOYMENT_TARGET="$1"

# Note to build a package for Intel x86-64 when using an ARM macOS:

# CMAKE_OSX_ARCHITECTURES="x86_64" CPU_TYPE="x86-64" CPU_TARGET="x86-64" \
# CC="clang -arch x86_64" CXX="clang++ -arch x86_64" \
# OBJC="clang -arch x86_64" OBJCXX="clang++ -arch x86_64" lhelper activate build

build_application() {
  rm -fr .build-bundle
  meson setup --buildtype=release --prefix="$PWD/SDLPoP.app" --bindir=Contents/MacOS -Dmacos_target="$MACOSX_DEPLOYMENT_TARGET" .build-bundle
  meson compile -C .build-bundle
}

generate_bundle() {
  local app_name="$1"
  rm -fr "SDLPoP.app"
  meson install --strip -C .build-bundle
}

build_application
generate_bundle SDLPoP
