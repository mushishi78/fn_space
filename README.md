# FnSpace

A Ruby class for explicit function importing and exporting.

## Example

``` ruby
require 'fn_space'

module Foo
  def self.add(a, b)
    a + b
  end

  def self.take(a, b)
    a - b
  end
end

Bar = {
  times: ->(a, b) { a * b }
}

class FnSpace
  add, take = import(:add, :take).from 'Foo'
  times = import(:times).from 'Bar'

  result = ->(a, b) { add.(times.(a, b), take.(a, b)) }

  export(result: result).as 'Sums'
end

Sums[:result].(5, 8) # 37
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
