# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can [ :read, :create ], Book
    can [ :update, :destroy ], Book, user: user

    can :read, Genre

    can :read, User
    can :update, User, id: user.id

    return unless user.admin?
    can :manage, :all
  end
end
