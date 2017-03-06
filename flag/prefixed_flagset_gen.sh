#!/bin/bash

# Copyright 2017 Turbine Labs, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Each argument is treated as a type to generate a pair of flagset-style functions

SCRIPT=`basename $0`
FILE="gen_prefixed_flagset.go"
IFACE_FILE="gen_flagset.go"
TEST_FILE="gen_prefixed_flagset_test.go"
LICENSE="/*
Copyright 2017 Turbine Labs, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/"

cat >$FILE <<EOF
$LICENSE

// This file was automatically generated by $SCRIPT.
// Any changes will be lost if this file is regenerated.

package flag

import (
	"time"
)
EOF

cat >$IFACE_FILE <<EOF
$LICENSE

// This file was automatically generated by $SCRIPT.
// Any changes will be lost if this file is regenerated.

package flag

import (
	"flag"
	"time"
)

// FlagSet represents an optionally scoped *flag.FlagSet.
type FlagSet interface {
	// Scope creates a new scoped FlagSet. The name of any flag
	// added to the new FlagSet is prefixed with the given
	// prefix. In the flag's uage, the expression "{{NAME}}", is
	// replaced with the given description.
	Scope(prefix, description string) FlagSet

	// Unwrap returns the flag.FlagSet underlying this FlagSet.
	Unwrap() *flag.FlagSet

	// Var defines a flag with the specified name and usage. The
	// flag's type and value are derived from value. See
	// flag.FlagSet.Var for more information.
	Var(value flag.Value, name string, usage string)
EOF

cat >$TEST_FILE <<EOF
$LICENSE

// This file was automatically generated by $SCRIPT.
// Any changes will be lost if this file is regenerated.
package flag

import (
	"reflect"
	"time"
)

var (
	generatedTestCases = []prefixedFlagTestCase{
EOF

while [ -n "$1" ]; do
    T="$1"
    FNAME=$(echo $T | cut -d. -f2-)
    if [ "$FNAME" == "$T" ]; then
        FNAME="$(tr '[:lower:]' '[:upper:]' <<<${T:0:1})${T:1}"
    fi
    FNAMELOWER=$(tr '[:upper:]' '[:lower:]' <<<$FNAME)

    cat >>$FILE <<EOF

// ${FNAME}Var wraps the underlying FlagSet's ${FNAME}Var function.
func (f *prefixedFlagSet) ${FNAME}Var(p *${T}, name string, value ${T}, usage string) {
	f.FlagSet.${FNAME}Var(p, f.prefix+name, value, f.mkUsage(usage))
}

// ${FNAME} wraps the underlying FlagSet's ${FNAME} function.
func (f *prefixedFlagSet) ${FNAME}(name string, value ${T}, usage string) *${T} {
	return f.FlagSet.${FNAME}(f.prefix+name, value, f.mkUsage(usage))
}
EOF

    cat >>$IFACE_FILE <<EOF

	// ${FNAME}Var defines a ${T} flag with the specified name,
	// default value, and usage. The flag's value is stored in p.
	${FNAME}Var(p *${T}, name string, value ${T}, usage string)

	// ${FNAME} defines a ${T} flag with the specified name,
	// default value, and usage. The return value is a pointer
	// to a variable that stores the flag's value.
	${FNAME}(name string, value ${T}, usage string) *${T}
EOF


    ZEROVAL="${T}(0)"
    if [ "$T" == "bool" ]; then
        ZEROVAL="false"
    fi

    cat >>$TEST_FILE <<EOF
		{
			name:     "${FNAMELOWER}",
			flagType: reflect.TypeOf(${ZEROVAL}),
			addFlag: func(f *prefixedFlagSet) interface{} {
				return f.${FNAME}(
					"${FNAMELOWER}",
					${ZEROVAL},
					flagUsage,
				)
			},
		},
		{
			name:     "${FNAMELOWER}-var",
			flagType: reflect.TypeOf(${ZEROVAL}),
			addFlag: func(f *prefixedFlagSet) interface{} {
				var target ${T}
				f.${FNAME}Var(
					&target,
					"${FNAMELOWER}-var",
					${ZEROVAL},
					flagUsage,
				)
				return &target
			},
		},
EOF

    shift
done

cat >>$IFACE_FILE <<EOF
}
EOF

cat >>$TEST_FILE <<EOF
	}
)
EOF
