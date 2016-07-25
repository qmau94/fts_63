PublicActivity::Activity.class_eval do
  scope :by_user, ->user {where recipient: user}
  scope :by_key, ->name {where("key like ?", "#{name}")}
  scope :newest, ->{order created_at: :desc}
end
