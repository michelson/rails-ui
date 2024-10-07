# frozen_string_literal: true

module RailsUi
  module Table
    class Component < ApplicationViewComponent
      option :data
      option :columns
      option :caption, default: -> { nil }
      option :row_id, default: -> { ->(row) { row[:id] } }
      option :data_table_id, default: -> { nil }
      option :paginate, default: -> { false }
      option :paginate_meta, default: -> { {} }
      option :headless, default: -> { false }
      option :sortable, default: -> { false }
      option :sortable_group, default: -> { nil }
      option :table_cell_classes, default: -> { 'p-4 align-middle [&:has([role=checkbox])]:pr-0' }
      option :wrapper_classes, default: -> { 'relative w-full overflow-auto' }
      option :header_background, default: -> { 'bg-muted/50' }
      option :row_background, default: -> { '' }
      option :row_border, default: -> { 'border-b' }

      def table_classes
        'w-full caption-bottom text-sm'
      end

      def thead_classes
        '[&_tr]:border-b'
      end

      def th_classes
        'h-12 px-4 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0'
      end

      def tbody_classes
        '[&_tr:last-child]:border-0'
      end

      def tr_classes
        "#{row_border} transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted"
      end

      def tfoot_classes
        'border-t bg-muted/50 font-medium [&>tr]:last:border-b-0'
      end
    end
  end
end
