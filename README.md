## Setup

### Rebuilding the collector from scratch

**Note**: You shouldn't need to do this, unless you want to retry a full rebuild.

Get the `ocb` tool (OTEL collector builder):
```
make ocb
```

Build a static version of the collector with glibc
```
make
```

### Updating the version in `builder-config.yaml`

If you want to build the collector from a remote branch, replace the ebpf profiler version
with the version you get from (example for branch `otel-receiver`):
```
go list -m -json github.com/dmathieu/opentelemetry-ebpf-profiler@collector-receiver | jq '.|.Version' | tr -d '"'
```

### Run the collector

The ebpf-profiler needs to be run as root. So we split building and running.

```
make run
```
