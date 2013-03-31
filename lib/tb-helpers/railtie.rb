class TbHelpers::Railtie < Rails::Railtie
  initializer 'tb.helpers' do
    ActionView::Base.send :include, TbHelpers::Base
    ActionView::Base.send :include, TbHelpers::Components
  end
end