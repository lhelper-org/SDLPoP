set -e

get_arch () {
  if [ -z ${CPU_TYPE+x} ]; then
    uname -m
  else
    echo "$CPU_TYPE"
  fi
}

ARCH="$(get_arch)"

if [[ $ARCH == "x86-64" ]]; then
  ARCH="x86_64"
fi

build_application() {
  local _builddir="$1"
  rm -fr "${_builddir}"
  meson setup --buildtype=release "${_builddir}"
  meson compile -C "${_builddir}"
}

build_application_pgo() {
  local _builddir="$1"
  rm -fr "${_builddir}"
  meson setup --buildtype=release -Db_pgo=generate "${_builddir}"
  meson compile -C "${_builddir}"
  ${_builddir}/src/prince
  meson configure -Db_pgo=use "${_builddir}"
  meson compile -C "${_builddir}"
}

generate_package() {
  local app_name="$1"
  local _builddir="$2"
  local destdir="$PWD/${app_name}-${ARCH}"
  rm -fr "${app_name}-${ARCH}"
  mkdir "${app_name}-${ARCH}"
  cp -r data "$destdir"
  cp -r "${_builddir}/src/prince" "$destdir"
  strip "$destdir/prince"

  rm -f "${app_name}-linux-${ARCH}.tar.gz"
  tar czf "${app_name}-linux-${ARCH}.tar.gz" "${app_name}-${ARCH}"
  echo "Package generated: ${app_name}-linux-${ARCH}.tar.gz"
}

build_application_pgo .build-priv
generate_package SDLPoP .build-priv
