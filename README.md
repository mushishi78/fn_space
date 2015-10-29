# FnSpace

`FnSpace` is a space where functions can be treated as first class
objects. It provides import and export helpers that serve to elevate the stature
of functions and utility methods to encourage the use of more functional
paradigms.

Within the `FnSpace` class scope, tradition constant lookup will fail. This is
because it directly inherits from `BasicObject`. The purpose is of this is to
foster a discipline of using import helpers.

## Example

``` ruby
# my_awsome_project/formula.rb
require 'fn_space'
require 'ostruct'

class FnSpace
  pi = import.('Math::PI')
  ostruct = import_methods.(:new).from.('OpenStruct')

  circ = ->(r) { 2 * pi * r }
  area = ->(r) { pi * r ** 2 }

  formula = ostruct.(circumference: circ, area: area)
  export.(formula).as.('Formula')
end
```

``` ruby
# my_awsome_project/other_file.rb
require 'fn_space'
require_relative 'formula'

class FnSpace
  fn1, fn2 = import.(:area, :circumference).from.('Formula')
  p fn1.(8) # 201.06...
  p fn2.(8) # 50.265...
end
```

## Usage

### `FnSpace.import`

If given a the name of a constant, `import` fetches it.

``` ruby
pi = import.('Math::PI')
```

If given a list of properties, `import` returns an object with a `from` method
that can be used to supply the name of constant. It then returns an array
of the values of those properties.

``` ruby
fn1, fn2 = import.(:area, :circumference).from.('Formula')
```

### 'FnSpace.import_methods'

`import_methods` takes a list of methods, and returns an object with a `from` method
that can be used to supply the name of constant. It then returns an array
of those methods as method objects.

``` ruby
ostruct = import_methods.(:new).from.('OpenStruct')
```

Note: Method objects are still bound to their original objects, unless you
explicitly `unbind` them.

### `FnSpace.export`

`export` can be used to assign an object to a constant.

``` ruby
export.(formula).as.('Formula')
```

## Installation

Add your Gemfile:

```ruby
gem 'fn_space'
```

## Contributing

1. [Fork it]( https://github.com/mushishi78/fn_space/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
