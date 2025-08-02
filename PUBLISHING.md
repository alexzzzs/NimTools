# Publishing NimTools

This guide explains how to make NimTools available for installation by others.

## Option 1: Publish to Nimble Package Registry (Recommended)

### Prerequisites
1. Create a GitHub repository for the project
2. Have a Nimble/Nim installation
3. Have Git configured

### Steps to Publish

#### 1. Create GitHub Repository
```bash
# Initialize git repository
git init
git add .
git commit -m "Initial commit: NimTools v0.2.0"

# Create repository on GitHub and push
git remote add origin https://github.com/yourusername/nimtools.git
git branch -M main
git push -u origin main
```

#### 2. Tag the Release
```bash
# Create and push a version tag
git tag v0.2.0
git push origin v0.2.0
```

#### 3. Submit to Nimble Registry
```bash
# Submit package to Nimble registry
nimble publish
```

Or manually submit by creating a pull request to:
https://github.com/nim-lang/packages

Add this entry to `packages.json`:
```json
{
  "name": "nimtools",
  "url": "https://github.com/yourusername/nimtools",
  "method": "git",
  "tags": ["utility", "helpers", "functional", "strings", "numbers", "collections"],
  "description": "Lightweight, zero-dependency Nim library with expressive helper APIs",
  "license": "MIT",
  "web": "https://github.com/yourusername/nimtools"
}
```

### After Publishing

Users can install with:
```bash
nimble install nimtools
```

And use in their code:
```nim
import nimtools
# or
import nimtools/numbers
import nimtools/strings  
import nimtools/collections
```

## Option 2: Direct Git Installation

Users can install directly from Git:

```bash
# Install from GitHub
nimble install https://github.com/yourusername/nimtools.git

# Install specific version
nimble install https://github.com/yourusername/nimtools.git@v0.2.0
```

## Option 3: Local Development Installation

For local development or testing:

```bash
# Clone the repository
git clone https://github.com/yourusername/nimtools.git
cd nimtools

# Install in development mode
nimble develop

# Or install locally
nimble install
```

## Verification

After installation, users can verify it works:

```nim
# test_install.nim
import nimtools

echo "Numbers: ", 5.square
echo "Strings: ", "hello".reverse  
echo "Collections: ", @[1,2,3].map(proc(x: int): int = x * 2)
```

```bash
nim c -r test_install.nim
```

## Package Maintenance

### Updating the Package

1. Update version in `nimtools.nimble`
2. Update `CHANGELOG.md` (if you create one)
3. Commit changes
4. Create new tag: `git tag v0.3.0`
5. Push: `git push origin v0.3.0`
6. The package registry will automatically pick up the new version

### Best Practices

- Use semantic versioning (MAJOR.MINOR.PATCH)
- Keep `README.md` and `DOCUMENTATION.md` up to date
- Add comprehensive tests for new features
- Tag releases consistently
- Write clear commit messages

## Troubleshooting

### Common Issues

1. **Package name conflicts**: Choose a unique name
2. **Version conflicts**: Ensure version in nimble file matches git tag
3. **Dependencies**: Keep dependencies minimal for wider compatibility
4. **Documentation**: Ensure examples in README work with the published version

### Testing Before Publishing

```bash
# Test the package works as expected
nimble test

# Test installation locally
nimble install

# Test in a separate project
mkdir test_project
cd test_project
nimble init
# Add nimtools as dependency and test
```