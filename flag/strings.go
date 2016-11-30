package flag

import (
	"flag"
	"fmt"
	"strings"

	"github.com/turbinelabs/nonstdlib/arrays/indexof"
)

// Strings conforms to the flag.Value and flag.Getter interfaces, and
// can be used populate a slice of strings from a flag.Flag. After
// command line parsing, the values can be retrieved via the Strings
// field. This implementation of flag.Value accepts multiple values
// via a single flag (e.g., "-flag=a,b"), via repetition of the flag
// (e.g., "-flag=a -flag=b"), or a combination of the two styles. Use
// ResetDefault to configure default values or to prepare Strings for
// re-use.
type Strings struct {
	// Populated from the command line.
	Strings []string

	// All possible values allowed to appear in Strings. An empty
	// slice means any value is allowed in Strings.
	AllowedValues []string

	// Delimiter used to parse the string from the command line.
	Delimiter string

	isSet bool
}

var _ flag.Getter = &Strings{}
var _ flag.Value = &Strings{}

// NewStrings produces a Strings with the default delimiter (",").
func NewStrings() Strings {
	return Strings{Delimiter: ","}
}

// NewStrings produces a Strings with a set of allowed values and the
// default delimiter (",").
func NewStringsWithConstraint(allowedValues ...string) Strings {
	return Strings{AllowedValues: allowedValues, Delimiter: ","}
}

// Retrieves the values set on Strings joined by the delimiter.
func (ssv *Strings) String() string {
	return strings.Join(ssv.Strings, ssv.Delimiter)
}

// Resets Strings for use and assigns the given values as the default
// value. Any call to Set (e.g., via flag.FlagSet) will replace these
// values. Default values are not checked against the AllowedValues.
func (ssv *Strings) ResetDefault(values ...string) {
	if values == nil {
		ssv.Strings = []string{}
	} else {
		ssv.Strings = values
	}
	ssv.isSet = false
}

// Sets the value. The first call (after initialization or a call to
// ResetDefault) will replace all current values. Subsequent calls
// append values. This allows multiple values to be set with a single
// command line flag, or the use of multiple instances of the flag to
// append multiple values.
func (ssv *Strings) Set(value string) error {
	parts := strings.Split(value, ssv.Delimiter)

	disallowed := []string{}

	i := 0
	for i < len(parts) {
		parts[i] = strings.TrimSpace(parts[i])
		if parts[i] == "" {
			parts = append(parts[0:i], parts[i+1:]...)
		} else {
			if len(ssv.AllowedValues) > 0 {
				if indexof.String(ssv.AllowedValues, parts[i]) == indexof.NotFound {
					disallowed = append(disallowed, parts[i])
				}
			}
			i++
		}

	}

	if len(disallowed) > 0 {
		return fmt.Errorf(
			"invalid flag value(s): %s",
			strings.Join(disallowed, ssv.Delimiter+" "),
		)
	}

	if ssv.isSet {
		ssv.Strings = append(ssv.Strings, parts...)
	} else {
		ssv.Strings = parts
		ssv.isSet = true
	}

	return nil
}

func (ssv *Strings) Get() interface{} {
	return ssv.Strings
}
