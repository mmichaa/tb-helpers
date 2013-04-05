module ApplicationHelper
  def render_tb_helper_methode(simple_methode, simple_args)
    simple_args ||= ["Using #{simple_methode.to_s}() here"]
    simple_block = nil

    if simple_args.last.is_a?(Proc)
      simple_block = simple_args.pop
    elsif simple_args.last == :partial
      simple_args.pop
      simple_block = Proc.new { render(partial: simple_methode.to_s) }
    end

    if simple_args.count > 0
      send(simple_methode, *simple_args, &simple_block)
    else
      capture(&simple_block)
    end
  end
end
