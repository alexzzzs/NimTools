# Changelog

All notable changes to NimTools will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2025-01-02

### Added
- **Collections module** with 16 functional programming helpers
  - `filter`, `map`, `reduce` for functional operations
  - `any`, `all` for predicates
  - `first`, `last`, `isEmpty`, `size`, `hasItem` for access & info
  - `take`, `drop`, `reverse`, `sort`, `chunk`, `unique` for transformations
- Complete API documentation in `DOCUMENTATION.md`
- Installation guides (`INSTALL.md`, `PUBLISHING.md`)
- Verification script (`verify_install.nim`)
- GitHub Actions CI/CD workflow
- Release preparation script
- Comprehensive `.gitignore` and `LICENSE` files

### Changed
- Updated `README.md` with collections examples
- Improved `nimtools.nimble` with better metadata and tasks
- Enhanced project structure for distribution

### Fixed
- Resolved naming conflicts with standard library functions
- Template expansion issues in collections module

## [0.1.0] - 2025-01-01

### Added
- **Numbers module** with 11 numeric helpers
  - `isEven`, `isOdd`, `divisibleBy` for integer checks
  - `between`, `clamp` for range operations  
  - `square`, `cube` for math operations
  - `isWhole`, `near` for float helpers
  - `|>` pipe operator for functional chaining
- **Strings module** with 12 string helpers
  - `startsWith`, `endsWith`, `hasSubstring`, `isEmpty` for checks
  - `toIntSafe`, `toFloatSafe` for safe conversions
  - `trim`, `trimStart`, `trimEnd`, `splitBy`, `repeat`, `reverse` for manipulation
- Comprehensive test suite with 35 tests
- Example usage file
- Basic documentation and README

### Technical Details
- Zero-dependency library using only Nim standard library
- Template-based implementation for zero runtime overhead
- Dot-call syntax support for natural usage
- Generic type support with proper constraints
- Full type safety with compile-time checking

## [Unreleased]

### Planned
- Date/time utilities module
- Math constants and advanced operations
- File system utilities
- Optional macro-based DSLs
- Advanced collections (groupBy, partition, etc.)

---

## Release Process

1. Update version in `nimtools.nimble`
2. Update this `CHANGELOG.md`
3. Run `nim c -r scripts/prepare_release.nim`
4. Commit changes: `git add . && git commit -m "Release vX.Y.Z"`
5. Create tag: `git tag vX.Y.Z`
6. Push: `git push origin main --tags`
7. Publish: `nimble publish` (when ready)