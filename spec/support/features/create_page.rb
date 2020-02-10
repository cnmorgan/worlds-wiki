module Features
  def create_page(world, title)
    visit user_world_path(world.name)

    click_on 'New Page'

    fill_in 'page_title', with: title
    click_on 'Create!'
  end
end