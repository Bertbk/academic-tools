# Academic Tools

This is an add-on for the ~~[`Academic`](https://github.com/gcushen/hugo-academic/)~~  [`Wowchemy`](https://github.com/wowchemy/wowchemy-hugo-module/) theme for the static site generator [Hugo](https://gohugo.io). This short package brings new widgets and shortcode:

- Widget Next Talk: Display the next talk, for a website dedicated to a seminar for example
- `Thm` shortcode: mimic `amsthm` latex package
- `button` shortcode: for a nice bootstrap-styled button


## Installation

Obviously, the ~~academic~~ [`Wowchemy`](https://github.com/wowchemy/wowchemy-hugo-module/) theme is requiered.

This package can be installed as a *theme* or as a *hugo module*. The process is slitly different choosing of one each.

### As a Theme

Fist, download it. Second, set it as a (sub-)theme.

#### Download

1. Direct Download :
   - Download [the last version](https://github.com/Bertbk/academic-tools/archive/master.zip)
   - Extract and place `academic-tools` folder in your `themes` folder
2. Git submodule (**recommended**). At the root your folder, type the following command
    ```bash
    git submodule add https://github.com/Bertbk/academic-tools.git themes/academic-tools
    ```
3. Hugo module : Add the following lines at the bottom of `config/_default/config.toml`:

```toml
[module]
  [[module.imports]]
    path = "github.com/Bertbk/academic-tools"
```
#### Configure

1. (Skip this step if using hugo module!) Add `"academic-tools"` as a theme in `config/_default/config.toml`: 
    ```toml
    theme = ["academic-tools"]
    ```
    If using old `"academic"` theme then place it last (order matters):
    ```toml
    theme = ["academic", "academic-tools"]
    ```
1. Create (if not already done) a file in `assets/scss/custom.scss` and add this line inside
    ```scss
    @import "academic-tools";
    ```
2. For Next Talk widget: add [FontAwesome JS file](https://fontawesome.com/): in `/layouts/partials/custom_js.html` (create it if necessary), add the following line
```html
<script src="https://use.fontawesome.com/releases/v{{ site.Data.assets.css.fontAwesome.version}}/js/all.js"></script>
```

### Remarks

- To use `git submodule`, your folder must also be a git repo!
- Do not forget to commit/add `.gitmodules`
- If you have set SSH key then you can use `ssh` instead of `https`:
    ```bash
    git submodule add git@github.com:Bertbk/academic-tools.git themes/academic-tools
    ```
  You can modify the `.gitmodules` file accordingly. 
- If, in addition to SSH, your website is automatically build through Gitlab page. You might need to add your ssh key to Gitlab variable and mofidy your `.gitlab-ci`.

### Customization

If you know a little bit about the CSS then is it quite easy, you just have to override the `.scss` files (*e.g.*  `assets/scss/thm.scss`). If you do not know about CSS but want to change the colors, have a look anyway at `assets/scss/thm.scss` file and search for the colors, you will quickly understand how it works.

## Thm (shortcode)

The [`Academic`](https://github.com/gcushen/hugo-academic/) theme provides a [nice layout (=design) for documentation](https://sourcethemes.com/academic/docs/writing-markdown-latex/). The math expression can be written mostly as in a basic LaTeX file thanks to MathJax (just set `math = true` in the frontmatter of your `.md` file). Some features were however missing for a math course, especially the "AMS Theorem environment" of LaTeX.

This is the purpose of this small "theme".

### Features

This "theme" contains [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/#readout) that mimic the LaTeX AMS Theorem environment. A shortcode is a portion of code that `Hugo` will escape from the Markdown, making it possible to call external functions inside the Markdown. It features

- Customizable design
- Different type: Theorem, Proposition, Lemma, Corollary, Definition
- Theorem naming
- Cross reference
- Multi languages
- Proof environment
- Auto numbering (using CSS)

### Example

#### Thm blocks

```md
{{< thm/thm type="theorem" name="of me" label="thm:me" >}}
This theorem proves that covfefe.
{{< /thm/thm >}}
{{< thm/proof >}}
The proof is very good. I like proof. I have big proof.
{{< /thm/proof >}}
```

leads to this

![Thm + Proof example](static/img/thm-block.png)


You can change `type="theorem"` by `proposition`, `lemma`, `corollary` or `definition`.

#### Cross reference

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

If the theorem (or definition or...) is on a different page (say `intro.md`), you can use the `page` option. In that case, the options parameters must be explicit, either inline
```hugo
 {{< thm/ref ref="thm:me" text="covfefe Theorem" page="intro.md"/>}}
```
or in a block environment
```hugo
 {{< thm/ref ref="thm:me" page="intro.md">}}
 covfefe Theorem
 {{< /thm/ref >}}
```

#### Remark

As you notice and contrary to LaTeX, the cross reference do not provide the number of the theorem. This is a little bit complicated as the numbering is done through CSS counter and I believe it is not necessary. However, if you are interested in, we can discuss about it.

## Shortcodes

### Div

Create an HTML `div` tag with `id`, `class`, `style` of your choice:
```hugo
{{< div id="my_id" class="my_class" style="text-align:center;">}}
loremp ipsum
{{< /div >}}
```

### JS

Add a `script` tag linking to `src` javascript file:
```hugo
{{< js src="link-to-js-file" />}}
```

### Button

For a short text, this shortcode can be inline (note the trailing slash) or as a block to insert (for example) icons:
```hugo
Button inline:
{{< button src="https://github.com/Bertbk/academic-tools" title="Download academic-tools!" />}}
Button as a block (with an icon):
{{< button src="https://github.com" >}}
<i class="fab fa-github"></i> Download academic-tools!
{{< /button >}}
```
This will be displayed as:

![Button example](static/img/button.png)

Other options are also available:
- `src`: path to a link
- `title`: text displayed in the button. Should be left empty if used as a block environment
- `type`: correspond to [Bootstrap predefined button styles](https://getbootstrap.com/docs/4.0/components/buttons/), by default `type=outline-primary`
- `id`: add a HTML id to the button
- `class`: add custom class name to the button

To center a button, it can for example be combined with a `{{< div style="text-align:center;">}}{{< button .../>}}{{< /div>}}`.

## Widgets

### Next Talk

#### Features

You can see an example of it on the [website of infomath](https://infomath.pages.math.cnrs.fr/).

- The content of the widget is displayed when no talk are programmed
- No new meta-data are used
- The category of the talk is displayed on the menu on the left

![next talk](static/img/next_talk.png)

Credit: Photo of the Coffee by [Mike Kenneally](https://unsplash.com/photos/tNALoIZhqVM) on Unsplash


### Workshop

#### Features

- Based on Wowchemy framework for talks, authors, ...
- The schedule is split in `session` defined by: time and duration, chairperson, location (room) and a title.
- Breaks (coffee, diner, ...) is a `type`. A break can appear several time (to avoid copy/paste) and be nicely shown with a background picture
- Multiple day (but no "parallel session" in a day (sorry))

Wanted to organize a workshop and you need a schedule plan? This widget might interests you. Below is a screen capture taking from [a workshop on wave propagation](https://jcjc_ondes.pages.math.cnrs.fr/). 

![Workshop widget](static/img/workshop.png)


#### Known problem

- Heigh size is currengly hard coded
- No Parallel session
- ExampleSite needed