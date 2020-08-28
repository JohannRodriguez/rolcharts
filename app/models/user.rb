class User < ApplicationRecord
  has_many :characters
  NULL_ATTRS = %w[impersonating].freeze
  before_save :nil_if_blank
  validate :validate_username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_writer :login

  def login
    @login || username || email
  end
  # rubocop:disable Lint/AssignmentInCondition
  # rubocop:disable Layout/EmptyLineBetweenDefs
  # rubocop:disable Style/HashSyntax
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { :value => login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
  # rubocop:enable Style/HashSyntax
  # rubocop:enable Layout/EmptyLineBetweenDefs
  # rubocop:enable Lint/AssignmentInCondition

  def validate_username
    return errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  protected

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end
end
