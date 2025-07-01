PROVIDES:remove:nxp-ls1028 = "virtual/egl"
PROVIDES:remove:nxp-ls1028 = "virtual/libgl virtual/libgles1 virtual/libgles2"

PACKAGECONFIG:class-native:nxp-ls1028 ?= "gbm gallium egl opengl elf-tls x11"
PACKAGECONFIG:class-nativesdk:nxp-ls1028 ?= "gbm gallium egl opengl elf-tls x11 dri3"

PACKAGECONFIG:remove:nxp-ls1028   = "egl gbm"
PACKAGECONFIG:remove:nxp-ls1028 = "gles"

# FIXME: mesa should support 'x11-no-tls' option
python () {
    overrides = d.getVar("OVERRIDES").split(":")
    if "imxgpu2d" not in overrides:
        return

    x11flag = d.getVarFlag("PACKAGECONFIG", "x11", False)
    d.setVarFlag("PACKAGECONFIG", "x11", x11flag.replace("--enable-glx-tls", "--enable-glx"))
}

# For NXP BSP, GPU drivers don't support dri
PACKAGECONFIG:remove:nxp-ls1028 = "dri"

BACKEND = \
    "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', \
        bb.utils.contains('DISTRO_FEATURES',     'x11',     'x11', \
                                                             'fb', d), d)}"

# FIXME: Dirty hack to allow use of Vivante GPU libGL binary
do_install:append:nxp-ls1028 () {
    rm -f ${D}${libdir}/libGL.* \
          ${D}${includedir}/GL/gl.h \
          ${D}${includedir}/GL/glcorearb.h \
          ${D}${includedir}/GL/glext.h \
          ${D}${includedir}/GL/glx.h \
          ${D}${includedir}/GL/glxext.h
    if [ "${BACKEND}" = "x11" ]; then
        rm -f ${D}${libdir}/pkgconfig/gl.pc
    fi
}

do_install:append:nxp-ls1028 () {
    rm -rf ${D}${includedir}/KHR
}
