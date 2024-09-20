## Setup

### Rebuilding the collector from scratch

**Note**: You shouldn't need to do this, unless you want to retry a full rebuild.

Get the `ocb` tool (OTEL collector builder, amend version):
```
curl --proto '=https' --tlsv1.2 -fL -o ocb https://github.com/open-telemetry/opentelemetry-collector/releases/download/cmd%2Fbuilder%2Fv0.106.0/ocb_0.106.0_linux_amd64
chmod a+x ocb
```

Build a static version of the collector with glibc
```
./ocb --skip-strict-versioning --verbose --config builder-config.yaml
```

Note: this build will fail, until the receiver code has been merged into the
main branch.

Update `go.mod`, appending to it:

```
replace github.com/open-telemetry/opentelemetry-ebpf-profiler => ../../../open-telemetry/opentelemetry-ebpf-profiler
```

This change assumes your local path respects GOPATH. If it doesn't, you will
need to change the relative path.

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
go run components.go main.go main_others.go --config ../config.yaml
```
