# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    can([:create], :all)

    can(:manage, Block, admins: { id: user.id })
    can(:manage, Apartment, admins: { id: user.id })
    can(:manage, Payment, admins: { id: user.id })
    can(:manage, Resident, admins: { id: user.id })
    can(:manage, RentSession, admins: { id: user.id })
    can(:manage, Expenditure, admins: { id: user.id })

    can(:read, Block, viewers: { id: user.id })
    can(:read, Apartment, viewers: { id: user.id })
    can(:read, Payment, viewers: { id: user.id })
    can(:read, Resident, viewers: { id: user.id })
    can(:read, RentSession, viewers: { id: user.id })
    can(:read, Expenditure, viewers: { id: user.id })
  end

  # The first argument to `can` is the action you are giving the user
  # permission to do.
  # If you pass :manage it will apply to every action. Other common actions
  # here are :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform the action on.
  # If you pass :all it will apply to every resource. Otherwise pass a Ruby
  # class of the resource.
  #
  # The third argument is an optional hash of conditions to further filter the
  # objects.
  # For example, here the user can only update published articles.
  #
  #   can :update, Article, published: true
  #
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
end
