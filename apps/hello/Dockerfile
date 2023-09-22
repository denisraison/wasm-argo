FROM rust:1.69 AS build
WORKDIR /opt/build
COPY . .
RUN rustup target add wasm32-wasi && cargo build --target wasm32-wasi --release

FROM wasmedge/slim-runtime:0.10.1
COPY --from=build /opt/build/target/wasm32-wasi/release/wasmedge_warp_server.wasm /
CMD ["wasmedge", "--dir", ".:/", "/wasmedge_warp_server.wasm"]