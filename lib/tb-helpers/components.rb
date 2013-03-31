module TbHelpers::Components
  #
  # alerts
  #

  def tb_alert_flash(key, options = nil, tag = :div, escape = true)
    return nil if flash[key].blank?

    options ||= {}
    context = delete_option_if_exists!(options, :context, key)
    closeable = delete_option_if_exists!(options, :closeable, false)
    heading = delete_option_if_exists!(options, :heading, nil)

    classes = ["alert alert-#{context}"]
    block = delete_option_if_exists!(options, :block, false)
    classes << 'alert-block' if block
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, options, nil, escape) do
      #concat icon_close_link(:data => {:dismiss => 'alert'})
      concat icon_close_button(:data => {:dismiss => 'alert'})
      concat content_tag(:h4, heading, {:class => 'alert-heading'}, true) if heading
      concat flash[key]
    end
  end

  #
  # progess bars
  #

  def tb_progress_bar(progress, options = nil)
    options ||= {}
    context = delete_option_if_exists!(options, :context, nil)
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    progresses = progress.is_a?(Array) ? progress : [progress]
    contexts = context.is_a?(Array) ? context : [context]

    classes = ['progress']
    striped = delete_option_if_exists!(options, :striped, false)
    classes << 'progress-striped' if striped
    active = delete_option_if_exists!(options, :active, false)
    classes << 'active' if active
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, options, nil, escape) do
      progresses.each_with_index do |progress, progress_idx|
        classes = ['bar']
        context = contexts[progress_idx]
        classes << "bar-#{context}" if context

        concat content_tag(tag, '', {:class => classes.join(' '), :style => "width: #{progress}%;"}, true)
      end
    end
  end

  #
  # media object
  #

  # nothing here yet

  #
  # misc
  #

  def tb_well(content = nil, options = nil, &block)
    content, options = content_or_options_with_block?(content, options, block)
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    classes = ['well']
    size = delete_option_if_exists!(options, :size, false)
    classes << "well-#{size}" if size
    set_or_prepend_option!(options, :class, classes.join(' '))

    content_tag(tag, content, options, escape)
  end

  def tb_icon_close(style, options = nil)
    tag = case style
      when :link then :a
      when :button then :button
      else raise ArgumentError.new('invalid style value')
    end
    escape = delete_option_if_exists!(options, :escape, true)

    options[:class] ||= 'close'
    if tag == :link
      options[:href] ||= '#'
    end

    content_tag(tag, '&times;'.html_safe, options, escape)
  end

  def tb_icon_close_link(options = nil)
    icon_close(:link, options)
  end

  def tb_icon_close_button(options = nil)
    icon_close(:button, options)
  end

  def tb_clearfix(options = nil)
    options ||= {}
    tag = delete_option_if_exists!(options, :tag, :div)
    escape = delete_option_if_exists!(options, :escape, true)

    set_or_prepend_option!(options, :class, 'clearfix')
    content_tag(tag, '', options, escape)
  end
end