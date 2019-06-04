# Smush

[![Build Status](https://travis-ci.org/paulholden2/smush.svg?branch=master)](https://travis-ci.org/paulholden2/smush)

Smush is a simple gem that converts a hash into a flat array of key-value
pairs. You can also unsmush the result back into a hash. Note: if an integer
key is encountered, Smush will always assume the target object is an Array.

### Unsmushed
```rb
{
  name: 'John Doe',
  chores: ['Wash dishes', 'Pay rent']
}
```

### Smushed
```rb
[
  {
    key: [:name],
    value: 'John Doe'
  },
  {
    key: [:chores, 0],
    value: 'Wash dishes'
  },
  {
    key: [:chores, 1],
    value: 'Pay rent'
  }
]
```

### How

```rb
require 'smush'

hash = {
  name: 'Bob Smith',
  favorite_foods: ['BLT', 'Hot Dog On A Stick'],
  siblings: [
    {
      name: 'Ron Smith'
    }
  ]
}

smushed = Smush.smush(hash)

# smushed = [
#   {
#     key: [:name],
#     value: 'Bob Smith'
#   },
#   {
#     key: [:favorite_foods, 0],
#     value: 'BLT'
#   },
#   ...
# ]

original = Smush.unsmush(smushed)
```

Smush does not check your inputs for consistency, e.g. check that your
smushed hash doesn't have duplicate keys, or that you aren't skipping
indices in your arrays.
