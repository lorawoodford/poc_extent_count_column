module SearchAndBrowseColumnPlugin
  def self.config
    {
      'resource' => {
        :add => {
          # minimal entry: just point at a column name. Since there's no indexed
          # Solr field called "extent_count", it can't be sorted -- we compute the
          # value in the cell view instead (see frontend/views/search/_extent_count_cell.html.erb)
          'extent_count' => {
            :field => 'extent_count',
            :sortable => false,
            # only show this column on the dedicated resources browse/search page,
            # not on embedded search results tables (e.g. linked records widgets)
            condition: proc { |context| context.request.path !~ /search.js/ }
          }
        },
        # We can also remove a column.  Processing_priority is on by default
        # for resources, but this takes it out of the list of options
        :remove => ['processing_priority']
      },
      'accession' => {
        :add => {
          'extent_count' => {
            :field => 'extent_count',
            :sortable => false,
            condition: proc { |context| context.request.path !~ /search.js/ }
          }
        }
      }
    }
  end
end
