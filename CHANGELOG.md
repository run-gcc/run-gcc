# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.0-beta] - 2025-12-31

### Added
- Template system for creating new C/C++ files from predefined templates
  - `--new <filename>` flag to create new files from templates
  - `--template <name>` flag to specify which template to use (default: "default")
  - `--list-templates <extension>` flag to list available templates for a language
- Built-in templates for C and C++:
  - `default`: Basic program skeleton
  - `competitive`: Competitive programming template with fast I/O and common includes
- Template directory structure at `~/.run-gcc/templates/{c,cpp}/`
- Support for custom user templates
- Template configuration in `.run-gccrc` file
- System-wide template installation via Makefile

### Changed
- Color output now automatically disabled when not running in a terminal (fixes test compatibility)
- Updated help message to include template options
- Updated man page with template documentation

### Fixed
- Tests now pass correctly with non-TTY output (no ANSI color codes in test mode)

## [1.3.0] - 2025-08-06

### Added
- Performance metrics support
- TLE (Time Limit Exceeded) checks
- MLE (Memory Limit Exceeded) checks
- Updated status message format

## [1.2.0] - 2025-07-30

### Added
- `--generate-config` flag to create configuration files
  - `--global` or `-g` flag for creating config at `$HOME`
  - `--local` flag for creating config in current directory (default)

## [1.1.0] - 2025-07-26

### Added
- Configuration file support (global `~/.run-gccrc` and local `./.run-gccrc`)
- `--no-config` flag to skip configuration loading
- Configuration variables for enhanced flexibility:
  - Default compiler (gcc/g++)
  - Default input/expected output files
  - Cleanup options
  - Execution timeout

### Changed
- Script logic honors values from config files with fallback to defaults
- Improved default behavior for customization and automation

### Documentation
- Added example `.run-gccrc` file
- Updated help output and README

## [1.0.0] - 2025-04-05

### Added
- Compiler automation with automatic source file extension detection
- Enhanced input file redirection support
- Output diff comparison for testing
- Enhanced logging and error reporting

### Changed
- Streamlined workflow with automated compiler selection
- Improved error messaging

## [0.1.0] - 2025-04-03

### Added
- Initial release
- Project structure with initial files
- Debian package builder integration
- Basic compile-and-run environment
