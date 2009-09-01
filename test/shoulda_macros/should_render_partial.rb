def should_render_partial(partial, count = 1)
  should "render partial #{partial.inspect}" do
    assert_template :partial => partial.to_s, :count => count
  end
end
