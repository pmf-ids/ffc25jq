#!/usr/bin/env -S jq -Rrnf

["[\(inputs)]" | fromjson]
| (group_by(.) | max_by(length)[0] | join(","))
, (map(select(unique[2] == .[1])) | length)
, add([5,2,4,10][.[] | index(unique[2]) // -1])
