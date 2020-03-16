#!/usr/bin/env bash
# Move this file on the root of your website folder and launch it
# > mv update_html.sh ..
# > sh update_html.sh
# Keep this file to update it!
mkdir -p layouts/partials/shortcodes i18n assets/css
git clone https://github.com/Bertbk/hugo-thm.git
cp -r hugo-thm/layouts/shortcodes/thm layouts/shortcodes/thm
cp -r hugo-thm/i18n/thm i18n/thm
cp hugo-thm/assets/css/thm.css assets/css/thm.css
rm -rf hugo-thm