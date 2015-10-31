# FnSpace

FnSpace is a space where functions can be treated as first class objects. It
provides import and export helpers that prioritize functions and utility
methods to enable functional paradigms.

## Example

``` ruby
# my_awsome_project/formula.rb
require 'fn_space'

fn_space(:Formula) do |import, exports|
  pi = 3.14
  exports.circ = ->(r) { 2 * pi * r }
  exports.area = ->(r) { pi * r ** 2 }
end
```

``` ruby
# my_awsome_project/other_file.rb
require 'fn_space'
require_relative 'formula'

fn_space do |import|
  fn1, fn2 = import.(:area, :circ).from Formula
  fn1.(8) # 200.96
  fn2.(8) # 50.24
end
```

## Usage

### `fn_space(const = nil) { |import, exports| block }`

`fn_space` is a global method that executes a block passed to it in an
anonymous module. It passes two arguments to the provided block, `import` and
`exports`.

It optionally takes a new constant's name as it first argument, which will then
be used to store any properties added to the `exports` OpenStruct.

### `import.(*names).from Source`

`import.()` can be used to import properties from a source. If only a single
property is requested then only a single value will be return, otherwise an
array will be.

``` ruby
MagicNumbers = Struct.new(:a, :b, :c).new(5, 7, 19)

fn_space do |import|
  b = import.(:b).from MagicNumbers
  c, a = import.(:c, :a).from MagicNumbers

  a + b + c # 31
end
```

### `import.methods.(*names).from Source`

`import.methods.()` can be used to import methods from a source as method objects.

``` ruby
fn_space do |import|
  tan = import.methods.(:tan).from Math
  sin, cos = import.methods.(:sin, :cos).from Math
  pi = Math::PI

  tan.(0) # 0
  sin.(pi/2) # 1.0
  cos.(pi) # -1.0
end
```

## Utils

### `mod.()`

`mod.()` creates a new anonymous module with an `assign` singleton method that
can be used to create singleton methods in a chain.

``` ruby
fn_space do |import|
  mod = import.(:mod).from FnSpace::Utils
  foo = mod.()
    .assign(:add) { |a, b| a + b }
    .assign(:take) { |a, b| a - b }

  foo.add(3, 4) # 7
  foo.take(5, 2) # 3
end
```

### `struct.(hash)`

`struct.()` takes a hash and creates a new anonymous module with properties
taken from the hash.

``` ruby
fn_space do |import|
  struct = import.(:struct).from FnSpace::Utils
  crds = struct.(x: 0.5, y: 1.5, z: -1.0)
  crds.x  + crds.y + crds.z # 1.0
end
```

### `chain.(value)`

`chain.()` wraps around a value and can be used to chain functions to be applied
to the value. It does this by providing the following methods:

* `>>` - Applies a function to the value and replaces the value with the result.
* `<<` - Applies a function to the value but does not replace the value.
* `|`  - Applies a function to the chain object itself.
* `value` - Returns the value.

Function arguments have their `#to_proc` method called first such that symbols
can be used to call methods on an object.

``` ruby
fn_space do |import|
  chain = import.(:chain).from FnSpace::Utils

  double = ->(v) { v * 2 }
  log = ->(v) { puts v }

  res = chain.(3) >> double >> :next << log >> double << log >> :next | :value
  # 7
  # 14
  puts res # 15
end
```

### `apply_send.(*args)`

`apply_send.()` can be used to apply arguments to an object's `send` method.
This can useful used in conjunction with the `chain` utility.

``` ruby
fn_space do |import|
  chain, send = import.(:chain, :apply_send).from FnSpace::Utils
  chain.(2) >> send.(:**, 3) >> send.(:/, 4) | :value # 2
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
