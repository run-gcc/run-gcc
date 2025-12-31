# run-gcc

`run-gcc` is a versatile Bash script designed to simplify the process of compiling and running C and C++ programs. It provides features such as input/output handling, output comparison, and error reporting, making it a convenient tool for developers and testers.

## Features

- Automatically detects the file type (`.c` or `.cpp`) and uses the appropriate compiler (`gcc` or `g++`).
- Supports input redirection from a file.
- Compares program output with an expected output file and displays differences.
- Provides detailed error messages for unsupported file types, missing files, and compilation errors.
- Includes options for displaying help and version information.

## Installation, Update, and Uninstallation

For detailed instructions on installing, updating, and uninstalling `run-gcc`, please refer to the [Installation Guide](docs/installation-guide.md).

### Quick Installation

To install `run-gcc` using the provided `Makefile`, run:

```bash
make install
```

This will install the script to `/usr/bin` and the manual page to `/usr/share/man/man1`.

To uninstall, run:

```bash
make uninstall
```

## Usage

```bash
run-gcc <source_file> [OPTIONS]
run-gcc --new <filename> [--template <name>]
run-gcc --list-templates <extension>
```

### Options

- `-h, --help`  
  Show the help message and exit.

- `-v, --version`  
  Show the script version and exit.

- `-i, --input <file>`  
  Specify an input file to provide input to the program.

- `-e, --expected <file>`  
  Specify an expected output file for comparison.

- `-d, --diff`  
  Show the difference between the program output and the expected output.

### Template Options

- `--new <filename>`  
  Create a new source file from a template.

- `--template <name>`  
  Specify which template to use when creating a new file (default: `default`).

- `--list-templates <extension>`  
  List available templates for a specific file extension (`c`, `cpp`).

## Examples

### Create a New File from Template

```bash
# Create a new C file with the default template
run-gcc --new hello.c

# Create a new C++ file with a specific template
run-gcc --new solution.cpp --template competitive

# List available templates for C files
run-gcc --list-templates c
```

### Compile and Run a C Program

```bash
run-gcc hello.c
```

### Compile and Run a C++ Program

```bash
run-gcc hello.cpp
```

### Run a Program with Input Redirection

```bash
run-gcc hello_with_input.c -i input.txt
```

### Compare Output with Expected Output

```bash
run-gcc hello_with_input.c -i input.txt -e expected_output.txt
```

### Show Differences on Output Mismatch

```bash
run-gcc hello_with_input.c -i input.txt -e wrong_output.txt -d
```

## Template Customization

Templates are stored in `~/.run-gcc/templates/` directory and organized by language:

- `~/.run-gcc/templates/c/` - C templates
- `~/.run-gcc/templates/cpp/` - C++ templates

You can customize existing templates or add new ones by creating files in these directories. Template files must match the extension of the language they're for (e.g., `.c` for C templates, `.cpp` for C++ templates).

### Built-in Templates

The following templates are included by default:

**C Templates:**
- `default` - Basic C program structure
- `competitive` - Competitive programming template with common includes

**C++ Templates:**
- `default` - Basic C++ program structure
- `competitive` - Competitive programming template with fast I/O and common includes

### Adding Custom Templates

To add your own template:

1. Create a new file in the appropriate language directory (e.g., `~/.run-gcc/templates/c/mytemplate.c`)
2. Add your template code to the file
3. Use it with `run-gcc --new myfile.c --template mytemplate`


## Testing

The project includes automated tests written in [Bats](https://github.com/bats-core/bats-core). To run the tests, execute:

```bash
make test
```

## Contributing

Contributions are welcome! If you'd like to contribute to `run-gcc`, please follow the guidelines outlined in the [Contributing Guide](docs/CONTRIBUTING.md).

### How to Get Started

1. Fork the repository and clone it locally.
2. Create a new branch for your feature or bug fix.
3. Make your changes, ensuring they follow the project's coding conventions.
4. Test your changes thoroughly.
5. Submit a pull request with a detailed description of your changes.

For more details, refer to the [Contributing Guide](docs/CONTRIBUTING.md).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
