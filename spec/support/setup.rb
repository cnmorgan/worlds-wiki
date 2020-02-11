RSpec.configure do |config|
  config.before(:each) do
    admin = create(:user, :admin)
    first_world = create(:world, name: 'Worlds Wiki', owner: admin)
    welcome_page = create(:page, title: 'Welcome', sub_wiki: first_world.sub_wiki)
  end

  config.before :all do
    ActiveRecord::Base.logger.level = 1
  end

  config.after :all do
    ActiveRecord::Base.logger.level = 0
  end
end