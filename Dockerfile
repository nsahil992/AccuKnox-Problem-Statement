# ----- BUILD STAGE -----

FROM debian@sha256:df52e55e3361a81ac1bead266f3373ee55d29aa50cf0975d440c2be3483d8ed3 AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    netcat-openbsd cowsay fortune-mod fortunes-min && \
    rm -rf /var/lib/apt/lists/*

COPY wisecow.sh ./

RUN chmod +x wisecow.sh

# ----- RUN STAGE -----

FROM debian@sha256:df52e55e3361a81ac1bead266f3373ee55d29aa50cf0975d440c2be3483d8ed3 AS runtime

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    netcat-openbsd cowsay fortune-mod fortunes-min && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/wisecow.sh ./

RUN chmod +x wisecow.sh

EXPOSE 4499

ENTRYPOINT ["/app/wisecow.sh"]
