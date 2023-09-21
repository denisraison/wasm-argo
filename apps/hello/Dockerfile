FROM --platform=${BUILDPLATFORM} rust:1.69 AS build
WORKDIR /opt/build
COPY . .
RUN rustup target add wasm32-wasi
RUN cargo build --target wasm32-wasi --release

FROM scratch
COPY --from=build /opt/build/target/wasm32-wasi/release/hello_spin.wasm .
COPY --from=build /opt/build/spin.toml .