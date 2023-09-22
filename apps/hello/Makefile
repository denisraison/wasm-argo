build:
	rustup target add wasm32-wasi && cargo build --target wasm32-wasi --release

push:
	/home/denis/workspace/wasm-to-oci push target/wasm32-wasi/release/hello_spin.wasm ghcr.io/denisraison/hello_spin:lastest