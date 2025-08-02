# Changelog

All notable changes to NimTools will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2025-02-08

### Fixed
- Fixed anonymous procedure naming conflicts in collections test suite
- Resolved CI/CD compilation errors that were causing test failures
- All tests now pass successfully across all platforms

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

## [0.3.0] - 2025-01-02

### Added
- **Comprehensive error handling** with runtime validation
  - `IndexDefect` for empty sequence access (`first`, `last`)
  - `ValueError` for invalid parameters (`chunk`, `reduce`, `clamp`, `repeat`)
  - `DivByZeroDefect` for division by zero (`divisibleBy`)
  - Bounds checking enabled in debug builds
  - Enhanced edge case handling for string operations
- **New validation module** (`nimtools/validation`) with safe wrapper functions
  - `safeFirst`, `safeLast`, `safeReduce` for always-validated operations
  - `safeChunk`, `safeDivisibleBy`, `safeClamp` with parameter validation
  - `requireNonEmpty`, `requirePositive`, `requireNonZero` validation helpers
- **Comprehensive documentation**
  - `ERROR_GUIDE.md` with examples and best practices
  - Error handling examples (`examples_error_handling.nim`)
  - Updated API documentation with error handling information
- New error handling test suite with 12 validation tests
- New validation module test suite with comprehensive coverage

### Improved
- Better edge case handling for `startsWith` and `endsWith` with empty strings
- More robust parameter validation across all modules
- Enhanced compile-time safety with clearer error messages
- Updated README with error handling section and examples

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