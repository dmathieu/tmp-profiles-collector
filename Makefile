OCB_VERSION=0.116.0

.PHONY: collector
collector:
	./ocb --skip-strict-versioning --verbose --config builder-config.yaml

.PHONY: run
run:
	cd collector && \
	go build && \
	sudo ./profiling-collector --config ../config.yaml --feature-gates=service.profilesSupport

.PHONY: clean
clean:
	rm ocb ocb.stamp

.PHONY: ocb
ocb:
	@echo Fetching ocb v$(OCB_VERSION)
	@curl -s -fL -o ocb \
		https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv$(OCB_VERSION)/ocb_$(OCB_VERSION)_linux_amd64
	@chmod +x ocb
	@./ocb version
