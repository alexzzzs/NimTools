# NimTools Installation Guide

This guide covers all the ways to install and use NimTools.

## Quick Start

### Option 1: Install from Nimble (Recommended when published)

```bash
# Install the latest version
nimble install nimtools

# Install a specific version
nimble install nimtools@0.2.0
```

### Option 2: Install from Git Repository

```bash
# Install latest from main branch
nimble install https://github.com/yourusername/nimtools.git

# Install specific version/tag
nimble install https://github.com/yourusername/nimtools.git@v0.2.0
```

### Option 3: Local Development Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/nimtools.git
cd nimtools

# Install locally
nimble install

# Or install in development mode (creates symlink)
nimble develop
```

## Verification

After installation, verify it works:

```bash
# If you have the source code
nimble verify

# Or create a test file
echo 'import nimtools; echo 5.square' > test.nim
nim c -r test.nim
```

## Usage

### Import Everything
```nim
import nimtools

# Now you can use all functions
echo 4.isEven                    # Numbers
echo "hello".reverse             # Strings  
echo @[1,2,3].map(proc(x: int): int = x * 2)  # Collections
```

### Import Specific Modules
```nim
import nimtools/numbers          # Only number helpers
import nimtools/strings          # Only string helpers
import nimtools/collections      # Only collection helpers
```

### Avoid Import Conflicts
```nim
# Import collections before std/options to avoid filter conflicts
import nimtools/collections
import std/options

# Or use qualified imports
from nimtools/numbers import nil
echo numbers.isEven(4)
```

## Requirements

- **Nim**: Version 1.6.0 or higher
- **Operating System**: Windows, macOS, Linux
- **Dependencies**: None (zero-dependency library)

## Package Information

- **Name**: nimtools
- **Version**: 0.2.0
- **License**: MIT
- **Author**: NimTools Contributors
- **Repository**: https://github.com/yourusername/nimtools

## Features

- **39 helper functions** across 3 modules
- **Zero runtime overhead** (template-based)
- **Dot-call syntax** for natural usage
- **Type-safe** with full generic support
- **Comprehensive documentation** and examples

## Troubleshooting

### Common Issues

#### "cannot open file: nimtools"
- **Cause**: Package not installed or not in Nim's path
- **Solution**: Run `nimble install nimtools` or check installation

#### Import conflicts with standard library
- **Cause**: Function name conflicts (e.g., `filter` with std/options)
- **Solution**: Import nimtools modules before standard library modules

#### Version conflicts
- **Cause**: Multiple versions installed
- **Solution**: `nimble uninstall nimtools` then reinstall specific version

### Getting Help

1. **Documentation**: See `DOCUMENTATION.md` for complete API reference
2. **Examples**: Check `example.nim` for usage patterns
3. **Issues**: Report bugs on GitHub repository
4. **Community**: Ask questions on Nim forums or Discord

## Development Setup

If you want to contribute or modify NimTools:

```bash
# Clone and setup
git clone https://github.com/yourusername/nimtools.git
cd nimtools

# Run tests
nimble test

# Run example
nimble example

# Generate docs
nimble docs

# Clean build artifacts
nimble clean
```

## Uninstallation

```bash
# Remove the package
nimble uninstall nimtools

# Remove all versions
nimble uninstall nimtools --force
```

## Next Steps

After installation:

1. **Read the documentation**: `DOCUMENTATION.md` has complete API reference
2. **Try the examples**: Run `nimble example` to see it in action
3. **Explore the modules**: Start with the module that fits your needs
4. **Check the tests**: Look at `tests/` directory for more usage examples

## Support

- **Documentation**: Complete API reference in `DOCUMENTATION.md`
- **Examples**: Working examples in `example.nim`
- **Tests**: Comprehensive test suite in `tests/` directory
- **Issues**: Report problems on GitHub
- **License**: MIT (see `LICENSE` file)