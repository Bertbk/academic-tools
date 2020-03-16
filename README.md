# Hugo Thm

The [`Academic`](https://github.com/gcushen/hugo-academic/) theme provides a [nice layout (=design) for documentation](https://sourcethemes.com/academic/docs/writing-markdown-latex/). The math expression can be written mostly as in a basic LaTeX file thanks to MathJax (just set `math = true` in the frontmatter of your `.md` file). Some features were however missing for a math course, especially the "AMS Theorem environment" of LaTeX.

This is the purpose of this small "theme".

## Features

This "theme" contains [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/#readout) that mimic the LaTeX AMS Theorem environment. A shortcode is a portion of code that `Hugo` will escape from the Markdown, making it possible to call external functions inside the Markdown. It features

- Customizable design
- Different type: Theorem, Proposition, Lemma, Corollary, Definition
- Theorem naming
- Cross reference
- Multi languages
- Proof environment
- Auto numbering (using CSS)

## Example

### Thm blocks

```md
{{< thm/thm type="theorem" name="of me" label="thm:me" >}}
This theorem proves that covfefe.
{{< /thm >}}
{{< thm/proof >}}
The proof is very good. I like proof. I have big proof.
{{< /thm/proof >}}
```

leads to this

![Thm + Proof example](static/img/thm-block.png)


You can change `type="theorem"` by `proposition`, `lemma`, `corollary` or `definition`.

### Cross reference

A "theorem" can moreover be referenced using `thm/ref` using three different ways:

1. **Inline implicit** (order of arguments matters) :
  ```md
  Personally, my favorite is the {{< thm/ref "thm:me" "covfefe Theorem" />}}.
  ```
2. **Inline explicit**  (order of arguments does not matter!):
  ```md
  Personally, my favorite is the {{< thm/ref ref="thm:me" text="covfefe Theorem" />}}.
  ```
3. **Environment**:
  ```md
  Personally, my favorite is the {{< thm/ref "thm:me">}}covfefe Theorem{{< /thm/ref >}}.
  ```

The result being the following:

![Cross Reference example](static/img/thm-cross-ref.png)

### Remark

As you notice and contrary to LaTeX, the cross reference do not provide the number of the theorem. This is a little bit complicated as the numbering is done through CSS counter and I believe it is not necessary. However, if you are interested in, we can discuss about it. 


## Installation

Here is explained how to install `hugo-thm` in conjunction with `Academic` theme but it can be easily adapted to any other theme.

There are 2.5 ways of installing it:

1. As a theme (simplest, recommended), through...
  - ... Direct download (non `git` users)
  - ... `git` submodule (updatable, customisable)
2. As a Go module (easy but not customisable)


### As a Theme

#### Download it

You now have to download the "theme" using one of these way:

1. Direct Download :
   - Download [the last version](https://github.com/Bertbk/hugo-thm/archive/master.zip)
   - Extract and place `hugo-thm` folder in your `themes` folder
2. Git submodule. At the root your folder, type the following command
    ```bash
    git submodule add https://github.com/Bertbk/hugo-thm.git themes/hugo-thm
    ```


#### Tell Hugo to use it

1. Add `"hugo-thm"` as a theme in `config/_default/config.toml`. Place it after `"academic"` (order matters):
    ```toml
    #params.toml
    # Name of Academic theme folder in `themes/`.
    theme = ["academic", "hugo-thm"]
    ```
2. If your academic version is...
  - Greater than v4.6: create (if not already done) a file in `assets/scss/custom.scss` and add this line
    ```scss
    @import "thm";
    ```
  - Less than v4.6: Add `"thm"` to `plugins_css` in `config/_default/params.toml`:
    ```toml
    # params.toml
    plugins_css = ["thm"]
    ```

#### Remarks


- To use `git submodule`, your folder must also be a git repo!
- Do not forget to commit/add `.gitmodules`
- If you have set SSH key then you can use `ssh` instead of `https`:
    ```bash
    git submodule add git@github.com:Bertbk/hugo-thm.git themes/hugo-thm
    ```
  You can modify the `.gitmodules` file accordingly. 
- If, in addition to SSH, your website is automatically build through Gitalb page. You might need to add your ssh key to Gitlab variable and mofidy your `.gitlab-ci`.


### (Hu)Go Module

Add the following line at the end of your `config/_default/config.toml`:
```toml
#config.toml
# Modules
[module]
  proxy = "direct"
  
  [[module.imports]]
    disable = false
    ignoreConfig = false
    path = "github.com/Bertbk/hugo-thm"
```

Then type the following commands at the root of your folder
```
hugo mod init `pwd`
hugo mod get -u
```

## Customization

If you know a little bit about the CSS then is it quite easy, the main file being `assets/scss/thm.scss`. If you do not know about CSS but want to change the colors, no problem, have a look at `assets/scss/thm.scss` file and search for the colors, you will quickly understand how it works.


Remark: it seems that the css file are hidden when installing this package as a Go Module.
