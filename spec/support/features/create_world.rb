module Features
  def create_world(name)
    click_on 'New World'

    fill_in 'world_name', with: name
    click_on 'Create!'
  end
end