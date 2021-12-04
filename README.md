# Get Next Line <!-- omit in toc -->

#### Bonus A  <!-- omit in toc -->

get next line project for [42 | São Paulo](https://github.com/42sp) / [École 42](https://github.com/42School)

- ***[Level 01](https://github.com/psudo-dev/42cursus_index)***
  - ***02. Get Next Line***

### Table of Contents  <!-- omit in toc -->

- [Project](#project)
- [Usage](#usage)
- [get_next_line](#get_next_line)
  - [Mandatory Part](#mandatory-part)
  - [Bonus Part](#bonus-part)
- [Tests](#tests)
- [Issues and Suggestions](#issues-and-suggestions)
- [References and Links](#references-and-links)
- [License](#license)

## Project

As the name says, the function `get_next_line` is a function that uses `read()` to read a file associated with the `file descriptor` and returns the next line of the file. And the function does it by reading the file in chunks of size `BUFFER_SIZE` until it completes the line every time it's called.

#### _malloc( )_ and _free( )_ <!-- omit in toc -->

Memory allocation and deallocation functions.

```c
#include <stdlib.h>
```

#### _read( )_ <!-- omit in toc -->

Reads `nbyte` from the file associated with `file descriptor` `fd` into the `buffer` pointer and it returns the number of bytes read.

```c
#include <unistd.h>

ssize_t read(int fd, void *buffer, size_t nbyte);
```

## Usage

#### Clone the repository <!-- omit in toc -->

```sh
git clone https://github.com/psudo-dev/42cursus_02_get_next_line.git <DIR_NAME>
```

### Makefile <!-- omit in toc -->

#### Commands <!-- omit in toc -->
>
> - **`make`** *compiles `get_next_line.a` library*
> - **`make clean`** *cleans object files*
> - **`make fclean`** *cleans object files and `get_next_line.a`*
> - **`make re`** *cleans project files and recompiles*
> - **`make exit`** *cleans project files and delete test files*
> - **`make norm <DIR>`** *runs norminette*
>   - *<span style="font-size:0.8em; color:rgba(0, 0, 0, 0.75)">(default = root directory)</span>*

---

## get_next_line

### Mandatory Part

I think the main thing about this project was to understand how the function `read()` works because at first it got me a bit confused.

I thought I had to find a way to make the function `read()` read the next buffer btu actually the functino `read()` does a lot under the hood. It also cleans everything necessary that it is responsible for.

The next big task was to learn how to deal with a project composed of several functions, how to organize it or pass data from one function to another. But mainly how to solve `Segmentation Fault` and memory leaks, that was certainly a nightmare.

### Bonus Part

There was not much left to do in the bonus part so it was just an implementation to deal with multiple files and maintaining coherence between calls and files.

---

### Directories and Files <!-- omit in toc -->

> - `Makefile`
> - `inc/`
>   - `get_next_line.h`
>   - `get_next_line_bonus.h`
> - `src/`
>   - _`get_next_line.c`
>   - _`get_next_line_utils.c`
>   - _`get_next_line_bonus.c`
>   - _`get_next_line_utils_bonus.c`

## Tests

- [Tripouille](https://github.com/Tripouille/gnlTester)

#### Commands <!-- omit in toc -->
>
> - **`make t`** *clones get_next_line tester to `/test` directory*
> - **`make m`** *runs `mandatory` tests*
> - **`make b`** *runs `bonus` tests*
> - **`make a`** *runs `all` tests*
> - **`make c`** *cleans test object files*
> - **`make f`** *cleans **`*.c`**, **`*.o`** and **`*.h`** and `get_next_line.a`*
> - **`make r`** *rebuilds `test` files*
> - **`make d`** *deletes `test` files*

## Issues and Suggestions

-   Feel free to contact me or create an [issue](https://github.com/psudo-dev/42cursus_02_get_next_line/issues/new/choose)!

## References and Links

- <https://github.com/42sp>
- <https://github.com/42School>
- <https://github.com/Tripouille/gnlTester>

## License

-   [GNU General Public License v3.0](https://github.com/psudo-dev/42cursus_02_get_next_line/blob/main/LICENSE.md)
