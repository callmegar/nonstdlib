#!/bin/bash

set -e

FILE="$1"
shift

cat >"$FILE" <<EOF
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

package arrays

import (
	"testing"

	"github.com/turbinelabs/test/assert"
)
EOF

while [ -n "$1" ]; do
    TYPE="$1"
    CAP_TYPE="$(echo "$TYPE" | cut -c1 | tr '[a-z]' '[A-Z]')$(echo "$TYPE" | cut -c2-)"

    NONZERO_VAL="1"
    if [ -n "$2" -a "${2:0:6}" = "value:" ]; then
        NONZERO_VAL="${2:6}"
        shift
    fi

    cat >>"$FILE" <<EOF

func TestEqual${CAP_TYPE}(t *testing.T) {
	var z, nz ${TYPE}
	nz = ${NONZERO_VAL}
	x := []${TYPE}{z, nz, z, nz, z, nz}
	assert.True(t, Equal${CAP_TYPE}(nil, nil))
	assert.True(t, Equal${CAP_TYPE}(x[0:0], x[1:1]))
	assert.True(t, Equal${CAP_TYPE}(x[0:0], nil))
	assert.True(t, Equal${CAP_TYPE}(nil, x[0:0]))
	assert.False(t, Equal${CAP_TYPE}(x[0:1], x[0:2]))
	assert.False(t, Equal${CAP_TYPE}(x[0:2], x[0:1]))
	assert.True(t, Equal${CAP_TYPE}(x, x))
	assert.True(t, Equal${CAP_TYPE}(x[0:3], x[2:5]))
	assert.False(t, Equal${CAP_TYPE}(x[0:3], x[1:4]))
}
EOF
    shift
done
