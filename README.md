# ExOptimizer

ExOptimizer is a tool to optimize pictures by running them through a chain of various image optimization tools. It's heavily inspired by the tool [ImageOptimizer](https://github.com/spatie/image-optimizer) for PHP.

Here's how you can use it:

```elixir
ExOptimizer.optimize(path_to_image)
```

The image at `path_to_image` will be overwritten by an optimized version which should be smaller. The package will automatically detect which optimization binaries are installed on your system and use them.

## Installation

You can install the package through Hex.pm by adding `ex_optimizer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_optimizer, "~> 0.1.0"}
  ]
end
```

Then running `mix deps.get` to fetch the package.
[https://hexdocs.pm/ex_optimizer](https://hexdocs.pm/ex_optimizer).

# Optimization tools

The package will use these optimizers if they are present on your system:

* [JpegOptim](http://freecode.com/projects/jpegoptim)
* [Optipng](http://optipng.sourceforge.net/)
* [Pngquant 2](https://pngquant.org/)
* [SVGO](https://github.com/svg/svgo)
* [Gifsicle](http://www.lcdf.org/gifsicle/)
* [cwebp](https://developers.google.com/speed/webp/docs/precompiled)

Here's how to install all the optimizers on Ubuntu:

```bash
sudo apt-get install jpegoptim
sudo apt-get install optipng
sudo apt-get install pngquant
sudo npm install -g svgo
sudo apt-get install gifsicle
sudo apt-get install webp
```

And here's how to install the binaries on MacOS (using [Homebrew](https://brew.sh/)):

```bash
brew install jpegoptim
brew install optipng
brew install pngquant
brew install svgo
brew install gifsicle
brew install webp
```

# Changelog

Please see [CHANGELOG](changelog.html) for more information what has changed recently.

# Testing

```sh
mix test
```

You can see coverage with
```sh
mix coveralls.html
```

# Support us

[Framasoft](https://framasoft.org/en/) is a French not-for-profit popular educational organisation that lives only through your donations. It provides free online services part of the [De-google-ify Internet](https://degooglisons-internet.org/en/) campaign and leads projects like [PeerTube](https://joinpeertube.org/en/) and [Mobilizon](https://joinmobilizon.org/en/).
