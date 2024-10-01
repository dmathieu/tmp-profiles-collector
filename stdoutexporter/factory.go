package stdoutexporter

import (
	"context"
	"fmt"
	"os"

	"go.opentelemetry.io/collector/component"
	"go.opentelemetry.io/collector/consumer/consumerprofiles"
	"go.opentelemetry.io/collector/exporter"
	"go.opentelemetry.io/collector/exporter/exporterprofiles"
	"go.opentelemetry.io/collector/pdata/pprofile"
)

// The value of "type" key in configuration.
var componentType = component.MustNewType("stdout")

type Config struct{}

// NewFactory creates a factory for Debug exporter
func NewFactory() exporter.Factory {
	return exporter.NewFactory(
		componentType,
		createDefaultConfig,
		exporterprofiles.WithProfiles(createProfilesExporter, component.StabilityLevelDevelopment),
	)
}

func createDefaultConfig() component.Config {
	return &Config{}
}

func createProfilesExporter(context.Context, exporter.Settings, component.Config) (exporterprofiles.Profiles, error) {
	tc, err := consumerprofiles.NewProfiles(func(ctx context.Context, pd pprofile.Profiles) error {
		fmt.Fprintf(os.Stdout, "%#v\n", pd)
		return nil
	})

	return &profileExporter{
		Profiles: tc,
	}, err
}

type profileExporter struct {
	consumerprofiles.Profiles
}

func (*profileExporter) Start(context.Context, component.Host) error {
	return nil
}

func (*profileExporter) Shutdown(ctx context.Context) error {
	return nil
}
