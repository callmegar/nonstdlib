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
EOF

for TYPE in "$@"; do
    CAP_TYPE="$(echo "$TYPE" | cut -c1 | tr '[a-z]' '[A-Z]')$(echo "$TYPE" | cut -c2-)"
    cat >>"$FILE" <<EOF

func Equal${CAP_TYPE}(a, b []${TYPE}) bool {
	aLen := len(a)
	if aLen != len(b) {
		return false
	}

	if aLen == 0 {
		return true
	}

	for i, aVal := range a {
		if aVal != b[i] {
			return false
		}
	}

	return true
}
EOF
done
