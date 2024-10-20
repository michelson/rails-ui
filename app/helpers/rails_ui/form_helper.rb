class RailsUi::FormHelper < ActionView::Helpers::FormBuilder
  
 
  def text_field(method, options = {})
    
    wrapper_options = options.delete(:wrapper){{}}
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract if the field is required
    required = options.delete(:required) { false }

    # Extract hint text from options, default to nil if not provided
    hint_text = options.delete(:hint)

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Extract background option from options, default to false if not provided
    has_background = options.delete(:background) { false }

    # Extract icons, add-ons, and buttons for left and right sides
    icon_left_html = options.delete(:icon)
    icon_right_html = options.delete(:icon_right)
    inline_left_addon_html = options.delete(:inline_left_addon)
    inline_right_addon_html = options.delete(:inline_right_addon)
    left_addon_html = options.delete(:left_addon)
    right_addon_html = options.delete(:right_addon)
    inline_right_button_html = options.delete(:inline_right_button)
    right_button_html = options.delete(:right_button)

    # Extract errors for the field
    error_messages = object.errors[method] if object&.errors&.any?
    has_error = error_messages.present?

    rounded_class = "rounded-lg"
    rounded_class = "rounded-lg rounded-r-none border-r-none" if right_addon_html
    # Define default classes for the text field
    classes = [
      "flex h-9 w-full border #{rounded_class} px-3 py-2 text-sm text-foreground shadow-black/[.04]",
      "ring-offset-background transition-shadow placeholder:text-muted-foreground/70",
      "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
      "disabled:cursor-not-allowed disabled:opacity-50 bg-background"
    ]

    # Add error classes if there are errors
    if has_error
      classes += ["border-destructive/80 text-destructive focus-visible:border-destructive/80 focus-visible:ring-destructive/30"]
    else
      classes += ["border-input focus-visible:border-ring focus-visible:ring-ring/30"]
    end

    # Add background classes if the background option is set to true
    if has_background
      classes += ["border-transparent bg-muted shadow-none"]
    end

    # Adjust border and padding classes based on add-ons or icons
    classes << "-ml-px rounded-l-none" if left_addon_html.present?
    classes << "pl-16" if inline_left_addon_html.present?
    classes << "pl-9" if icon_left_html.present? && !inline_left_addon_html.present?
    classes << "pr-16" if inline_right_addon_html.present?
    classes << "pr-9" if icon_right_html.present? && !inline_right_addon_html.present?
    classes << "-mr-px flex-1" if inline_right_button_html.present? || right_button_html.present?
    classes << "rounded-r-none focus-visible:z-10" if right_button_html.present?

    # Merge classes with any additional classes from options
    options[:class] = "#{classes.join(' ')} #{options[:class]}".strip

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Generate the full markup with label, hint, input field, helper text, and error messages
    @template.content_tag(:div, class: "space-y-2", style: container_style, **wrapper_options) do
      # Label and hint elements
      if label_text.present? || hint_text.present?
        @template.concat(
          @template.content_tag(:div, class: "mb-2 flex justify-between gap-1") do
            label_html = label_text.present? ? @template.label_tag(input_id, label_text, class: "text-sm font-medium text-foreground mb-0") : ''
            hint_html = hint_text.present? ? @template.content_tag(:span, hint_text, class: "text-sm text-muted-foreground") : ''
            label_html.html_safe + hint_html.html_safe
          end
        )
      end

      # Input element with optional icon, add-on, or button wrapper
      if icon_left_html.present? || icon_right_html.present? || inline_left_addon_html.present? || inline_right_addon_html.present? || left_addon_html.present? || right_addon_html.present? || inline_right_button_html.present? || right_button_html.present?
        @template.concat(
          @template.content_tag(:div, class: "flex rounded-lg shadow-sm shadow-black/[.04] relative") do
            # Left add-on container with border
            left_addon_container_html = left_addon_html.present? ? @template.content_tag(:span, left_addon_html, class: "-z-10 inline-flex items-center rounded-l-lg border border-input bg-background px-3 text-sm text-muted-foreground") : ''.html_safe

            # Right add-on container with border
            right_addon_container_html = right_addon_html.present? ? @template.content_tag(:span, right_addon_html, class: "-z-10 inline-flex items-center rounded-r-lg border border-input bg-background px-3 text-sm text-muted-foreground") : ''.html_safe

            # Inline left add-on container
            inline_left_addon_container_html = inline_left_addon_html.present? ? @template.content_tag(:span, inline_left_addon_html, class: "pointer-events-none absolute inset-y-0 left-0 flex items-center justify-center pl-3 text-sm text-muted-foreground peer-disabled:opacity-50") : ''.html_safe

            # Inline right add-on container
            inline_right_addon_container_html = inline_right_addon_html.present? ? @template.content_tag(:span, inline_right_addon_html, class: "pointer-events-none absolute inset-y-0 right-0 flex items-center justify-center pr-3 text-sm text-muted-foreground peer-disabled:opacity-50") : ''.html_safe

            # Left icon container
            left_icon_container_html = icon_left_html.present? ? @template.content_tag(:div, class: "pointer-events-none absolute inset-y-0 left-0 flex items-center justify-center pl-3 text-muted-foreground/80 peer-disabled:opacity-50") do
              icon_left_html.html_safe
            end : ''.html_safe

            # Right icon container
            right_icon_container_html = icon_right_html.present? ? @template.content_tag(:div, class: "pointer-events-none absolute inset-y-0 right-0 flex items-center justify-center pr-3 text-muted-foreground/80 peer-disabled:opacity-50") do
              icon_right_html.html_safe
            end : ''.html_safe

            # Input element
            input_html = super(method, options.merge(id: input_id))

            # Inline right button container
            inline_right_button_container_html = inline_right_button_html.present? ? 
              @template.content_tag(:button, inline_right_button_html, 
              class: "absolute inset-y-px right-px flex h-full w-9 items-center 
                justify-center rounded-r-lg border border-transparent text-muted-foreground/80 
                ring-offset-background transition-shadow hover:text-foreground focus-visible:border-ring 
                focus-visible:text-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 
                focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50", 
                "aria-label": "Action") : ''.html_safe

            # Right button container
            right_button_container_html = right_button_html.present? ? @template.content_tag(:button, right_button_html, class: "inline-flex items-center rounded-r-lg border border-input bg-background px-3 text-sm font-medium text-foreground ring-offset-background transition-shadow hover:bg-accent hover:text-foreground focus:z-10 focus-visible:border-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50") : ''.html_safe

            # Concatenate all parts
            left_addon_container_html +
              inline_left_addon_container_html +
              left_icon_container_html +
              input_html +
              inline_right_addon_container_html +
              right_icon_container_html +
              right_button_container_html +
              right_addon_container_html + 
              inline_right_button_container_html
          end
        )
      else
        @template.concat(super(method, options.merge(id: input_id)))
      end

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end

      # Error messages element if there are errors
      if has_error
        error_messages.each do |error_message|
          @template.concat(
            @template.content_tag(:p, error_message, class: "mt-2 text-xs text-destructive", role: "alert", "aria-live": "polite")
          )
        end
      end
    end
  end

  def number_field_with_buttons(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Extract the variant for the buttons
    variant = options.delete(:variant) || :side_buttons

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Extract current value for the number field
    value = options[:value] || 0

    # Generate the full markup with label, number input field, and helper text
    @template.content_tag(:div, class: "space-y-2", data: {controller: "ui-number-input"}, style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, class: "text-sm font-medium text-foreground", for: input_id)
        )
      end

      # Number input group with buttons based on variant
      if variant == :side_buttons
        # Side buttons for increment and decrement
        @template.concat(
          @template.content_tag(:div, role: "group", class: "relative inline-flex h-9 w-full items-center overflow-hidden whitespace-nowrap rounded-lg border border-input text-sm shadow-sm shadow-black/[.04] ring-offset-background transition-shadow data-[focus-within]:border-ring data-[disabled]:opacity-50 data-[focus-within]:outline-none data-[focus-within]:ring-2 data-[focus-within]:ring-ring/30 data-[focus-within]:ring-offset-2") do
            # Decrement button
            decrement_button_html = @template.content_tag(:button, data: {action: "click->ui-number-input#down"}, type: "button", tabindex: "-1", "aria-label": "Decrease", "aria-controls": input_id, class: "-ml-px flex aspect-square h-[inherit] items-center justify-center rounded-l-lg border border-input bg-background text-sm text-muted-foreground/80 ring-offset-background transition-shadow hover:bg-accent hover:text-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50") do
              '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-minus" aria-hidden="true" role="presentation"><path d="M5 12h14"></path></svg>'.html_safe
            end

            # Number input field
            input_html = number_field(
              method,
              **options.merge(
                class: "no-arrows border-none w-full grow bg-background px-3 py-2 text-center tabular-nums text-foreground focus:outline-none",
                autocomplete: "off",
                inputmode: "numeric",
                spellcheck: false,
                "data-ui-number-input-target": "input",
                "aria-roledescription": "Number field"
              )
            )

            # Increment button
            increment_button_html = @template.content_tag(:button, data: {action: "click->ui-number-input#up"}, type: "button", tabindex: "-1", "aria-label": "Increase", "aria-controls": input_id, class: "-mr-px flex aspect-square h-[inherit] items-center justify-center rounded-r-lg border border-input bg-background text-sm text-muted-foreground/80 ring-offset-background transition-shadow hover:bg-accent hover:text-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50") do
              '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus" aria-hidden="true" role="presentation"><path d="M5 12h14"></path><path d="M12 5v14"></path></svg>'.html_safe
            end

            # Concatenate all parts
            decrement_button_html + input_html + increment_button_html
          end
        )
      elsif variant == :right_buttons
        # Right chevron buttons for increment and decrement
        @template.concat(
          @template.content_tag(:div, role: "group", class: "relative inline-flex h-9 w-full items-center overflow-hidden whitespace-nowrap rounded-lg border border-input text-sm shadow-sm shadow-black/[.04] ring-offset-background transition-shadow data-[focus-within]:border-ring data-[disabled]:opacity-50 data-[focus-within]:outline-none data-[focus-within]:ring-2 data-[focus-within]:ring-ring/30 data-[focus-within]:ring-offset-2") do
            # Number input field
            input_html = number_field(
              method,
              **options.merge(
                class: "no-arrows border-none flex-1 bg-background px-3 py-2 tabular-nums text-foreground focus:outline-none",
                autocomplete: "off",
                inputmode: "numeric",
                spellcheck: false,
                "data-ui-number-input-target": "input",
                "aria-roledescription": "Number field"
              )
            )

            # Increment and decrement buttons stacked vertically on the right
            button_group_html = @template.content_tag(:div, class: "flex h-[calc(100%+2px)] flex-col") do
              # Increment button
              increment_button_html = @template.content_tag(:button, data: {action: "click->ui-number-input#down"}, type: "button", tabindex: "-1", "aria-label": "Increase", "aria-controls": input_id, class: "-mr-px flex h-1/2 w-6 flex-1 items-center justify-center rounded-tr-lg border border-input bg-background text-sm text-muted-foreground/80 ring-offset-background transition-shadow hover:bg-accent hover:text-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50") do
                '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-up" aria-hidden="true" role="presentation"><path d="M18 15L12 9L6 15"></path></svg>'.html_safe
              end

              # Decrement button
              decrement_button_html = @template.content_tag(:button, data: {action: "click->ui-number-input#up"}, type: "button", tabindex: "-1", "aria-label": "Decrease", "aria-controls": input_id, class: "-mr-px -mt-px flex h-1/2 w-6 flex-1 items-center justify-center rounded-br-lg border border-input bg-background text-sm text-muted-foreground/80 ring-offset-background transition-shadow hover:bg-accent hover:text-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50") do
                '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-down" aria-hidden="true" role="presentation"><path d="M6 9L12 15L18 9"></path></svg>'.html_safe
              end

              # Concatenate increment and decrement buttons
              increment_button_html + decrement_button_html
            end

            # Concatenate input field and button group
            input_html + button_group_html
          end
        )
      end

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def file_field_with_label(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Generate the full markup with label, file input field, and helper text
    @template.content_tag(:div, class: "space-y-2", style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, class: "text-sm font-medium text-foreground", for: input_id)
        )
      end

      # File input element
      @template.concat(
        file_field(
          method,
          **options.merge(
            id: input_id,
            class: "flex h-9 w-full rounded-lg border border-input bg-background 
              text-sm shadow-sm shadow-black/[.04] ring-offset-background 
              transition-shadow placeholder:text-muted-foreground/70 
              focus-visible:border-ring focus-visible:outline-none 
              focus-visible:ring-2 focus-visible:ring-ring/30 
              focus-visible:ring-offset-2 disabled:cursor-not-allowed 
              disabled:opacity-50 p-0 pr-3 italic text-muted-foreground/70 
              file:me-3 file:h-full file:border-0 file:border-r file:border-solid 
              file:border-input file:bg-transparent file:px-3 file:text-sm 
              file:font-medium file:not-italic file:text-foreground"
          )
        )
      )

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def card_number_field(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Generate the full markup with label, card number input field, and helper text
    @template.content_tag(:div, class: "space-y-2", style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, class: "text-sm font-medium text-foreground", for: input_id)
        )
      end

      # Card number input with an icon
      @template.concat(
        @template.content_tag(:div, class: "relative") do
          # Input element
          input_html = text_field(
            method,
            **options.merge(
              id: input_id,
              label: false,
              type: "tel",
              class: "flex h-9 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm text-foreground shadow-sm shadow-black/[.04] ring-offset-background transition-shadow placeholder:text-muted-foreground/70 focus-visible:border-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 peer pl-9",
              "aria-label": "Card number",
              autocomplete: "cc-number",
              placeholder: "Card number"
            )
          )

          # Card icon element
          card_icon_html = @template.content_tag(:div, class: "pointer-events-none absolute inset-y-0 left-0 flex items-center justify-center pl-3 text-muted-foreground/80 peer-disabled:opacity-50") do
            '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-credit-card" aria-hidden="true" role="presentation"><rect width="20" height="14" x="2" y="5" rx="2"></rect><line x1="2" x2="22" y1="10" y2="10"></line></svg>'.html_safe
          end

          # Concatenate the input field and icon
          input_html + card_icon_html
        end
      )

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def expiry_date_field(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Generate the full markup with label, expiry date input field, and helper text
    @template.content_tag(:div, class: "space-y-2", style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, class: "text-sm font-medium text-foreground", for: input_id)
        )
      end

      # Expiry date input element
      @template.concat(
        text_field(
          method,
          **options.merge(
            id: input_id,
            label: false,
            type: "tel",
            class: "flex h-9 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm text-foreground shadow-sm shadow-black/[.04] ring-offset-background transition-shadow placeholder:text-muted-foreground/70 focus-visible:border-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
            "aria-label": "Expiry date in format MM YY",
            autocomplete: "cc-exp",
            placeholder: "MM/YY"
          )
        )
      )

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def cvc_field(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Generate the full markup with label, CVC input field, and helper text
    @template.content_tag(:div, class: "space-y-2", style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, class: "text-sm font-medium text-foreground", for: input_id)
        )
      end

      # CVC input element
      @template.concat(
        text_field(
          method,
          **options.merge(
            label: false,
            id: input_id,
            type: "tel",
            class: "flex h-9 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm text-foreground shadow-sm shadow-black/[.04] ring-offset-background transition-shadow placeholder:text-muted-foreground/70 focus-visible:border-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
            "aria-label": "CVC",
            autocomplete: "cc-csc",
            placeholder: "CVC"
          )
        )
      )

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def date_time_picker_field(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Extract segment options for date and time. Default all segments to true unless explicitly set to false.
    include_day = options.key?(:day) ? options.delete(:day) : true
    include_month = options.key?(:month) ? options.delete(:month) : true
    include_year = options.key?(:year) ? options.delete(:year) : true
    include_hour = options.key?(:hour) ? options.delete(:hour) : true
    include_minute = options.key?(:minute) ? options.delete(:minute) : true
    include_day_period = options.key?(:day_period) ? options.delete(:day_period) : true

    # Generate the full markup with label and date-time input field segments
    @template.content_tag(:div, class: "space-y-2", data: { controller: "ui-date-time-picker" }) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:span, label_text, class: "text-sm font-medium text-foreground", id: "date-time-picker-label")
        )
      end

      # Date and Time picker input group with day, month, year, hour, minute, and dayPeriod segments
      @template.concat(
        @template.content_tag(:div, role: "group", "aria-labelledby": "date-time-picker-label", class: "relative inline-flex h-9 w-full items-center overflow-hidden whitespace-nowrap rounded-lg border border-input bg-background px-3 py-2 text-sm shadow-sm shadow-black/[.04] ring-offset-background transition-shadow data-[focus-within]:border-ring data-[disabled]:opacity-50 data-[focus-within]:outline-none data-[focus-within]:ring-2 data-[focus-within]:ring-ring/30 data-[focus-within]:ring-offset-2") do
          # Day segment (optional)
          if include_day
            day_html = @template.content_tag(:div, "––", role: "spinbutton", "aria-valuenow": "0", "aria-valuemin": "1", "aria-valuemax": "31", 
            tabindex: "0", data: {
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#incrementSegment keyup.down->ui-date-time-picker#decrementSegment",
              ui_date_time_picker_target: "day", type: "day"
            },
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next", inputmode: "numeric")
            @template.concat(day_html)
          end

          # Literal separator (optional, only if day and month are present)
          if include_day && include_month
            literal_html = @template.content_tag(:div, "/", aria_hidden: "true", class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed", data: { readonly: "true", type: "literal" })
            @template.concat(literal_html)
          end

          # Month segment (optional)
          if include_month
            month_html = @template.content_tag(:div, "––", role: "spinbutton", "aria-valuenow": "0", "aria-valuemin": "1", "aria-valuemax": "12", 
            tabindex: "0", data: {
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#incrementSegment keyup.down->ui-date-time-picker#decrementSegment",
              ui_date_time_picker_target: "month", type: "month"
            },
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next", inputmode: "numeric")
            @template.concat(month_html)
          end

          # Literal separator (optional, only if month and year are present)
          if include_month && include_year
            literal_html = @template.content_tag(:div, "/", aria_hidden: "true", class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed", data: { readonly: "true", type: "literal" })
            @template.concat(literal_html)
          end

          # Year segment (optional)
          if include_year
            year_html = @template.content_tag(:div, "––", role: "spinbutton", "aria-valuenow": "0", tabindex: "0", data: {
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#incrementSegment keyup.down->ui-date-time-picker#decrementSegment",
              ui_date_time_picker_target: "year", type: "year"
            },
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next", inputmode: "numeric")
            @template.concat(year_html)
          end

          # Literal space separator (optional, if date and time segments are mixed)
          if (include_year || include_month || include_day) && (include_hour || include_minute || include_day_period)
            space_html = @template.content_tag(:div, " ", aria_hidden: "true", class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed", data: { readonly: "true", type: "literal" })
            @template.concat(space_html)
          end

          # Hour segment (optional)
          if include_hour
            hour_html = @template.content_tag(:div, "––", role: "spinbutton", "aria-valuenow": "0", "aria-valuemin": "1", "aria-valuemax": "12", 
            tabindex: "0", data: { 
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#incrementSegment keyup.down->ui-date-time-picker#decrementSegment",
              ui_date_time_picker_target: "hour", type: "hour"
            }, 
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next", inputmode: "numeric")
            @template.concat(hour_html)
          end

          # Literal separator (optional, only if hour and minute are present)
          if include_hour && include_minute
            literal_html = @template.content_tag(:div, ":", aria_hidden: "true", class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed", data: { readonly: "true", type: "literal" })
            @template.concat(literal_html)
          end

          # Minute segment (optional)
          if include_minute
            minute_html = @template.content_tag(:div, "––", role: "spinbutton", "aria-valuenow": "0", "aria-valuemin": "0", "aria-valuemax": "59", 
            tabindex: "0", data: {
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#incrementSegment keyup.down->ui-date-time-picker#decrementSegment",
              ui_date_time_picker_target: "minute", type: "minute"
            }, 
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next", inputmode: "numeric")
            @template.concat(minute_html)
          end

          # AM/PM segment (optional)
          if include_day_period
            day_period_html = @template.content_tag(:div, "AM", role: "spinbutton", "aria-valuetext": "AM", 
            tabindex: "0", data: {
              action: "focus->ui-date-time-picker#focusSegment blur->ui-date-time-picker#blurSegment keydown.up->ui-date-time-picker#toggleDayPeriod click->ui-date-time-picker#toggleDayPeriod",
              ui_date_time_picker_target: "dayPeriod", type: "dayPeriod"
            },
            class: "inline rounded p-0.5 text-foreground caret-transparent outline outline-0 data-[disabled]:cursor-not-allowed data-[focused]:bg-accent data-[invalid]:bg-destructive", 
            contenteditable: "true", spellcheck: "false", autocorrect: "off", enterkeyhint: "next")
            @template.concat(day_period_html)
          end
        end
      )

      # Helper text element (optional)
      if options[:helper].present?
        @template.concat(
          @template.content_tag(:p, options[:helper], class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end

  def email_field(method, options = {})
    default_classes = "border rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 w-full"
    options[:class] = "#{default_classes} #{options[:class]}"
    super(method, options)
  end

  def textarea_field(method, options = {})
    # Extract label option from options. Default is true, unless explicitly set to false.
    label_option = options.key?(:label) ? options.delete(:label) : true

    # Set default label text if label is not false
    label_text = label_option.is_a?(String) ? label_option : method.to_s.humanize if label_option

    # Set a default ID if not provided
    input_id = options[:id] || "#{object_name}_#{method}"

    # Extract ring color CSS variable from options
    ring_color = options.delete(:ring_color)

    # Inline style for ring color if provided
    container_style = ring_color.present? ? "--ring: #{ring_color}" : ""

    # Extract helper text from options, default to nil if not provided
    helper_text = options.delete(:helper)

    # Extract placeholder text from options, default to nil if not provided
    placeholder_text = options.delete(:placeholder)

    # Extract rows option for the textarea, default to 3 if not provided
    rows = options.delete(:rows) || 3

    # Extract disabled option
    disabled = options.delete(:disabled) { false }

    # Define default classes for the textarea
    default_classes = "w-full rounded-lg border border-input bg-background px-3 py-2 text-sm text-foreground shadow-sm shadow-black/[.04] ring-offset-background transition-shadow placeholder:text-muted-foreground/70 focus-visible:border-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/30 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"

    # Merge default classes with any additional classes from options
    options[:class] = "#{default_classes} #{options[:class]}".strip

    # Set other textarea attributes
    options.merge!(
      id: input_id,
      rows: rows,
      placeholder: placeholder_text,
      disabled: disabled
    )

    # Generate the full markup with label, textarea, and helper text
    @template.content_tag(:div, class: "space-y-2", style: container_style) do
      # Label element
      if label_text.present?
        @template.concat(
          @template.content_tag(:label, label_text, for: input_id, class: "text-sm font-medium text-foreground")
        )
      end

      # Textarea element
      @template.concat(
        @template.text_area(object_name, method, options)
      )

      # Helper text element if helper_text is present
      if helper_text.present?
        @template.concat(
          @template.content_tag(:p, helper_text, class: "mt-2 text-xs text-muted-foreground", role: "region", "aria-live": "polite")
        )
      end
    end
  end


  # Add other input methods here as needed
end