RSpec.configure do |config|
  config.before(:each) do
    admin = create(:user, :admin, :activated)
    first_world = create(:world, name: 'Worlds Wiki', owner: admin)
    welcome_page = create(:page, title: 'Welcome', sub_wiki: first_world.sub_wiki)
  end
end