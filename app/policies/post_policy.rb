class PostPolicy < ApplicationPolicy
  def create?
    check_admin
  end

  def new?
    check_admin
  end

  def update?
    check_admin
  end

  def edit?
    update?
  end

  def destroy?
    check_admin
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
