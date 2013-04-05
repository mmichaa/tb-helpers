class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    flash[:notice] = "using tb_alert_flash() here"

    @simple_methodes = {
      tb_lead: nil,
      tb_small: nil,
      tb_bold: nil,
      tb_italics: nil,
      tb_address: nil,
      tb_abbreviation: nil,
      tb_address: nil,
      tb_blockquote: nil,
      tb_code_inline: nil,
      tb_code_block: nil,
      tb_table: [:partial],
      tb_form_for: [:partial],
      tb_button: nil,
      tb_button_group: [nil, :partial],
      tb_link_button_to: ['Using tb_link_button_to() here', root_path],
      tb_icon: [:partial],
      tb_alert_flash: [:notice, {context: :success}],
      tb_progress_bar: ["50"],
      tb_well: nil,
    }
  end
end
