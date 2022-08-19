FROM collabora/code:6.4.14.3

LABEL maintainer "zhouyueqiu zhouyueqiu@easycorp.ltd"

ENV OS_ARCH="amd64" \
    OS_NAME="ubuntu-18.04" \
    HOME_PAGE="https://www.collaboraoffice.com/"


ENV TZ=Asia/Shanghai

# Copy collabora-office config files
COPY --chown=lool 6.4/rootfs /

