# MODX CMP boilerplate without ExtJS

This is a simple [MODX](https://modx.com/) CMP boilerplate which does not require [ExtJS](https://docs.modx.com/3.x/en/extending-modx/custom-manager-pages/modext). Use it as a starting point for your own projects if you need a custom view in the MODX Manager. It's basic HTML. It uses the MODX CSS classes and the [CurlyFramework](https://curlyframe.work/) utility-first CSS framework, as well as [Alpine.js AJAX](https://alpine-ajax.js.org/). However, feel free to use whatever you want, such as [HTMX](https://htmx.org/) and [Tailwind](https://tailwindcss.com/), for example. 

<img width="1558" height="986" alt="image" src="https://github.com/user-attachments/assets/11107de9-d6b2-4c18-927d-fd517ee5b0d6" />

There are [collections](https://extras.modx.com/package/collections) with limited custom filtering and [MIGX](https://extras.modx.com/package/migx) with an old codebase. ExtJS is also quite old. So I tried a different approach, using the same tools for the front end and the back end, like [Fenom](https://docs.modx.pro/en/components/pdotools/parser#fenom-templating-engine) templating.

## Installation

1. Copy the folder and files to your MODX project.
2. Run `gitify build` to add a namespace and create a MODX Manager menu item for the CMP.
3. Build the CMP database schema and table using the command `php core/components/cmp/_build/database.php`.
