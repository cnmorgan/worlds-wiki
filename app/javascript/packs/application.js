import "core-js/stable";
import "regenerator-runtime/runtime";
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("../src/application.scss")
import { autocompleteExport } from '../custom/autocomplete';
import { initialize } from '../custom/editor';
import { formatToc } from '../custom/page_display';

window.jQuery = $;
window.$ = $;

$(document).on("turbolinks:load", autocompleteExport.categories)
$(document).on("turbolinks:load", autocompleteExport.search)
$(document).on("turbolinks:load", autocompleteExport.admins)
$(document).on("turbolinks:load", autocompleteExport.templates)
$(document).on("turbolinks:load", autocompleteExport.pages)
$(document).on("turbolinks:load", initialize)
$(document).on("turbolinks:load", formatToc)