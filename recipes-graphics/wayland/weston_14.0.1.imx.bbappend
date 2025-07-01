COMPATIBLE_MACHINE:nxp-ls1028 = "nxp-ls1028"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:nxp-ls1028 = "\
    file://0001-Revert-backend-drm-Add-mesa-gbm-to-support-imx93.patch \
"
