class RailsUi::UserForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  # Define attributes
  attribute :name, :string
  attribute :email, :string
  attribute :url, :string
  attribute :quantity, :integer
  attribute :avatar, :string
  attribute :card_number, :string
  attribute :expiry_date, :string

  # Validations
  # validates :name, presence: true, length: { minimum: 2 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  # Custom error handling (optional)
  def error_messages_for(attribute)
    errors[attribute].join(", ")
  end
end

