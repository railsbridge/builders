def should_show_featured_blurb
  should_render_partial :blurb
  should_assign_to :featured_volunteer
  should_assign_to :featured_project
end
