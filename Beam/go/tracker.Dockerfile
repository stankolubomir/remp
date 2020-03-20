########################################################################################################################
# Golang base image for next stages

FROM golang:1.13.6-buster as golang_base

ENV SRC_FOLDER="gitlab.com/remp/remp/Beam/go"
ENV FULL_SRC_FOLDER="/go/src/${SRC_FOLDER}"

RUN apt update && \
    apt install -y \
        gettext-base && \
    go get golang.org/x/tools/cmd/goimports && \
    useradd -d /home/user -u 1000 -m -s /bin/bash user && \
    mkdir -p ${FULL_SRC_FOLDER} && \
    chown user:user ${FULL_SRC_FOLDER} && \
    apt clean

USER user

WORKDIR ${FULL_SRC_FOLDER}

########################################################################################################################
# Tracker development build stage

FROM golang_base as tracker_development

ENV APP_EXECUTABLE="tracker"
ENV FULL_SRC_FOLDER_APP="${FULL_SRC_FOLDER}/cmd/tracker"
ENV GOAGEN_DIR="../../vendor/github.com/goadesign/goa/goagen" \
    DESIGN_PKG="${SRC_FOLDER}/cmd/tracker/design"

WORKDIR ${FULL_SRC_FOLDER_APP}

EXPOSE 8081

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "-c", "envsubst <.env.dist >.env && ./${APP_EXECUTABLE}"]