set -e

build_application() {
  rm -fr .build-bundle
  meson setup --buildtype=release --prefix="$PWD/SDLPoP.app" --bindir=Contents/MacOS .build-bundle
  meson compile -C .build-bundle
}

generate_bundle() {
  local app_name="$1"
  rm -fr "SDLPoP.app"
  meson install --strip -C .build-bundle
}

build_application
generate_bundle SDLPoP
