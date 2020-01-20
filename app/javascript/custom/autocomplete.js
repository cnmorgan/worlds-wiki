import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const data = JSON.parse(document.getElementById('search-data-pages').dataset.pages)
  const searchInput = document.getElementById('search');

  if (data && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = data;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
};

const autotcompleteCategories = function() {
    const dataHolder = document.getElementById('search-data-categories')
    
    if(dataHolder){
        
        const data = JSON.parse(dataHolder.dataset.categories)
        const searchInput = document.getElementById('category_name');
    
        if (data && searchInput) {
        new autocomplete({
            selector: searchInput,
            minChars: 1,
            source: function(term, suggest){
                term = term.toLowerCase();
                const choices = data;
                const matches = [];
                for (let i = 0; i < choices.length; i++)
                    if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
                suggest(matches);
            },
        });
        }
    }
};

const autotcompleteUsers = function() {
    const dataHolder = document.getElementById('search-data-users')
    
    if(dataHolder){
        
        const data = JSON.parse(dataHolder.dataset.users)
        const searchInput = document.getElementById('admin_username');
    
        if (data && searchInput) {
        new autocomplete({
            selector: searchInput,
            minChars: 1,
            source: function(term, suggest){
                console.log(term)
                term = term.toLowerCase();
                const choices = data;
                const matches = [];
                for (let i = 0; i < choices.length; i++)
                    if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
                suggest(matches);
            },
        });
        }
    }
};

const autocompleteExport = { 
    search: autocompleteSearch, 
    categories: autotcompleteCategories,
    admins: autotcompleteUsers
};

export  { autocompleteExport }