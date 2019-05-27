class RoomPolicy < ApplicationPolicy
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
end
