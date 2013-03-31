module TbHelpers::Base
  ALIGNMENT_CLASSES = {:left => 'text-left', :center => 'text-center', :right => 'text-right'}
  EMPHASIS_CLASSES = {:success => 'text-success', :error => 'text-error', :warning => 'text-warning', :info => 'text-info', :muted => 'muted'}
  TABLE_CLASSES = {:striped => 'table-striped', :bordered => 'table-bordered', :hover => 'table-hover', :condensed => 'table-condensed'}
  TABLE_ROW_CLASSES = {:success => 'success', :error => 'error', :warning => 'warning', :info => 'info'}
  FORM_CLASSES = {:search => 'form-search', :inline => 'form-inline', :horizontal => 'form-horizontal'}
  INPUT_SIZES = {:mini => 'input-mini', :small => 'input-small', :medium => 'input-medium', :large => 'input-large', :xlarge => 'input-xlarge', :xxlarge => 'input-xxlarge'}
  SPAN_SIZES = {} # span1 - span12
  BUTTON_SIZES = {:mini => 'btn-mini', :small => 'btn-small', :large => 'btn-large'}

  #
  # typography
  #

  def tb_lead(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :p)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['lead']
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, content, options, escape)
  end

  def tb_emphasis(style, content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = case style
      when :small then :small
      when :bold then :strong
      when :italics then :em
      when nil then delete_option_if_exists!(options, :tag, :span)
      else raise ArgumentError.new('invalid style value')
    end
    escape = delete_option_if_exists!(options, :escape, true)

    EMPHASIS_CLASSES.each do |class_sym, class_name|
      class_val = delete_option_if_exists!(options, class_sym, false)
      classes << class_name if class_val
    end
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, content, options, escape)
  end

  def tb_small(content = nil, options = nil, &block)
    emphasis(:small, content, options, &block)
  end

  def tb_bold(content = nil, options = nil, &block)
    emphasis(:bold, content, options, &block)
  end

  def tb_italics(content = nil, options = nil, &block)
    emphasis(:italics, content, options, &block)
  end
  alias :tb_italic :tb_italics

  def tb_abbreviation(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :abbr)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, content, options, escape)
  end
  alias :tb_abbr :tb_abbreviation

  def tb_address(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :address)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, content, options, escape)
  end

  def tb_blockquote(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :blockquote)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, content, options, escape)
  end

  #
  # code
  #

  def tb_code_inline(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :code)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, content, options, escape)
  end

  def tb_code_block(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :pre)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = []
    scrollable = delete_option_if_exists!(options, :scrollable, true)
    classes << 'pre-scrollable' if scrollable
    set_or_prepend_option!(options, :class, classes.join(' ')) unless classes.empty?

    content_tag(tag, content, options, escape)
  end

  #
  # tables
  #

  def tb_table(options, &block)
    options ||= {}
    tag = delete_option_if_exists!(options, :tag, :table)
    escape = delete_option_if_exists!(options, :escape, true)
    caption = delete_option_if_exists!(options, :caption, nil)

    classes = ['table']
    TABLE_CLASSES.each do |class_sym, class_name|
      class_val = delete_option_if_exists!(options, class_sym, false)
      classes << class_name if class_val
    end
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, options, nil, escape) do
      concat content_tag(:caption, caption, {}, true) if caption
      concat capture(&block)
    end
  end

  def tb_table_row(options, &block)
    options ||= {}
    tag = delete_option_if_exists!(options, :tag, :tr)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = []
    TABLE_ROW_CLASSES.each do |class_sym, class_name|
      class_val = delete_option_if_exists!(options, class_sym, false)
      classes << class_name if class_val
    end
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, options, nil, escape, &block)
  end

  #
  # forms
  #

  def tb_fieldset(options = nil, &block)
    options ||= {}
    tag = delete_option_if_exists!(options, :tag, :fieldset)
    escape = delete_option_if_exists!(options, :escape, true)
    legend = delete_option_if_exists!(options, :legend, nil)

    content_tag(tag, options, nil, escape) do
      concat content_tag(:legend, legend, {}, true) if legend
      concat capture(&block)
    end
  end

  def tb_control_group(options = nil, &block)
    options ||= {}
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['control-group']
    context = delete_option_if_exists!(options, :context, nil)
    classes << context.to_s if context

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, options, nil, escape, &block)
  end

  def tb_controls(options = nil, &block)
    options ||= {} # set_or_prepend_option!(options, :class, 'controls')
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['controls']
    row = delete_option_if_exists!(options, :row, false)
    classes << 'controls-row' if row

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, options, nil, escape, &block)
  end

  def tb_control_label(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    options = set_or_prepend_option!(options, :class, 'control-label')
    tag = delete_option_if_exists!(options, :tag, :label)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, content, options, escape)
  end

  def tb_checkbox_label(options = nil, &block)
    options ||= {} # set_or_prepend_option!(options, :class, 'checkbox')
    tag = delete_option_if_exists!(options, :tag, :label)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['checkbox']
    inline = delete_option_if_exists!(options, :inline, false)
    classes << 'inline' if inline

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, options, nil, escape, &block)
  end

  def tb_radio_label(options = nil, &block)
    options ||= {} # set_or_prepend_option!(options, :class, 'radio')
    tag = delete_option_if_exists!(options, :tag, :label)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['radio']
    inline = delete_option_if_exists!(options, :inline, false)
    classes << 'inline' if inline

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, options, nil, escape, &block)
  end

  def tb_input_addon(style, options = nil, &block)
    options = case style
      when :prepend then set_or_prepend_option!(options, :class, 'input-prepend')
      when :append then set_or_prepend_option!(options, :class, 'input-append')
      when :combined then set_or_prepend_option!(options, :class, 'input-prepend input-append')
      else raise ArgumentError.new('invalid style value')
    end
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)
    addon = delete_option_if_exists!(options, :addon, nil)

    content_tag(tag, options, nil, escape) do
      if style == :prepend || style == :combined
        prepend = addon.is_a?(Array) ? addon[0] : addon
        concat content_tag(:span, prepend, {:class => 'add-on'}, true) if prepend
      end
      concat capture(&block)
      if style == :append || style == :combined
        append = addon.is_a?(Array) ? addon[1] : addon
        concat content_tag(:span, append, {:class => 'add-on'}, true) if append
      end
    end
  end

  def tb_input_addon_prepend(options = nil, &block)
    input_addon(:prepend, options, &block)
  end

  def tb_input_addon_append(options = nil, &block)
    input_addon(:append, options, &block)
  end

  def tb_input_addon_pre_and_append(options = nil, &block)
    input_addon(:combined, options, &block)
  end
  alias :tb_input_addon_combined :tb_input_addon_pre_and_append

  def tb_input_uneditable(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :span)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = []
    size = delete_option_if_exists!(options, :size, nil)
    classes << "input-#{size}" if size
    classes << 'uneditable-input'

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, content, options, escape)
  end

  def tb_form_actions(options = nil, &block)
    options = set_or_prepend_option!(options, :class, 'form-actions')
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, options, nil, escape, &block)
  end

  def tb_input_help(style, content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :span)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = []
    classes << case style
      when :inline then 'help-inline'
      when :block then 'help-block'
      else raise ArgumentError.new('invalid style value')
    end

    set_or_prepend_option!(options, :class, classes.join(' '))
    content_tag(tag, content, options, escape)    
  end

  def tb_input_help_inline(content = nil, options = nil, &block)
    input_help(:inline, content = nil, options = nil, &block)
  end

  def tb_input_help_block(content = nil, options = nil, &block)
    input_help(:block, content = nil, options = nil, &block)
  end

  #
  # buttons
  #

  def tb_button_group(options = nil, &block)
    options = set_or_prepend_option!(options, :class, 'btn-group')
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, options, nil, escape, &block)
  end

  def tb_button(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['btn']
    context = delete_option_if_exists!(options, :context, nil)
    classes << "btn-#{context}" if context
    size = delete_option_if_exists!(options, :size, nil)
    classes << "btn-#{size}" if size
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, content, options, escape)
  end
  alias :tb_btn :tb_button

  def tb_link_button_to(*args, &block)
    if block_given?
      options = args[1] ||= {}
    else
      options = args[2] ||= {}
    end
    classes = ['btn']
    context = delete_option_if_exists!(options, :context, nil)
    classes << "btn-#{context}" if context
    size = delete_option_if_exists!(options, :size, nil)
    classes << "btn-#{size}" if size
    disabled = delete_option_if_exists!(options, :disabled, false)
    classes << "disabled" if disabled
    set_or_prepend_option!(options, :class, classes.join(' '))
    link_to(*args, &block)
  end
  alias :tb_button_link_to :tb_link_button_to

  #
  # images
  #

  # nothing here yet

  #
  # icons by glyphicons
  #

  def tb_icon_black(name, options = nil)
    icon_name = name.to_s.starts_with?('icon-') ? name.to_s : "icon-#{name}"
    options = set_or_prepend_option!(options, :class, icon_name)
    tag = delete_option_if_exists!(options, :tag, :i)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, nil, options, escape)
  end
  alias :tb_icon :tb_icon_black

  def tb_icon_white(name, options = nil)
    icon_name = name.to_s.starts_with?('icon-') ? "#{name} icon-white" : "icon-#{name} icon-white"
    options = set_or_prepend_option!(options, :class, icon_name)
    tag = delete_option_if_exists!(options, :tag, :i)
    escape = delete_option_if_exists!(options, :escape, true)

    content_tag(tag, nil, options, escape)
  end

  #
  # protected helper methods
  #

  protected

  def delete_option_if_exists!(options, key, fallback=nil)
    options.has_key?(key) ? options.delete(key) : fallback
  end

  def set_or_prepend_option!(options, key, value)
    options ||= {}
    unless options.has_key?(:class)
      options[:class] = value
    else
      options[:class] = "#{value} #{options[:class]}"
    end
    options
  end

  def content_or_options_with_block?(content_or_options_with_block, options, &block)
    if content_or_options_with_block.is_a?(Hash)
      content = capture(&block)
      options = content_or_options_with_block
    else
      content = content_or_options_with_block
      options ||= {}
    end
    return content, options
  end
end