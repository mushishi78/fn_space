# FnSpace

A Ruby class for explicit importing and exporting.

## Example

``` ruby
# my_awsome_project/formula.rb
require 'fn_space'
require 'ostruct'

class FnSpace
  pi = import.('Math::PI')
  struct = import_methods.(:new).from.('OpenStruct')

  circ = ->(r) { 2 * pi * r }
  area = ->(r) { pi * r ** 2 }

  formula = struct.(circumference: circ, area: area)
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
