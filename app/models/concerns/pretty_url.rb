module Pretty_URL
  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
