## Setup

### Rebuilding the collector from scratch

**Note**: You shouldn't need to do this, unless you want to retry a full rebuild.

Get the `ocb` tool (OTEL collector builder, amend version):
```
curl --proto '=https' --tlsv1.2 -fL -o ocb \
https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv0.116.0/ocb_0.116.0_linux_amd64
chmod +x ocb
```

Build a static version of the collector with glibc
```
./ocb --skip-strict-versioning --verbose --config builder-config.yaml
```

### Updating the version in `builder-config.yaml`

If you want to build the collector from a remote branch, replace the ebpf profiler version
with the version you get from (example for branch `otel-receiver`):
```
go list -m -json github.com/open-telemetry/opentelemetry-ebpf-profiler@otel-receiver | jq '.|.Version' | tr -d '"'
```

### Run the collector

Note: at the moment, you need `opentelemetry-ebpf-profiler` pulled, and on the
`otel-receiver` branch for this to run.

```
cd collector
go run components.go main.go main_others.go --config ../config.yaml --feature-gates=service.profilesSupport
```
