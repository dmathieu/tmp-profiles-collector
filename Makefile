OCB_VERSION=0.119.1-0.20250210123122-44b3eeda354c
BUILDER_CONFIG="builder-config.yaml"

.PHONY: collector
collector:
	@printf "# DO NOT EDIT! This file has been auto-generated from \"builder-config.yaml.tmpl\".\n\n" >"$(BUILDER_CONFIG)"
	@sed 's/$${VERSION}/v$(OCB_VERSION)/g' "$(BUILDER_CONFIG).tmpl" >>"$(BUILDER_CONFIG)"
	@./ocb --skip-strict-versioning --verbose --config "$(BUILDER_CONFIG)"

.PHONY: run
run: collector
	@cd collector && \
	go mod tidy && \
	go build -o profiling-collector && \
	sudo ./profiling-collector --config ../config.yaml --feature-gates=service.profilesSupport

.PHONY: clean
clean:
	@echo Not implemented

.PHONY: ocb
ocb:
	@echo Fetching ocb v$(OCB_VERSION)
	@wget -q -O ocb \
		https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv$(OCB_VERSION)/ocb_$(OCB_VERSION)_linux_amd64
	@chmod +x ocb
	@./ocb version
