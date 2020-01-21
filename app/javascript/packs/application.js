// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import { autocompleteExport } from '../custom/autocomplete';
import { initialize } from '../custom/editor';
import { formatToc } from '../custom/page_display';



window.jQuery = $;
window.$ = $;

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery
//= require jquery_ujs

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//window.onload = autocompleteSearch;

$(document).on("turbolinks:load", autocompleteExport.categories)
$(document).on("turbolinks:load", autocompleteExport.search)
$(document).on("turbolinks:load", autocompleteExport.admins)
$(document).on("turbolinks:load", initialize)
$(document).on("turbolinks:load", formatToc)