/*
Copyright 2017 Turbine Labs, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// This file was automatically generated by prefixed_flagset_gen.sh.
// Any changes will be lost if this file is regenerated.

package flag

import (
	"time"
)

// BoolVar wraps the underlying FlagSet's BoolVar function.
func (f *prefixedFlagSet) BoolVar(p *bool, name string, value bool, usage string) {
	f.FlagSet.BoolVar(p, f.prefix+name, value, f.mkUsage(usage))
}

// Bool wraps the underlying FlagSet's Bool function.
func (f *prefixedFlagSet) Bool(name string, value bool, usage string) *bool {
	return f.FlagSet.Bool(f.prefix+name, value, f.mkUsage(usage))
}

// DurationVar wraps the underlying FlagSet's DurationVar function.
func (f *prefixedFlagSet) DurationVar(p *time.Duration, name string, value time.Duration, usage string) {
	f.FlagSet.DurationVar(p, f.prefix+name, value, f.mkUsage(usage))
}

// Duration wraps the underlying FlagSet's Duration function.
func (f *prefixedFlagSet) Duration(name string, value time.Duration, usage string) *time.Duration {
	return f.FlagSet.Duration(f.prefix+name, value, f.mkUsage(usage))
}

// Float64Var wraps the underlying FlagSet's Float64Var function.
func (f *prefixedFlagSet) Float64Var(p *float64, name string, value float64, usage string) {
	f.FlagSet.Float64Var(p, f.prefix+name, value, f.mkUsage(usage))
}

// Float64 wraps the underlying FlagSet's Float64 function.
func (f *prefixedFlagSet) Float64(name string, value float64, usage string) *float64 {
	return f.FlagSet.Float64(f.prefix+name, value, f.mkUsage(usage))
}

// IntVar wraps the underlying FlagSet's IntVar function.
func (f *prefixedFlagSet) IntVar(p *int, name string, value int, usage string) {
	f.FlagSet.IntVar(p, f.prefix+name, value, f.mkUsage(usage))
}

// Int wraps the underlying FlagSet's Int function.
func (f *prefixedFlagSet) Int(name string, value int, usage string) *int {
	return f.FlagSet.Int(f.prefix+name, value, f.mkUsage(usage))
}

// Int64Var wraps the underlying FlagSet's Int64Var function.
func (f *prefixedFlagSet) Int64Var(p *int64, name string, value int64, usage string) {
	f.FlagSet.Int64Var(p, f.prefix+name, value, f.mkUsage(usage))
}

// Int64 wraps the underlying FlagSet's Int64 function.
func (f *prefixedFlagSet) Int64(name string, value int64, usage string) *int64 {
	return f.FlagSet.Int64(f.prefix+name, value, f.mkUsage(usage))
}

// StringVar wraps the underlying FlagSet's StringVar function.
func (f *prefixedFlagSet) StringVar(p *string, name string, value string, usage string) {
	f.FlagSet.StringVar(p, f.prefix+name, value, f.mkUsage(usage))
}

// String wraps the underlying FlagSet's String function.
func (f *prefixedFlagSet) String(name string, value string, usage string) *string {
	return f.FlagSet.String(f.prefix+name, value, f.mkUsage(usage))
}

// UintVar wraps the underlying FlagSet's UintVar function.
func (f *prefixedFlagSet) UintVar(p *uint, name string, value uint, usage string) {
	f.FlagSet.UintVar(p, f.prefix+name, value, f.mkUsage(usage))
}

// Uint wraps the underlying FlagSet's Uint function.
func (f *prefixedFlagSet) Uint(name string, value uint, usage string) *uint {
	return f.FlagSet.Uint(f.prefix+name, value, f.mkUsage(usage))
}

// Uint64Var wraps the underlying FlagSet's Uint64Var function.
func (f *prefixedFlagSet) Uint64Var(p *uint64, name string, value uint64, usage string) {
	f.FlagSet.Uint64Var(p, f.prefix+name, value, f.mkUsage(usage))
}

// Uint64 wraps the underlying FlagSet's Uint64 function.
func (f *prefixedFlagSet) Uint64(name string, value uint64, usage string) *uint64 {
	return f.FlagSet.Uint64(f.prefix+name, value, f.mkUsage(usage))
}
