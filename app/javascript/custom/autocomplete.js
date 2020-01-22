import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const searchInput = document.getElementById('search');
  const worldName = document.getElementById('world-name').dataset.worldname

  if (searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
        $.getJSON('/worlds/' + worldName + '/wiki/pages.json', { q: term }, function(data){ suggest(data); });
      },
    });
  }
};

const autotcompleteCategories = function() {
    const searchInput = document.getElementById('category_name');
    const worldName = document.getElementById('world-name').dataset.worldname

    if (searchInput) {
      new autocomplete({
        selector: searchInput,
        minChars: 1,
        source: function(term, suggest){
          $.getJSON('/worlds/' + worldName + '/wiki/categories.json', { q: term }, function(data){ suggest(data); });
        },
      });
    }
};

const autotcompleteUsers = function() {
    const searchInput = document.getElementById('admin_username');

    if (searchInput) {
      new autocomplete({
        selector: searchInput,
        minChars: 1,
        source: function(term, suggest){
          $.getJSON('/users.json', { q: term }, function(data){ suggest(data); });
        },
      });
    }
};

const autotcompleteTemplates = function() {
  const searchInput = document.getElementById('template_title');
  const username = document.getElementById('username').dataset.username

  if (searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
        $.getJSON('/users/' + username + '/templates.json', { q: term }, function(data){ suggest(data); });
      },
    });
  }
};

const autocompleteExport = { 
    search: autocompleteSearch, 
    categories: autotcompleteCategories,
    admins: autotcompleteUsers,
    templates: autotcompleteTemplates
};

export  { autocompleteExport }