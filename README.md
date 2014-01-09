# Entizeta

Simple entity converter, used in command line interface.

## Installation

Download binary and place it in the folder in your `$PATH`.

### Using [Homebrew](http://brew.sh)?

```bash
brew tap niksy/pljoska
brew install entizeta
```

## Usage

```bash
entizeta [option] [value]

Options:
  to-decimal                   Convert from character to decimal value
  to-hexadecimal               Convert from character to hexadecimal value
  to-numeric-entity            Convert string to numeric entities (default option)
  from-decimal                 Convert from decimal to character value
  from-hexadecimal             Convert from hexadecimal to character value
  from-numeric-entity          Convert numeric entities to string
  -h, --help                   Display this help and exit

Notes:
  * When used without quotes, \, " and ' must be escaped.
  * When used with double-quotes, \ and " must be escaped.
  * When used with single-quotes, ' can’t be processed.
```

## Background

I grew tired of not being able to have simple utility which allows me to convert various characters to their decimal and hexadecimal values, and also their numeric entities.

Project started with simple implementation in PHP using basic converter methods. As I started using more obscure characters as testing values, it soon became clear that those basic methods obviously aren’t made to deal with those characters.
So I started my quest in finding proper solution(s) which will cover all known characters. As you can probably imagine, this was not an easy task to do, and result of that can be seen in the source code.

Also, I wanted to do another implementation in JS using Node.js to see what kind of sorcery both languages use to execute this seemingly easy task. Node.js is used as default converter, but it’s optional.

---

Entizeta is portmanteau of "entities" and [Rosetta Stone](http://en.wikipedia.org/wiki/Rosetta_Stone). Originality of this name is questionable :)
