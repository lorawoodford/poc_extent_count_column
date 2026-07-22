# POC: Adding an "Extent Count" Column

A minimal, working example of the mechanism described in
`plugins/custom_browse_search_column/README.md` for demonstration
purposes only.

This proof-of-concept plugin provides the option to add a new "Extent Count"
column to accession and/or resource browse tables.  This column counts the number
of "extents" subrecords belonging to a record, rather than simply displaying them.

## Overview

1. **`search_browse_column_plugin_config.rb`** (top-level, filename must be exact)
   - Adds an `extent_count` column to `resource` and `accession`
   - Removes the default `processing_priority` column from `resource`,
   - Demos a `condition` proc that hides the column on embedded search tables (`*.js` requests)
   - Note: Our new custom column is *not* sortable since `extent_count` isn't an actual indexed Solr
   field (it's computed in the view), Adding `:sortable => false` avoids presenting a broken sort.

2. **`frontend/views/search/_extent_count_cell.html.erb`**
   The cell renderer that follows the naming convention: `_<column_name>_cell.html.erb`.
   Lives in `frontend/views/search` in this example (not `frontend/views/resource`) because 
   it's shared across two record types. The renderer has access to `record`, the same resolved
   Solr index hash the built-in `_extents_cell.html.erb` uses.

3. **`frontend/locales/en.yml`**
   Translation key `search.<record_type>.extent_count` for the column header.  Include
   one entry per record type the column is offered on.

## How to Install

Add the plugin to your local config (e.g. `config/config.rb`), ensuring it is uncommented:

```ruby
AppConfig[:plugins] << "poc_extent_count_column"
```

1. Restart the application
2. Navigate to Preferences (Global, Repo, or Default - standard prioritization still applies)
3. Use the side bar to jump to the Resources and/or Accessions Browse Columns settings
4. Add the new "Extent Count" as a column
5. (Optionally) Confirm you no longer see the default "Processing Priority" on the Resource dropdown
6. Save your updated preferences
7. Navigate to Browse > Resources (or Accessions)
8. See your new custom "Extent Count" column

## Screenshots

Selecting the new custom column on the Resources Browse Columns dropdown on Repository Preferences: 
<img width="994" height="602" alt="Screenshot 2026-07-22 at 2 07 14 PM" src="https://github.com/user-attachments/assets/5ec3cdd7-0a44-44df-82c8-4870d2e74399" />

Viewing the new "Extent Count" column on Resource Browse screen:
<img width="1270" height="508" alt="Screenshot 2026-07-22 at 2 07 30 PM" src="https://github.com/user-attachments/assets/9d61dab2-ab66-4138-baab-2446272e1a0d" />

