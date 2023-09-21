SHIMS = spin

IMAGE_NAME ?= ghcr.io/deislabs/containerd-wasm-shims/examples/k3d:v0.5.1
CLUSTER_NAME ?= k3s-default
PLATFORM ?= linux/amd64
ARCH ?= x86_64
TARGET ?= $(ARCH)-unknown-linux-musl
TEST_IMG_NAME_lunatic ?= wasmtest_lunatic:latest
TEST_IMG_NAME_spin ?= wasmtest_spin:latest
TEST_IMG_NAME_slight ?= wasmtest_slight:latest
TEST_IMG_NAME_wws ?= wasmtest_wws:latest


create-k3d:
	k3d cluster create $(CLUSTER_NAME) --image $(IMAGE_NAME) -p "8081:80@loadbalancer" --agents 1

build-workload-images:
	$(foreach shim,$(SHIMS),docker build --platform=wasi/wasm -t $(TEST_IMG_NAME_$(shim)) ../apps/hello;)

load-workload-images: build-workload-images
	$(foreach shim,$(SHIMS),k3d image load $(TEST_IMG_NAME_$(shim));)

up: create-k3d load-workload-images
	kubectl label nodes k3d-k3s-default-agent-0 spin-enabled=true
	kubectl apply -f ../kube/spin.yaml

test:
	$(foreach shim,$(SHIMS),curl localhost:8081/$(shim)/hello;)

integration:
	cd ../.. && cargo test -- --nocapture

clean:
	k3d cluster delete $(CLUSTER_NAME)